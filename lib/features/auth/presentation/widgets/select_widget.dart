import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/shared/widgets/button_widget.dart';

import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../../address/presentation/getx/address_controller.dart';
import '../../domain/entities/area.dart';
import '../../domain/entities/city.dart';
import '../../domain/entities/gender.dart';
import '../../domain/entities/look_up.dart';
import '../../domain/entities/marital_status.dart';
import '../getx/auth_controller.dart';
import '../getx/city_area_controller.dart';

class SelectWidget<T> extends StatefulWidget {
  SelectWidget({
    super.key,
    required this.tag,
    required this.title,
    this.listOfItems,
    this.selectedItem,
    this.isDate = false,
    this.isAddress = false,
    this.controller,
    this.addressController,
    this.cityAndAreaController,
  });

  final String tag;
  final String title;
  final List? listOfItems;
  T? selectedItem;
  final bool isDate;
  final bool isAddress;
  final AuthController? controller;
  final AddressController? addressController;
  final CityAndAreaController? cityAndAreaController;

  @override
  State<SelectWidget<T>> createState() => _SelectWidgetState<T>();
}

class _SelectWidgetState<T> extends State<SelectWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(1000)),
              height: 5,
              width: Get.width * .20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.title.tr,
            style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size18, isBold: true),
          ),
          SizedBox(
            height: widget.isDate ? Get.height * .3 : 125,
            child: widget.isDate
                ? CupertinoTheme(
                    data: CupertinoThemeData(
                      barBackgroundColor: Colors.transparent,
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      itemExtent: 40,
                      initialDateTime: DateTime(2000),
                      minimumDate: DateTime(1900),
                      maximumDate: DateTime.now(),
                      minuteInterval: 10,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (value) {
                        widget.selectedItem = value as T?;
                        if (widget.isAddress) {
                          widget.addressController?.isTheCupertinoPickerMove = true;
                        } else {
                          widget.controller?.isTheCupertinoPickerMove = true;
                        }
                      },
                    ),
                  )
                : (widget.listOfItems ?? []).isEmpty
                ? Center(
                    child: Text(
                      'citiesListEmpty'.tr,
                      style: AppTheme.textStyle(color: AppTheme.redColor, size: AppTheme.size12),
                    ),
                  )
                : CupertinoPicker(
                    itemExtent: 40,
                    onSelectedItemChanged: (int index) {
                      widget.selectedItem = widget.listOfItems![index];
                      if (widget.isAddress) {
                        widget.addressController?.isTheCupertinoPickerMove = true;
                      } else {
                        widget.controller?.isTheCupertinoPickerMove = true;
                      }
                    },
                    children: (widget.listOfItems ?? [])
                        .map(
                          (e) => Center(
                            child: Text(
                              '${e.name}',
                              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppButton(
              title: "done".tr,
              function: () {
                if (widget.isAddress) {
                  if ((widget.selectedItem == null || widget.addressController?.isTheCupertinoPickerMove == false) && widget.isDate == false) {
                    widget.selectedItem = widget.listOfItems?.firstOrNull;
                  } else if ((widget.selectedItem == null || widget.addressController?.isTheCupertinoPickerMove == false) && widget.isDate) {
                    widget.selectedItem = DateTime(2000) as T?;
                  }
                } else {
                  if ((widget.selectedItem == null || widget.controller?.isTheCupertinoPickerMove == false) && widget.isDate == false) {
                    widget.selectedItem = widget.listOfItems?.firstOrNull;
                  } else if ((widget.selectedItem == null || widget.controller?.isTheCupertinoPickerMove == false) && widget.isDate) {
                    widget.selectedItem = DateTime(2000) as T?;
                  }
                }

                switch (widget.tag) {
                  case SelectWidgetConstant.gender:
                    widget.controller?.selectedGenderType = widget.selectedItem as Gender?;
                    widget.controller?.genderController.text = widget.controller?.selectedGenderType?.name ?? "";
                    break;
                  case SelectWidgetConstant.dateOfBirth:
                    widget.controller?.selectedDateOfBirth = widget.selectedItem as DateTime?;
                    widget.controller?.bodController.text = widget.controller!.dateFormat.format(widget.controller!.selectedDateOfBirth!);
                    break;
                  case SelectWidgetConstant.maritalStatus:
                    widget.controller?.selectedMaritalStatus = widget.selectedItem as MaritalStatus?;
                    widget.controller?.maritalController.text = widget.controller?.selectedMaritalStatus?.name ?? "";
                    break;
                  case SelectWidgetConstant.anniversaryDate:
                    widget.controller?.selectedAnniversaryDate = widget.selectedItem as DateTime?;
                    widget.controller?.anniversaryController.text = widget.controller!.dateFormat.format(widget.controller!.selectedAnniversaryDate!);
                    break;
                  case SelectWidgetConstant.city:
                    if (widget.isAddress) {
                      widget.addressController?.selectedCity = widget.selectedItem as City?;
                      widget.addressController?.cityController.text = widget.addressController?.selectedCity?.name ?? "";
                      widget.cityAndAreaController?.allArea = [];
                      widget.addressController?.selectedArea == null;
                      widget.addressController?.areaController.text = '';
                      if (widget.addressController?.selectedCity != null) {
                        widget.cityAndAreaController?.getAreaList(cityId: widget.addressController?.selectedCity?.id ?? 0);
                      }
                    } else {
                      widget.controller?.selectedCity = widget.selectedItem as City?;
                      widget.controller?.cityController.text = widget.controller?.selectedCity?.name ?? "";
                      // widget.cityAndAreaController?.allArea = [];
                      // widget.controller?.selectedArea == null;
                      // widget.controller?.areaController.text = '';
                      // if (widget.controller?.selectedCity != null) {
                      //   widget.cityAndAreaController?.getAreaList(cityId: widget.controller?.selectedCity?.id ?? 0);
                      // }
                    }
                    break;
                  case SelectWidgetConstant.area:
                    if (widget.isAddress) {
                      widget.addressController?.selectedArea = widget.selectedItem as Area?;
                      widget.addressController?.areaController.text = widget.addressController?.selectedArea?.name ?? "";
                    } else {
                      widget.controller?.selectedArea = widget.selectedItem as Area?;
                      widget.controller?.areaController.text = widget.controller?.selectedArea?.name ?? "";
                    }
                    break;
                  case SelectWidgetConstant.lookup:
                    widget.controller?.selectedVisitorType = widget.selectedItem as LookUp?;
                    widget.controller?.visitorTypeController.text = widget.controller?.selectedVisitorType?.name ?? "";
                    break;
                }
                if (widget.isAddress) {
                  widget.addressController?.update();
                } else {
                  widget.controller?.update();
                }
                SDKNav.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
