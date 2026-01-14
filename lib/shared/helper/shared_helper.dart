import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:lottie/lottie.dart';
import 'package:mozaic_loyalty_sdk/core/utils/app_log.dart';
import 'package:mozaic_loyalty_sdk/shared/widgets/bottom_widget.dart';
import 'package:mozaic_loyalty_sdk/shared/widgets/button_widget.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/constants/constants.dart';
import '../../core/sdk/sdk_routes.dart';
import '../../core/utils/theme.dart';
import '../../features/branch/domain/entities/branch_details.dart';
import '../../injection_container.dart';
import '../../mozaic_loyalty_sdk.dart';
import 'shared_preferences_storage.dart';

class SharedHelper<T> {
  static String getSecondDurationFormat(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return twoDigitSeconds;
  }

  Future<void> closeAllDialogs() async {
    SnackbarController.cancelAllSnackbars();

    if (MozaicLoyaltySDK.settings.hostAppUseGetx == false) {
      Get.until((_) => !Get.isDialogOpen!);
      Get.until((_) => !Get.isBottomSheetOpen!);
    } else {
      while (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) {
        Get.back(id: 1, closeOverlays: true);
        await Future.delayed(const Duration(milliseconds: 50));
        if (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) {
          final context = MozaicLoyaltySDK.sdkNavKey.currentContext;
          if (context != null) {
            Navigator.of(context, rootNavigator: true).pop();
          }
        }
        await Future.delayed(const Duration(milliseconds: 50));
      }
    }
  }

  static String getNumberFormat(num number, {bool isCurrency = false}) {
    if (isCurrency) {
      return intl.NumberFormat("#,##0.00").format(number);
    }
    if (number == number.toInt()) {
      return intl.NumberFormat("#,###").format(number);
    } else if (number < 1 && number > -1) {
      return number.toStringAsFixed(3).replaceAll(RegExp(r"0+$"), "").replaceAll(RegExp(r"\.$"), "");
    } else {
      return number.toStringAsFixed(3).replaceAll(RegExp(r"0+$"), "").replaceAll(RegExp(r"\.$"), "");
    }
  }

  Future<bool> isUserLoggedIn() async {
    return sl<SharedPreferencesStorage>().getIsUserLoggedIn();
  }

  void needLogin(Function() function) async {
    if (await isUserLoggedIn()) {
      function();
    } else {
      SharedHelper().bottomSheet(
        BottomWidget(
          title: "title".tr,
          description: 'pleaseLogin'.tr,
          onCancel: () {
            SharedHelper().closeAllDialogs();
          },
          confirmText: 'login'.tr,
          onConfirm: () {
            SharedHelper().closeAllDialogs();
            SDKNav.offAllNamed(RouteConstant.authPage);
          },
        ),
      );
    }
  }

  static String dateFormatToString(DateTime dateTime, {bool withTime = false}) {
    intl.DateFormat dateFormat;
    if (withTime) {
      dateFormat = intl.DateFormat("yyyy-MM-dd hh:mm a");
    } else {
      dateFormat = intl.DateFormat("dd-MM-yyyy");
    }

    return dateFormat.format(dateTime);
  }

