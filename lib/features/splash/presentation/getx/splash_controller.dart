import "dart:io";

import "package:flutter/services.dart";
import "package:get/get.dart";
import "package:my_custom_widget/my_custom_widget.dart";
import "package:my_custom_widget/shared/helper/device_info.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:url_launcher/url_launcher.dart";

import "../../../../core/constants/constants.dart";
import "../../../../core/sdk/sdk_rouutes.dart";
import "../../../../core/utils/app_log.dart";
import "../../../../injection_container.dart";
import "../../../../shared/helper/shared_helper.dart";
import "../../../../shared/helper/shared_preferences_storage.dart";
import "../../domain/entities/advertising_list.dart";
import "../../domain/usecases/get_advertising.dart";
import "../../domain/usecases/get_application_version.dart";

class SplashController extends GetxController {
  final GetApplicationVersion getApplicationVersion;
  final GetAdvertising getAdvertising;

  bool isLoading = true;
  bool isLoadingCircle = true;

  SplashController() : getApplicationVersion = sl(), getAdvertising = sl();

  AdvertisingList? advertisingList;
  bool advertisingDone = false;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), () {
      DeviceInfo.getDeviceData();
      if (!fromPush) {
        if (isSystem && systemNotificationModel != null) {
          SharedHelper().actionDialog(
            systemNotificationModel!.title ?? "",
            systemNotificationModel!.body ?? "",
            hasImage: systemNotificationModel!.image != null,
            image: systemNotificationModel!.image,
            confirm: () {
              SharedHelper().closeAllDialogs();
              _getApplicationVersion();
              systemNotificationModel = null;
              isSystem = false;
            },
            cancel: () {
              SystemNavigator.pop();
              if (Platform.isIOS) {
                exit(0);
              }
            },
          );
        } else {
          _getApplicationVersion();
          systemNotificationModel = null;
          isSystem = false;
        }
      }
    });
  }

  updateApp() {
    if (Platform.isAndroid) {
      launchUrl(Uri.parse('market://details?id=${AppConstants.bundleIDAndroid}'));
    } else if (Platform.isIOS) {
      launchUrl(Uri.parse('https://apps.apple.com/us/app/id${AppConstants.iOSAppID}'));
      appLog("https://apps.apple.com/us/app/id${AppConstants.iOSAppID}");
    }
  }

  _getApplicationVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    await getApplicationVersion.repository
        .getApplicationVersion(packageInfo.buildNumber)
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (applicationVersion) {
              isLoadingCircle = false;
              update();
              if ((applicationVersion.isActive ?? true) == false) {
                SharedHelper().actionDialog(
                  "",
                  "${applicationVersion.inActiveReason}",
                  noCancel: true,
                  confirm: () {
                    exit(0);
                  },
                  confirmText: 'done'.tr,
                );
                appLog(applicationVersion.needsUpdating, tag: 'AppStoppedState');
              } else if ((applicationVersion.needsUpdating ?? false) == true) {
                SharedHelper().actionDialog(
                  "",
                  "forceUpdate",
                  noCancel: true,
                  confirm: () {
                    updateApp();
                  },
                  confirmText: 'update'.tr,
                );
                appLog(applicationVersion.needsUpdating, tag: "forceUpdate");
              } else {
                isLoading = false;
                update();
                Future.delayed(const Duration(seconds: 2), () {
                  _getAdvertising();
                });
              }
            },
          ),
        );
  }

  _getAdvertising() async {
    await getAdvertising.repository
        .getAdvertising(queryParameters: {"TypeId": "1"})
        .then(
          (value) => value.fold(
            (failure) {
              finishAdvertising();
            },
            (advertising) {
              advertisingList = advertising;
              if ((advertising.advertisingList).isNotEmpty) {
                Future.delayed(const Duration(seconds: 2), () {
                  advertisingDone = true;
                  update();
                });
              } else {
                finishAdvertising();
              }
            },
          ),
        );
  }

  Future finishAdvertising() async {
    appLog(await SharedHelper().isUserLoggedIn(), tag: "isUserLoggedIn");
    appLog(await sl<SharedPreferencesStorage>().getIsCompleted(), tag: "getIsCompleted");
    sl<SharedPreferencesStorage>().setShowQr(true);
    cartItems.value = await sl<SharedPreferencesStorage>().getCartItems();
    if (await SharedHelper().isUserLoggedIn()) {
      if (await sl<SharedPreferencesStorage>().getIsCompleted()) {
        Get.offAllNamed(RouteConstant.mainPage);
      } else {
        Get.deleteAll();
        Get.offAllNamed(RouteConstant.completeProfile);
      }
    } else {
      SDKNav.offAllNamed(RouteConstant.onBoarding);
    }
  }
}
