import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../../../my_custom_widget.dart';
import '../getx/menu_controller.dart';

class MenuTabItemWidget extends StatelessWidget {
  const MenuTabItemWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isNight = false,
    this.controller,
    this.isLast = false,
  });

  final String title;
  final String icon;
  final bool isNight;
  final MenuTabController? controller;
  final void Function() onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  // icon bubble
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.12)),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        icon,
                        color: AppTheme.primaryColor,
                        width: 20,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // title
                  Expanded(
                    child: Text(
                      title.tr,
                      style: AppTheme.textStyle(
                        color: AppTheme.textColor,
                        size: AppTheme.size14,
                        isBold: true,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(width: 8),

                  // trailing
                  isNight
                      ? Switch(
                    activeColor: AppTheme.primaryColor,
                    activeTrackColor: AppTheme.primaryColor.withOpacity(0.35),
                    inactiveTrackColor: Colors.grey.shade300,
                    value: controller!.changeTheme,
                    onChanged: (v) {
                      controller!.changeTheme = v;
                      controller!.update();
                      themeController.toggleTheme();
                      SDKNav.back();
                    },
                  )
                      : Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.chevron_right_rounded, color: AppTheme.primaryColor, size: 22),
                  ),
                ],
              ),
            ),

            if (!isLast) ...[
              const SizedBox(height: 8),
              Container(
                height: 1,
                margin: const EdgeInsets.only(left: 60, right: 6),
                color: AppTheme.primaryColor.withOpacity(0.08),
              ),
            ],
          ],
        ),
      ),
    );
  }
}