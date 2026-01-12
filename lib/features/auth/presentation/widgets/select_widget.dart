import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/shared/widgets/button_widget.dart';

import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../domain/entities/gender.dart';
import '../getx/auth_controller.dart';

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
  });

  final String tag;
  final String title;
  final List? listOfItems;
  T? selectedItem;
  final bool isDate;
  final bool isAddress;
  final AuthController? controller;

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
                        widget.controller?.isTheCupertinoPickerMove = true;
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
                      widget.controller?.isTheCupertinoPickerMove = true;
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
                if ((widget.selectedItem == null || widget.controller?.isTheCupertinoPickerMove == false) && widget.isDate == false) {
                  widget.selectedItem = widget.listOfItems?.firstOrNull;
                } else if ((widget.selectedItem == null || widget.controller?.isTheCupertinoPickerMove == false) && widget.isDate) {
                  widget.selectedItem = DateTime(2000) as T?;
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
                }
                if (widget.isAddress) {
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
