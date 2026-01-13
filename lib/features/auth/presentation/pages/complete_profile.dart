import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/constants.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/hero_logo.dart';
import '../../../../shared/widgets/profile_text_field.dart';
import '../../domain/entities/gender.dart';
import '../getx/auth_controller.dart';
import '../widgets/select_widget.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController controller;
    if (Get.isRegistered<AuthController>()) {
      controller = Get.find<AuthController>();
    } else {
      controller = Get.put<AuthController>(AuthController());
    }
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
        builder: (c) {
          return Scaffold(
            appBar: AppBar(title: Text("completeProfile".tr), elevation: 0),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          isProgress: true,
                          title: "save".tr,
                          function: () {
                            if (controller.editProfileFormKey.currentState!.validate()) {
                              controller.completeProfile();
                            }
                          },
                          state: controller.btnState,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(12),
              child: Form(
                key: controller.editProfileFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * .02),
                      HeroLogo(),
                      SizedBox(height: Get.height * .04),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppTheme.bgThemeColor,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.4)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              ProfileTextField(
                                label: 'fName',
                                maxLength: 25,
                                icon: AssetsConsts.person,
                                type: TextInputType.text,
                                controller: controller.fNameController,
                                validator: (value) {
                                  if (value!.length < 3) {
                                    controller.fNameShakeKey.currentState!.shake();
                                    return 'firstNameLengthMustMoreThan3Char'.tr;
                                  }
                                  return null;
                                },
                                shakeKey: controller.fNameShakeKey,
                              ),
                              ProfileTextField(
                                label: 'lName',
                                icon: AssetsConsts.person,
                                maxLength: 25,
                                type: TextInputType.text,
                                controller: controller.lNameController,
                                validator: (value) {
                                  if (value!.length < 3) {
                                    controller.lNameShakeKey.currentState!.shake();
                                    return 'lastNameLengthMustMoreThan3Char'.tr;
                                  }
                                  return null;
                                },
                                shakeKey: controller.lNameShakeKey,
                              ),
                              ProfileTextField(
                                label: 'gender',
                                maxLength: 10,
                                icon: AssetsConsts.genderIcon,
                                type: TextInputType.text,
                                controller: controller.genderController,
                                validator: (value) {
                                  if (value!.length < 3) {
                                    controller.genderShakeKey.currentState!.shake();
                                    return 'selectYourGender'.tr;
                                  }
                                  return null;
                                },
                                shakeKey: controller.genderShakeKey,
                                readOnly: true,
                                onTap: () {
                                  controller.isTheCupertinoPickerMove = false;
                                  SharedHelper().bottomSheet(
                                    SelectWidget<Gender>(
                                      tag: SelectWidgetConstant.gender,
                                      title: 'gender',
                                      listOfItems: [
                                        Gender(id: 1, name: 'male'.tr),
                                        Gender(id: 2, name: 'female'.tr),
                                      ],
                                      selectedItem: controller.selectedGenderType,
                                      controller: controller,
                                    ),
                                  );
                                },
                              ),
                              ProfileTextField(
                                label: 'bod',
                                maxLength: 500,
                                icon: AssetsConsts.bodIcon,
                                type: TextInputType.text,
                                controller: controller.bodController,
                                validator: (value) {
                                  if (value!.length < 3) {
                                    controller.bodShakeKey.currentState!.shake();
                                    return 'selectYourBirthdate'.tr;
                                  }
                                  return null;
                                },
                                shakeKey: controller.bodShakeKey,
                                readOnly: true,
                                onTap: () {
                                  controller.isTheCupertinoPickerMove = false;
                                  SharedHelper().bottomSheet(
                                    SelectWidget<DateTime>(
                                      tag: SelectWidgetConstant.dateOfBirth,
                                      title: 'bod',
                                      isDate: true,
                                      selectedItem: controller.selectedDateOfBirth,
                                      controller: controller,
                                    ),
                                  );
                                },
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
          );
        },
      ),
    );
  }
}
