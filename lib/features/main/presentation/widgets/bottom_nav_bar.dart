import 'dart:io';

import 'package:my_custom_widget/features/main/presentation/getx/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import 'navigation_item_widget.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        final h = Platform.isIOS ? 92.0 : 78.0;

        return SafeArea(
          top: false,
          child: Container(
            height: h,
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.92),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: AppTheme.primaryColor.withOpacity(.10)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(.08), blurRadius: 26, offset: const Offset(0, 14))],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavigationItem(
                    label: 'homeTab'.tr,
                    isSvg: true,
                    image: AssetsConsts.homeFill,
                    isActive: controller.currentIndex == 0,
                    onTap: () => controller.onTapChanged(0),
                  ),
                  NavigationItem(
                    label: 'points'.tr,
                    image: AssetsConsts.points,
                    isSvg: true,
                    isActive: controller.currentIndex == 2,
                    onTap: () => controller.onTapChanged(2),
                  ),
                  NavigationItem(
                    label: 'rewards'.tr,
                    image: AssetsConsts.rewards,
                    isSvg: true,
                    isActive: controller.currentIndex == 3,
                    onTap: () => controller.onTapChanged(3),
                  ),
                  NavigationItem(
                    label: 'branches'.tr,
                    isSvg: true,
                    image: AssetsConsts.tabBranches,
                    isActive: controller.currentIndex == 1,
                    onTap: () => controller.onTapChanged(1),
                  ),
                  NavigationItem(
                    label: 'menu'.tr,
                    image: AssetsConsts.menu,
                    isSvg: true,
                    isActive: controller.currentIndex == 4,
                    onTap: () => controller.onTapChanged(4),
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
