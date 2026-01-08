import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/menu/presentation/getx/contact_us_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/profile_text_field.dart';
import '../../../../shared/widgets/url_widget.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(
        init: ContactUsController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text('contactUs'.tr),
            ),
            body: Form(
              key: controller.contactUsFormKey,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileTextField(
                        label: 'email',
                        maxLength: 150,
                        type: TextInputType.emailAddress,
                        controller: controller.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'enterEmail'.tr;
                          }
                          if (!AppConstants.emailRegex.hasMatch(value)) {
                            return 'invalidEmail'.tr;
                          }
                          return null;
                        },
                        shakeKey: controller.emailShakeKey,
                      ),
                      SizedBox(height: Get.height * .03),
                      ProfileTextField(
                        label: 'note',
                        type: TextInputType.multiline,
                        controller: controller.noteController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            controller.noteShakeKey.currentState!.shake();
                            return 'pleaseEnterNote'.tr;
                          }
                          return null;
                        },
                        padding: EdgeInsets.symmetric(vertical: Get.height * .075, horizontal: 16),
                        isBigRad: false,
                        maxLength: 300,
                        shakeKey: controller.noteShakeKey,
                      ),
                      SizedBox(height: Get.height * .03),
                      SizedBox(
                        width: Get.width * .4,
                        child: AppButton(
                          title: "send".tr,
                          function: () {
                            if (controller.contactUsFormKey.currentState!.validate()) {}
                          },
                        ),
                      ),
                      SizedBox(height: Get.height * .04),
                      Text('orContactUsVia'.tr, style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size18)),
                      SizedBox(height: Get.height * .02),
                      UrlWidget(
                        image: AssetsConsts.phoneIcon,
                        url: "tel:${controller.contactUsPhone}",
                        height: Get.height * .06,
                      ),
                      SizedBox(height: Get.height * .02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (!await launchUrl(
                                Uri.parse("tel:${controller.contactUsPhone}"),
                                mode: LaunchMode.externalApplication,
                              )) {
                                throw 'Could not launch ${""}';
                              }
                            },
                            child: Text("+962 ${controller.contactUsPhone}",
                                style: AppTheme.textStyle(color: Colors.blue, size: AppTheme.size18, isBold: true)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
