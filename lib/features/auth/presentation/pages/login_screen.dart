import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/shared/widgets/hero_logo.dart';
import 'package:my_custom_widget/shared/widgets/loading_button_widget/progress_button.dart';

import '../../../../core/utils/theme.dart';
import '../../../../my_custom_widget.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/shake_widget.dart';
import '../getx/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: GetBuilder<AuthController>(
            init: AuthController(),
            builder: (controller) => Padding(
              padding: EdgeInsets.all(12),
              child: Form(
                key: controller.loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                SizedBox(height: Get.height * .02),
                                HeroLogo(smallLogo: true),
                                SizedBox(height: Get.height * .08),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(color: AppTheme.primaryColor.withOpacity(0.35)),
                                    boxShadow: [BoxShadow(color: AppTheme.textColor.withOpacity(0.05), blurRadius: 18, offset: const Offset(0, 10))],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Column(
                                      children: [
                                        Text(
                                          "getStartedNow".tr,
                                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size20, isBold: true),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "pleaseEnterYourMobileNumber".tr,
                                          style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
                                          textAlign: TextAlign.center,
                                        ),

                                        SizedBox(height: Get.height * .03),
                                        Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // SharedHelper().scaleDialog(CountriesWidget());
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                                  decoration: BoxDecoration(
                                                    color: AppTheme.bgThemeColor,
                                                    borderRadius: BorderRadius.circular(18),
                                                    border: Border.all(color: AppTheme.primaryColor.withOpacity(.14)),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${controller.selectedCountry.flag} ${controller.selectedCountry.callingCode}",
                                                        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12, isBold: true),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(width: 10),

                                              // mobile field
                                              Expanded(
                                                child: ShakeWidget(
                                                  key: controller.mobileShakeKey,
                                                  child: TextFormField(
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.digitsOnly,
                                                      LengthLimitingTextInputFormatter(controller.numberOfDigit),
                                                    ],
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        controller.mobileShakeKey.currentState!.shake();
                                                        controller.btnState = ButtonState.fail;
                                                        controller.errorText = "${"mobileNumber".tr} ${"isReq".tr}";
                                                        controller.update();
                                                        controller.resetBtnState();
                                                        return "";
                                                      } else if (value.length < controller.numberOfDigit) {
                                                        controller.mobileShakeKey.currentState!.shake();
                                                        controller.btnState = ButtonState.fail;
                                                        controller.errorText = "wrongMobile".tr;
                                                        controller.update();
                                                        controller.resetBtnState();
                                                        return "";
                                                      } else if (!value.startsWith(AppConstants.countryCodeStart) &&
                                                          !value.startsWith(AppConstants.countryCodeStartWithZero)) {
                                                        controller.mobileShakeKey.currentState!.shake();
                                                        controller.btnState = ButtonState.fail;
                                                        controller.errorText = "numberShouldStart5".tr;
                                                        controller.update();
                                                        controller.resetBtnState();
                                                        return "";
                                                      }
                                                      return null;
                                                    },
                                                    keyboardType: TextInputType.phone,
                                                    controller: controller.mobileController,
                                                    textInputAction: TextInputAction.go,
                                                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                                                    textAlignVertical: TextAlignVertical.center,
                                                    onChanged: (value) {
                                                      controller.numberOfDigit = controller.mobileController.text.startsWith("0") ? 10 : 9;
                                                      controller.update();

                                                      if (value.length >=
                                                          (controller.numberOfDigit = controller.mobileController.text.startsWith("0") ? 10 : 9)) {
                                                        FocusManager.instance.primaryFocus?.unfocus();
                                                      }
                                                      if (controller.errorText != null) {
                                                        controller.errorText = null;
                                                        controller.update();
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      errorStyle: const TextStyle(height: .1),
                                                      hintText: 'mobileNumber'.tr,
                                                      filled: true,
                                                      fillColor: AppTheme.bgThemeColor,
                                                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(18),
                                                        borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(.14)),
                                                      ),
                                                      enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(18),
                                                        borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(.14)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(18),
                                                        borderSide: BorderSide(color: AppTheme.primaryColor.withOpacity(.35), width: 1.2),
                                                      ),
                                                      hintStyle: AppTheme.textStyle(color: AppTheme.greyColor, size: AppTheme.size14),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 250),
                                          height: controller.errorText != null ? 58 : 0,
                                          margin: const EdgeInsets.only(top: 12),
                                          padding: controller.errorText != null ? const EdgeInsets.all(12) : EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            color: AppTheme.redColor.withOpacity(.10),
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color: AppTheme.redColor.withOpacity(.25)),
                                          ),
                                          child: controller.errorText == null
                                              ? const SizedBox()
                                              : Row(
                                                  children: [
                                                    Icon(Icons.error_outline, color: AppTheme.redColor, size: 18),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        controller.errorText ?? "",
                                                        style: AppTheme.textStyle(color: AppTheme.redColor, size: AppTheme.size12, isBold: true),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),

                                        const SizedBox(height: 10),
                                        ShakeWidget(
                                          key: controller.termsAndPolicy,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppTheme.bgThemeColor,
                                              borderRadius: BorderRadius.circular(18),
                                              border: Border.all(color: AppTheme.primaryColor.withOpacity(.12)),
                                            ),
                                            child: CheckboxListTile(
                                              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                              controlAffinity: ListTileControlAffinity.leading,
                                              value: controller.acceptTerms,
                                              onChanged: (val) {
                                                controller.acceptTerms = val!;
                                                controller.update();
                                              },
                                              title: Transform.translate(
                                                offset: Offset(appLanguage == "ar" ? 18 : -18, 0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'acceptTermsPrivacy'.tr,
                                                        style: AppTheme.textStyle(
                                                          color: AppTheme.textColor.withOpacity(.85),
                                                          size: AppTheme.size12,
                                                        ).copyWith(height: 1.6),
                                                      ),
                                                      TextSpan(
                                                        text: " ${'privacyPolicy'.tr}",
                                                        style: AppTheme.textStyle(
                                                          color: AppTheme.primaryColor,
                                                          size: AppTheme.size12,
                                                        ).copyWith(height: 1.6),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () => Navigator.pushNamed(
                                                            context,
                                                            RouteConstant.appWebViewPage,
                                                            arguments: {"url": AppConstants.privacyPolicy, "title": 'privacyPolicy'.tr},
                                                          ),
                                                      ),
                                                      TextSpan(
                                                        text: '${'and'.tr} ',
                                                        style: AppTheme.textStyle(
                                                          color: AppTheme.textColor.withOpacity(.85),
                                                          size: AppTheme.size12,
                                                        ).copyWith(height: 1.6),
                                                      ),
                                                      TextSpan(
                                                        text: 'termsCondition'.tr,
                                                        style: AppTheme.textStyle(
                                                          color: AppTheme.primaryColor,
                                                          size: AppTheme.size12,
                                                        ).copyWith(height: 1.6),
                                                        recognizer: TapGestureRecognizer()
                                                          ..onTap = () => Navigator.pushNamed(
                                                            context,
                                                            RouteConstant.appWebViewPage,
                                                            arguments: {"url": AppConstants.termsAndCondition, "title": 'termsCondition'.tr},
                                                          ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: Get.height * .025),

                                        // ✅ Next button (same logic)
                                        Row(
                                          children: [
                                            Expanded(
                                              child: AppButton(
                                                isProgress: true,
                                                state: controller.btnState,
                                                title: 'next'.tr,
                                                function: () {
                                                  if (controller.btnState == ButtonState.normal) {
                                                    if (controller.loginFormKey.currentState!.validate()) {
                                                      if (controller.acceptTerms) {
                                                        controller.verifyMobileNumber();
                                                      } else {
                                                        controller.termsAndPolicy.currentState!.shake();
                                                        SharedHelper().errorSnackBar("pleaseAgreeTermsAlert".tr, durationInSeconds: 3);
                                                        controller.btnState = ButtonState.fail;
                                                        controller.update();
                                                        controller.resetBtnState();
                                                      }
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
