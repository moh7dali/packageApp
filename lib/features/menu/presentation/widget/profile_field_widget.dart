import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/utils/theme.dart';
import '../../../../my_custom_widget.dart';

class ProfileFieldWidget extends StatelessWidget {
  const ProfileFieldWidget({super.key, required this.title, this.image, this.isLtr = true, required this.label, this.onTap, this.isDelete = false});

  final String title;
  final String label;
  final String? image;
  final bool isLtr;
  final bool isDelete;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = AppTheme.bigBorderRadius;
    final borderColor = isDelete ? AppTheme.redColor.withOpacity(.25) : AppTheme.primaryColor.withOpacity(.9);
    final bgColor = isDelete ? AppTheme.redColor.withOpacity(.08) : AppTheme.bgThemeColor;
    final iconBg = isDelete ? AppTheme.redColor.withOpacity(.12) : AppTheme.primaryColor.withOpacity(.10);
    final textColor = isDelete ? AppTheme.redColor : AppTheme.textColor;

    return Directionality(
      textDirection: appLanguage == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: InkWell(
        onTap: () {
          if (onTap != null) onTap!();
        },
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  label.tr,
                  style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.65), size: AppTheme.size12, isBold: true),
                ),
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: borderRadius,
                  border: Border.all(color: borderColor, width: 1),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 16, offset: const Offset(0, 10))],
                ),
                child: Row(
                  children: [
                    if (image != null) ...[
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: iconBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: borderColor),
                        ),
                        child: Center(
                          child: isDelete
                              ? Icon(Icons.delete_forever_outlined, color: AppTheme.redColor, size: 22)
                              : SvgPicture.asset(image!, color: AppTheme.primaryColor, width: 20),
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],

                    Expanded(
                      child: Text(
                        title,
                        style: AppTheme.textStyle(color: textColor, size: AppTheme.size16, isBold: true),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
