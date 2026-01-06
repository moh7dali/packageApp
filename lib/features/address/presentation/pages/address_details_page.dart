import 'package:my_custom_widget/core/constants/assets_constants.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/profile_text_field.dart';
import '../../../../shared/widgets/translated_image_widget.dart';
import '../../../auth/domain/entities/area.dart';
import '../../../auth/domain/entities/city.dart';
import '../../../auth/presentation/getx/city_area_controller.dart';
import '../../../auth/presentation/widgets/select_widget.dart';
import '../getx/address_controller.dart';

class AddressDetailsPage extends StatelessWidget {
  const AddressDetailsPage({super.key, this.isEdit = false});

  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    AddressController controller;
    if (Get.isRegistered<AddressController>()) {
      controller = Get.find<AddressController>();
    } else {
      controller = Get.put<AddressController>(AddressController());
    }
    return GetBuilder<AddressController>(
      init: AddressController(),
      builder: (c) {
        return Scaffold(
          appBar: AppBar(title: Text("selectYourAddress".tr)),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton(
                  title: "save".tr,
                  function: () {
                    if (controller.addressFormKey.currentState!.validate()) {
                      controller.addNewAddress();
                    }
                  },
                ),
              ],
            ),
          ),
          body: Form(
            key: controller.addressFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: AppTheme.bigBorderRadius, color: AppTheme.secondaryColor),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RadioListTile<String>(
                                            title: Text(
                                              'home'.tr,
                                              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                                            ),
                                            value: 'home',
                                            groupValue: controller.selectedAddressType,
                                            onChanged: (value) => controller.selectType(value!),
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile<String>(
                                            title: Text(
                                              'work'.tr,
                                              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                                            ),
                                            value: 'work',
                                            groupValue: controller.selectedAddressType,
                                            onChanged: (value) => controller.selectType(value!),
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile<String>(
                                            title: Text(
                                              'other'.tr,
                                              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                                            ),
                                            value: 'other',
                                            groupValue: controller.selectedAddressType,
                                            onChanged: (value) => controller.selectType(value!),
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (controller.selectedAddressType == 'other')
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                                        child: ProfileTextField(
                                          iconColor: AppTheme.textColor,
                                          type: TextInputType.text,
                                          label: 'addressLabelList',
                                          maxLength: 150,
                                          controller: controller.addressLabelController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              controller.addressLabelShakeKey.currentState!.shake();
                                              return "${'enter'.tr} ${'addressLabelList'.tr}";
                                            }
                                            return null;
                                          },
                                          shakeKey: controller.addressLabelShakeKey,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            ProfileTextField(
                              iconColor: AppTheme.textColor,
                              type: TextInputType.multiline,
                              padding: EdgeInsets.symmetric(vertical: Get.height * .025),
                              isBigRad: false,
                              label: 'addressDetails',
                              maxLength: 150,
                              controller: controller.nameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  controller.nameShakeKey.currentState!.shake();
                                  return "${'enter'.tr} ${'addressDetails'.tr}";
                                }
                                return null;
                              },
                              shakeKey: controller.nameShakeKey,
                            ),
                            GetBuilder<CityAndAreaController>(
                              init: CityAndAreaController(isProfile: isEdit),
                              builder: (cityAndAreaController) {
                                return Column(
                                  children: [
                                    cityAndAreaController.isCityLoading
                                        ? Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0),
                                            child: ClipRRect(
                                              borderRadius: AppTheme.borderRadius,
                                              child: Image.asset(
                                                AssetsConsts.loading,
                                                height: Get.height * .055,
                                                width: Get.width,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : ProfileTextField(
                                            type: TextInputType.multiline,
                                            iconColor: AppTheme.textColor,
                                            padding: EdgeInsets.symmetric(vertical: Get.height * .015),
                                            isBigRad: false,
                                            label: 'city',
                                            maxLength: 150,
                                            controller: controller.cityController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                controller.cityShakeKey.currentState!.shake();
                                                return 'selectYourCity'.tr;
                                              }
                                              return null;
                                            },
                                            shakeKey: controller.cityShakeKey,
                                            readOnly: true,
                                            onTap: () async {
                                              if (isEdit) {
                                                await cityAndAreaController.getCitiesList();
                                              }
                                              controller.isTheCupertinoPickerMove = false;
                                              SharedHelper().bottomSheet(
                                                SelectWidget<City>(
                                                  tag: SelectWidgetConstant.city,
                                                  title: 'city',
                                                  isAddress: true,
                                                  listOfItems: cityAndAreaController.allCities,
                                                  selectedItem: controller.selectedCity,
                                                  addressController: controller,
                                                  cityAndAreaController: cityAndAreaController,
                                                ),
                                              );
                                            },
                                          ),
                                    if (controller.cityController.text.isNotEmpty)
                                      cityAndAreaController.isAreaLoading
                                          ? Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: ClipRRect(
                                                borderRadius: AppTheme.borderRadius,
                                                child: Image.asset(
                                                  AssetsConsts.loading,
                                                  height: Get.height * .055,
                                                  width: Get.width,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : ProfileTextField(
                                              label: 'area',
                                              iconColor: AppTheme.textColor,
                                              maxLength: 150,
                                              type: TextInputType.multiline,
                                              padding: EdgeInsets.symmetric(vertical: Get.height * .015),
                                              isBigRad: false,
                                              controller: controller.areaController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  controller.areaShakeKey.currentState!.shake();
                                                  return 'selectArea'.tr;
                                                }
                                                return null;
                                              },
                                              shakeKey: controller.areaShakeKey,
                                              readOnly: true,
                                              onTap: () async {
                                                if (isEdit && ((cityAndAreaController.allCities ?? []).isEmpty)) {
                                                  await cityAndAreaController.getAreaList(cityId: 2);
                                                }
                                                controller.isTheCupertinoPickerMove = false;
                                                SharedHelper().bottomSheet(
                                                  SelectWidget<Area>(
                                                    isAddress: true,
                                                    tag: SelectWidgetConstant.area,
                                                    title: 'area',
                                                    listOfItems: cityAndAreaController.allArea,
                                                    selectedItem: controller.selectedArea,
                                                    addressController: controller,
                                                  ),
                                                );
                                              },
                                            ),
                                  ],
                                );
                              },
                            ),
                            ProfileTextField(
                              iconColor: AppTheme.textColor,
                              label: 'buildingNum',
                              maxLength: 150,
                              type: TextInputType.multiline,
                              padding: EdgeInsets.symmetric(vertical: Get.height * .02),
                              isBigRad: false,
                              controller: controller.buildingNumberController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  controller.buildingNumberShakeKey.currentState!.shake();
                                  return "${'enter'.tr} ${'buildingNum'.tr}";
                                }
                                return null;
                              },
                              shakeKey: controller.buildingNumberShakeKey,
                            ),
                            ProfileTextField(
                              label: 'floorNum',
                              iconColor: AppTheme.textColor,
                              maxLength: 150,
                              type: TextInputType.multiline,
                              padding: EdgeInsets.symmetric(vertical: Get.height * .02),
                              isBigRad: false,
                              controller: controller.floorNumberController,
                              shakeKey: controller.floorNumberShakeKey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