  void bottomSheet(Widget widget, {bool isScrollControlled = false}) {
    Get.bottomSheet(
      widget,
      isScrollControlled: isScrollControlled,
      backgroundColor: AppTheme.bgThemeColor,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.r), topRight: Radius.circular(12.r)),
      ),
    );
  }

  String formatDuration({String? time}) {
    intl.DateFormat f = intl.DateFormat('HH:mm:ss');
    if (time != null) {
      DateTime formattedTime = f.parse(time);
      String formattedTime12 = appLanguage == 'ar'
          ? (intl.DateFormat.jm().format(formattedTime)).toLowerCase().replaceAll('am', 'صباحاً').replaceAll('pm', 'مساءً')
          : intl.DateFormat.jm().format(formattedTime);
      return formattedTime12;
    } else {
      return "";
    }
  }

  void scaleDialog(Widget widget, {bool dismissible = true, double horizontal = 0}) {
    Get.generalDialog(
      navigatorKey: MozaicLoyaltySDK.settings.hostAppUseGetx ? Get.nestedKey(1) : MozaicLoyaltySDK.sdkNavKey,
      barrierDismissible: dismissible,
      barrierLabel: "appName".tr,
      barrierColor: AppTheme.bgThemeColor.withOpacity(.75),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (ctx, a1, a2) => const SizedBox.shrink(),
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: horizontal),
          child: Transform.scale(scale: curve, child: widget),
        );
      },
    );
  }

  void actionDialog(
    String title,
    String body, {
    VoidCallback? confirm,
    VoidCallback? cancel,
    String? confirmText,
    String? cancelText,
    String? image,
    bool hasImage = false,
    bool dismissible = true,
    bool isCenter = false,
    bool isRowStyle = true,
    bool isLocalImage = false,
    bool isLottieImage = false,
    bool noCancel = false,
    double? height,
  }) {
    scaleDialog(
      PopScope(
        canPop: true,
        child: AlertDialog(
          insetPadding: const EdgeInsets.all(8),
          contentPadding: const EdgeInsets.all(0),
          backgroundColor: AppTheme.bgThemeColor,
          shape: RoundedRectangleBorder(
            borderRadius: AppTheme.bigBorderRadius,
            side: BorderSide(color: AppTheme.primaryColor, width: 2),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                if (hasImage)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: height ?? Get.height * .3,
                            child: ClipRRect(
                              borderRadius: AppTheme.borderRadius,
                              child: isLocalImage
                                  ? isLottieImage
                                        ? Lottie.asset(image!)
                                        : Image.asset(image!, fit: BoxFit.cover)
                                  : Image.network(image!, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: 12),
                if (title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title.tr,
                            textAlign: isCenter ? TextAlign.center : TextAlign.start,
                            style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16, isBold: true),
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          body.tr,
                          textAlign: isCenter ? TextAlign.center : TextAlign.start,
                          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            isRowStyle
                ? Row(
                    children: [
                      if (!noCancel)
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  title: (cancelText != null ? cancelText.tr : 'cancel'.tr),
                                  function: cancel ?? closeAllDialogs,
                                  isDoneBtn: false,
                                  isSmall: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (!noCancel) SizedBox(width: 10),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: AppButton(title: (confirmText != null ? confirmText.tr : 'confirm'.tr), function: confirm!, isSmall: true),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      if (!noCancel)
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                title: (cancelText != null ? cancelText.tr : 'cancel'.tr),
                                function: cancel ?? closeAllDialogs,
                                isDoneBtn: false,
                                isSmall: true,
                              ),
                            ),
                          ],
                        ),
                      if (!noCancel) SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: AppButton(title: (confirmText != null ? confirmText.tr : 'confirm'.tr), function: confirm!, isSmall: true),
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
      dismissible: dismissible,
      horizontal: 30,
    );
  }

  void errorSnackBar(String message, {int durationInSeconds = 8, bool closeOne = false}) {
    double progressValue = 0.0;
    DateTime startTime = DateTime.now();
    Timer? progressTimer;
    Get.snackbar(
      message,
      "",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppTheme.errorColor,
      colorText: Colors.white,
      borderRadius: 12,
      margin: EdgeInsets.all(16),
      duration: Duration(seconds: durationInSeconds),
      isDismissible: false,
      messageText: StatefulBuilder(
        builder: (context, setState) {
          progressTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
            if (!context.mounted) {
              timer.cancel();
              return;
            }

            final elapsedTime = DateTime.now().difference(startTime).inMilliseconds;
            progressValue = elapsedTime / (durationInSeconds * 1000);

            setState(() {
              if (progressValue >= 1.0) {
                progressValue = 1.0;
                timer.cancel();
              }
            });
          });

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8),
              LinearProgressIndicator(value: progressValue, valueColor: AlwaysStoppedAnimation<Color>(Colors.white), backgroundColor: Colors.white12),
            ],
          );
        },
      ),
      icon: Icon(Icons.error, color: AppTheme.primaryColor),
      mainButton: TextButton(
        onPressed: () {
          closeOne ? SDKNav.back() : SharedHelper().closeAllDialogs();
        },
        child: Icon(Icons.close, color: AppTheme.primaryColor),
      ),
    );

    Future.delayed(Duration(seconds: durationInSeconds), () {
      if (progressTimer?.isActive ?? false) {
        progressTimer?.cancel();
      }
    });
  }

  static bool hasTextOverflow(String text, TextStyle style, {double minWidth = 0, double maxWidth = double.infinity, int maxLines = 2}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    if (kDebugMode) {
      appLog("object${textPainter.didExceedMaxLines}");
    }
    return textPainter.didExceedMaxLines;
  }

  bool isRTL(String text) {
    return intl.Bidi.detectRtlDirectionality(text) && isFirstCharacterArabic(text);
  }

  bool isFirstCharacterArabic(String text) {
    if (text.isEmpty) return false;
    return text.codeUnitAt(0) >= 0x0600 && text.codeUnitAt(0) <= 0x06FF;
  }

  successfullySnackBar(String message, {Icon? icon}) {
    Fluttertoast.cancel().then((value) {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: AppTheme.textColor,
        textColor: AppTheme.bgThemeColor,
        fontSize: 16.0,
      );
    });
  }

  Future<T> serverErrorDialog({required Future<T> Function() request}) async {
    final completer = Completer<T>();
    scaleDialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(8),
          contentPadding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            side: BorderSide(color: AppTheme.blackColor.withOpacity(.2), width: 2),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "somethingWrong".tr,
                      textAlign: TextAlign.center,
                      style: AppTheme.textStyle(color: AppTheme.blackColor, size: AppTheme.size18, isBold: true),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          "pleaseTryAgain".tr,
                          textAlign: TextAlign.center,
                          style: AppTheme.textStyle(color: AppTheme.blackColor, size: AppTheme.size16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: Get.height * .4,
                  width: Get.width,
                  child: ClipRRect(borderRadius: AppTheme.borderRadius, child: Lottie.asset(AssetsConsts.serverError)),
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            Column(
              children: [
                Row(
                  children: [Expanded(child: Container(height: .3, color: Colors.white))],
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        title: "tryAgain".tr,
                        function: () {
                          completer.complete(request());
                          SDKNav.back();
                        },
                        isSmall: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      dismissible: false,
      horizontal: 30,
    );
    return completer.future;
  }

  Future<T> noInternetDialog({required Future<T> Function() request}) async {
    SharedHelper().closeAllDialogs();
    final completer = Completer<T>();
    SharedHelper().scaleDialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          backgroundColor: AppTheme.bgThemeColor,
          insetPadding: const EdgeInsets.all(8),
          contentPadding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            side: BorderSide(color: AppTheme.blackColor.withOpacity(.2), width: 2),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: Get.height * .2,
                  width: Get.width,
                  child: ClipRRect(borderRadius: AppTheme.borderRadius, child: Lottie.asset(AssetsConsts.noInternet)),
                ),
              ),
              SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "noInternet".tr,
                      textAlign: TextAlign.center,
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          "noInternetBody".tr,
                          textAlign: TextAlign.center,
                          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            AppButton(
              title: "refresh".tr,
              function: () async {
                if (await networkInfo!.isConnected) {
                  completer.complete(request());
                  SDKNav.back();
                }
              },
            ),
          ],
        ),
      ),
    );
    return completer.future;
  }

}
