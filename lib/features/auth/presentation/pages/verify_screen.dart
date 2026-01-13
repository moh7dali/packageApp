import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:my_custom_widget/shared/widgets/bottom_widget.dart';
import 'package:my_custom_widget/shared/widgets/hero_logo.dart';
import 'package:my_custom_widget/shared/widgets/loading_button_widget/progress_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/sdk/sdk_routes.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/shake_widget.dart';
import '../getx/auth_controller.dart';
import '../widgets/spinner_text_widget.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller;
    if (Get.isRegistered<AuthController>()) {
      controller = Get.find<AuthController>();
    } else {
      controller = Get.put<AuthController>(AuthController());
      controller.getDataAfterDelete();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(leading: Container()),
      body: GetBuilder<AuthController>(
        builder: (c) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: controller.verifyFormKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: Get.height * .01),
                  HeroLogo(),
                  SizedBox(height: Get.height * .03),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.bgThemeColor,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.35)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 18, offset: const Offset(0, 10))],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        children: [
                          Text(
                            "enter4Digit".tr,
                            textAlign: TextAlign.center,
                            style: AppTheme.textStyle(color: AppTheme.primaryColor, isBold: true, size: AppTheme.size20),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "verificationSent".tr,
                            textAlign: TextAlign.center,
                            style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size12),
                          ),
                          const SizedBox(height: 12),

                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppTheme.bgThemeColor,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: AppTheme.primaryColor.withOpacity(.14)),
                              ),
                              child: Text(
                                "${controller.selectedCountry.callingCode}${controller.mobileController.text.startsWith("0") ? controller.mobileController.text.replaceFirst("0", "") : controller.mobileController.text}",
                                style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12, isBold: true),
                              ),
                            ),
                          ),

                          SizedBox(height: Get.height * .03),
                          ShakeWidget(
                            key: controller.smsCodeShakeKey,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.bgThemeColor,
                                borderRadius: BorderRadius.circular(22),
                                border: Border.all(color: AppTheme.primaryColor.withOpacity(.5)),
                              ),
                              child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: PinCodeTextField(
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  keyboardType: TextInputType.phone,
                                  autoDisposeControllers: false,
                                  onCompleted: (value) {
                                    if (controller.btnState == ButtonState.normal) {
                                      controller.checkValidationCode();
                                    }
                                  },
                                  length: 4,
                                  textStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size18),
                                  hintStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size18, isBold: true),
                                  obscureText: false,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  animationType: AnimationType.scale,
                                  controller: controller.smsCodeController,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  hintCharacter: '--',
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(18),
                                    fieldHeight: Get.width * .14,
                                    fieldWidth: Get.width * .14,
                                    activeFillColor: AppTheme.primaryColor.withOpacity(.06),
                                    activeColor: AppTheme.primaryColor.withOpacity(.18),
                                    selectedColor: AppTheme.primaryColor.withOpacity(.40),
                                    selectedFillColor: AppTheme.primaryColor.withOpacity(.10),
                                    inactiveColor: AppTheme.primaryColor.withOpacity(.12),
                                    inactiveFillColor: AppTheme.primaryColor.withOpacity(.06),
                                  ),
                                  animationDuration: const Duration(milliseconds: 300),
                                  enableActiveFill: true,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      controller.smsCodeShakeKey.currentState?.shake();
                                      return '';
                                    } else if (value.length != 4) {
                                      controller.smsCodeShakeKey.currentState?.shake();
                                      return '';
                                    }
                                    return null;
                                  },
                                  appContext: context,
                                  onChanged: (String value) {
                                    controller.otpCode = value;
                                    controller.btnState = ButtonState.normal;
                                  },
                                  beforeTextPaste: (text) {
                                    String pasteText = (text ?? "").substring(0, 4);
                                    SharedHelper().actionDialog(
                                      "pasteCode",
                                      "${'confirmPaste'.tr}\n$pasteText",
                                      confirmText: 'paste',
                                      confirm: () {
                                        controller.smsCodeController.text = pasteText;
                                        SharedHelper().closeAllDialogs();
                                      },
                                    );
                                    return false;
                                  },
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: Get.height * .02),

                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  isProgress: true,
                                  title: "letsGo".tr,
                                  state: controller.btnState,
                                  function: () {
                                    if (controller.btnState == ButtonState.normal) {
                                      if (controller.verifyFormKey.currentState!.validate()) {
                                        controller.checkValidationCode();
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Text(
                            "didntReceiveCode".tr,
                            textAlign: TextAlign.center,
                            style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size12),
                          ),
                          const SizedBox(height: 10),

                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: controller.isResend == true
                                ? Text(
                                    "00:00",
                                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "00:",
                                        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                                      ),
                                      SpinnerText(
                                        text: controller.smsDuration,
                                        textStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                                      ),
                                    ],
                                  ),
                          ),
                          const SizedBox(height: 10),
                          Opacity(
                            opacity: controller.isResend ? 1 : .25,
                            child: AppButton(
                              isDoneBtn: false,
                              title: "resendOtp".tr,
                              state: controller.btnState,
                              function: () {
                                if (controller.isResend) {
                                  controller.resendCode();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: Get.height * .03),

                  GestureDetector(
                    onTap: () {
                      String number = controller.mobileController.text;
                      if (number.startsWith('0')) {
                        number = number.replaceFirst('0', '');
                      }
                      SharedHelper().bottomSheet(
                        BottomWidget(
                          title: 'wrongMobile?'.tr,
                          description: "${'changeMobile'.tr}\n+962${number}",
                          onCancel: () {
                            SharedHelper().closeAllDialogs();
                          },
                          onConfirm: () {
                            SharedHelper().closeAllDialogs();
                            SDKNav.back();
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.bgThemeColor,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppTheme.primaryColor.withOpacity(.5)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_outlined, color: AppTheme.primaryColor, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'wrongMobile?'.tr,
                            style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
