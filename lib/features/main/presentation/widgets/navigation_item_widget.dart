import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/utils/theme.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    super.key,
    required this.label,
    required this.image,
    required this.isActive,
    required this.onTap,
    this.isSvg = false,
    this.isCenter = false,
  });

  final String label;
  final String image;
  final bool isActive;
  final bool isSvg;
  final bool isCenter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = isActive ? AppTheme.primaryColor : AppTheme.greyColor.shade500;
    final iconSize = isCenter ? Get.width * 0.10 : Get.width * 0.065;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 12 : 8,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryColor.withOpacity(.10) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isActive ? AppTheme.primaryColor.withOpacity(.18) : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isSvg
                ? SvgPicture.asset(image, color: iconColor, width: iconSize)
                : Image.asset(image, width: iconSize, color: iconColor),

            if (!isCenter) ...[
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                child: isActive
                    ? Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    label,
                    style: AppTheme.textStyle(
                      color: AppTheme.primaryColor,
                      size: AppTheme.size12,
                      isBold: true,
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

