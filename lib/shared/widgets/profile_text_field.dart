import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/core/utils/app_log.dart';
import 'package:mozaic_loyalty_sdk/shared/widgets/shake_widget.dart';

import '../../core/utils/theme.dart';
import '../helper/shared_helper.dart';

class ProfileTextField extends StatelessWidget {
  const ProfileTextField({
    super.key,
    required this.label,
    required this.shakeKey,
    required this.type,
    required this.maxLength,
    required this.controller,
    this.validator,
    this.icon,
    this.readOnly = false,
    this.isOptional = false,
    this.isUpper = false,
    this.onTap,
    this.maxLine,
    this.iconColor,
    this.isBigRad = false,
    this.padding,
    this.showLabelAsHeader = true,
    this.focusNode,
    this.textAlign = TextAlign.start,
  });

  final String label;
  final GlobalKey shakeKey;
  final String? icon;
  final int maxLength;
  final TextInputType type;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool isOptional;
  final bool isBigRad;
  final Color? iconColor;
  final bool isUpper;
  final int? maxLine;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? padding;
  final bool showLabelAsHeader;
  final void Function()? onTap;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          if (showLabelAsHeader)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Row(
                children: [
                  Text(
                    label.tr,
                    style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                  ),
                ],
              ),
            ),
          ShakeWidget(
            key: shakeKey,
            child: TextFormField(
              textAlign: textAlign,
              focusNode: focusNode,
              onTap: onTap,
              inputFormatters: [if (isUpper) UpperCaseTextFormatter()],
              readOnly: readOnly,
              validator: validator,
              keyboardType: type,
              maxLength: maxLength,
              onChanged: (value) {
                appLog(value);
              },
              controller: controller,
              maxLines: maxLine ?? 1,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              textDirection: SharedHelper().isRTL(controller.text) ? TextDirection.rtl : TextDirection.ltr,
              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppTheme.bgThemeColor,
                counter: const SizedBox(width: 0, height: 0),
                hintText: label.tr,
                hintStyle: AppTheme.textStyle(color: AppTheme.greyColor, size: AppTheme.size14),
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
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: AppTheme.redColor.withOpacity(.7)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(color: AppTheme.redColor.withOpacity(.9), width: 1.2),
                ),

                errorMaxLines: 3,
                errorStyle: AppTheme.textStyle(color: AppTheme.redColor, size: AppTheme.size12),

                prefixIcon: icon == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(.08),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppTheme.primaryColor.withOpacity(.12)),
                          ),
                          child: Center(child: SvgPicture.asset(icon!, color: iconColor ?? AppTheme.primaryColor, width: 20)),
                        ),
                      ),

                suffixIcon: isOptional
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 12),
                              Text(
                                "optional".tr,
                                style: AppTheme.textStyle(color: AppTheme.greyColor, size: AppTheme.size14),
                              ),
                              SizedBox(width: 12),
                            ],
                          ),
                        ],
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(text: newValue.text.toUpperCase(), selection: newValue.selection);
  }
}
