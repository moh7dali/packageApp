import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/assets_constants.dart';
import 'package:my_custom_widget/features/auth/presentation/getx/auth_controller.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/helper/shared_preferences_storage.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/hero_logo.dart';
import '../../../../shared/widgets/loading_button_widget/progress_button.dart';
import '../../../../shared/widgets/profile_text_field.dart';

class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        SharedHelper().actionDialog(
          "exitApp",
          "confirmExitApp",
          confirm: () {
            SystemNavigator.pop();
          },
        );
      },
      child: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) => GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          title: "save".tr,
                          isProgress: true,
                          state: controller.btnState,
                          function: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (controller.btnState == ButtonState.normal) {
                              if (controller.referralFormKey.currentState!.validate()) {
                                controller.addReferralApi();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * .03),
                  AppButton(
                    title: "skip".tr,
                    isDoneBtn: false,
                    function: () {
                      sl<SharedPreferencesStorage>().setHasReferral(true);
                      Get.deleteAll();
                      SDKNav.offAllNamed(RouteConstant.homeScreen);
                    },
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: controller.referralFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HeroLogo(),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [BoxShadow(color: AppTheme.textColor.withOpacity(0.06), blurRadius: 22, offset: const Offset(0, 12))],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(gradient: AppTheme.gradient1),
                              padding: const EdgeInsets.fromLTRB(16, 18, 16, 14),
                              child: Column(
                                children: [
                                  Icon(Icons.group_add_rounded, color: AppTheme.textColor, size: 30),
                                  const SizedBox(height: 10),
                                  Text(
                                    'referralCode'.tr,
                                    textAlign: TextAlign.center,
                                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size18, isBold: true),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'referralCodeTxt'.tr,
                                    textAlign: TextAlign.center,
                                    style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.85), size: AppTheme.size12),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(

                                border: Border(bottom: BorderSide(color: AppTheme.primaryColor)),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      ProfileTextField(
                                        label: 'referralCode',
                                        maxLength: 6,
                                        showLabelAsHeader: false,
                                        isUpper: true,
                                        icon: AssetsConsts.referral,
                                        type: TextInputType.text,
                                        controller: controller.referralController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            controller.referralShakeKey.currentState!.shake();
                                            return 'referralCodeError'.tr;
                                          }
                                          return null;
                                        },
                                        shakeKey: controller.referralShakeKey,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
