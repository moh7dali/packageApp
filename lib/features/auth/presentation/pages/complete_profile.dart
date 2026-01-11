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
      canPop: controller.isProfile,
      onPopInvoked: (didPop) async {
        if (!controller.isProfile) {
          SharedHelper().actionDialog(
            "exitApp",
            "confirmExitApp",
            confirm: () {
              SystemNavigator.pop();
            },
          );
        }
      },
      child: GetBuilder<AuthController>(
        builder: (c) {
          return Scaffold(
            appBar: AppBar(title: Text(controller.profile == null ? "completeProfile".tr : 'editProfile'.tr), elevation: 0),
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
                      HeroLogo(smallLogo: true),
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
                              if (controller.profile == null)
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

                      // GetBuilder<LookUpController>(
                      //   init: LookUpController(isProfile: controller.isProfile),
                      //   builder: (lookUpController) {
                      //     return Column(
                      //       children: [
                      //         lookUpController.isLookUpLoading
                      //             ? Padding(
                      //                 padding: const EdgeInsets.only(bottom: 8.0),
                      //                 child: ClipRRect(
                      //                   borderRadius: BorderRadius.circular(12),
                      //                   child: Image.asset(
                      //                     AssetsConsts.loading,
                      //                     height: Get.height * .055,
                      //                     width: Get.width,
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //                 ),
                      //               )
                      //             : ProfileTextField(
                      //                 label: 'visitorType'.tr,
                      //                 maxLength: 25,
                      //                 icon: AssetsConsts.person,
                      //                 isOptional: true,
                      //                 type: TextInputType.text,
                      //                 controller: controller.visitorTypeController,
                      //                 // validator: (value) {
                      //                 //   if (value!.isEmpty) {
                      //                 //     controller.visitorTypeShakeKey.currentState!.shake();
                      //                 //     return 'selectYourVisitorType'.tr;
                      //                 //   }
                      //                 //   return null;
                      //                 // },
                      //                 shakeKey: controller.visitorTypeShakeKey,
                      //                 readOnly: true,
                      //                 onTap: () async {
                      //                   if (controller.isProfile) {
                      //                     await lookUpController.getLookUpList();
                      //                   }
                      //                   controller.isTheCupertinoPickerMove = false;
                      //                   SharedHelper().bottomSheet(
                      //                     SelectWidget<LookUp>(
                      //                       tag: SelectWidgetConstant.lookup,
                      //                       title: 'visitorType'.tr,
                      //                       listOfItems: lookUpController.allLookUps,
                      //                       selectedItem: controller.selectedVisitorType,
                      //                       controller: controller,
                      //                     ),
                      //                   );
                      //                 },
                      //               ),
                      //       ],
                      //     );
                      //   },
                      // ),
                      // GetBuilder<CityAndAreaController>(
                      //   init: CityAndAreaController(isProfile: controller.isProfile),
                      //   builder: (cityAndAreaController) {
                      //     return Column(
                      //       children: [
                      //         cityAndAreaController.isCityLoading
                      //             ? Padding(
                      //                 padding: const EdgeInsets.only(bottom: 8.0),
                      //                 child: ClipRRect(
                      //                   borderRadius: AppTheme.borderRadius,
                      //                   child: Image.asset(AssetsConsts.loading, height: Get.height * .055, width: Get.width, fit: BoxFit.cover),
                      //                 ),
                      //               )
                      //             : ProfileTextField(
                      //                 label: 'city',
                      //                 maxLength: 10,
                      //                 icon: AssetsConsts.city,
                      //                 type: TextInputType.text,
                      //                 controller: controller.cityController,
                      //                 validator: (value) {
                      //                   if (value!.isEmpty) {
                      //                     controller.cityShakeKey.currentState!.shake();
                      //                     return 'selectYourCity'.tr;
                      //                   }
                      //                   return null;
                      //                 },
                      //                 shakeKey: controller.cityShakeKey,
                      //                 readOnly: true,
                      //                 onTap: () async {
                      //                   if (controller.isProfile) {
                      //                     await cityAndAreaController.getCitiesList();
                      //                   }
                      //                   controller.isTheCupertinoPickerMove = false;
                      //                   SharedHelper().bottomSheet(
                      //                     SelectWidget<City>(
                      //                       tag: SelectWidgetConstant.city,
                      //                       title: 'city',
                      //                       listOfItems: cityAndAreaController.allCities,
                      //                       selectedItem: controller.selectedCity,
                      //                       controller: controller,
                      //                       cityAndAreaController: cityAndAreaController,
                      //                     ),
                      //                   );
                      //                 },
                      //               ),
                      //         //         // if (controller.cityController.text.isNotEmpty)
                      //         //         //   cityAndAreaController.isAreaLoading
                      //         //         //       ? Padding(
                      //         //         //           padding: const EdgeInsets.only(bottom: 8.0),
                      //         //         //           child: ClipRRect(
                      //         //         //             borderRadius: AppTheme.borderRadius,
                      //         //         //             child: Image.asset(
                      //         //         //               AssetsConsts.loading,
                      //         //         //               height: Get.height * .055,
                      //         //         //               width: Get.width,
                      //         //         //               fit: BoxFit.cover,
                      //         //         //             ),
                      //         //         //           ),
                      //         //         //         )
                      //         //         //       : ProfileTextField(
                      //         //         //           label: 'area',
                      //         //         //           maxLength: 10,
                      //         //         //           type: TextInputType.text,
                      //         //         //           controller: controller.areaController,
                      //         //         //           validator: (value) {
                      //         //         //             if (value!.isEmpty) {
                      //         //         //               controller.areaShakeKey.currentState!.shake();
                      //         //         //               return 'selectArea'.tr;
                      //         //         //             }
                      //         //         //             return null;
                      //         //         //           },
                      //         //         //           shakeKey: controller.areaShakeKey,
                      //         //         //           readOnly: true,
                      //         //         //           onTap: () async {
                      //         //         //             if (controller.isProfile && ((cityAndAreaController.allCities ?? []).isEmpty)) {
                      //         //         //               await cityAndAreaController.getAreaList(cityId: controller.profile?.city?.id ?? 0);
                      //         //         //             }
                      //         //         //             controller.isTheCupertinoPickerMove = false;
                      //         //         //             SharedHelper().bottomSheet(
                      //         //         //               SelectWidget<Area>(
                      //         //         //                 tag: SelectWidgetConstant.area,
                      //         //         //                 title: 'area',
                      //         //         //                 listOfItems: cityAndAreaController.allArea,
                      //         //         //                 selectedItem: controller.selectedArea,
                      //         //         //                 controller: controller,
                      //         //         //               ),
                      //         //         //             );
                      //         //         //           },
                      //         //         //         ),
                      //       ],
                      //     );
                      //   },
                      // ),
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
