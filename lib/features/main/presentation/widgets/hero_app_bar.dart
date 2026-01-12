import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/shared/widgets/hero_logo.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../home/presentation/getx/home_controller.dart';

AppBar heroAppBar({HomeController? controller, required Color bg}) {
  return AppBar(
    backgroundColor: bg,
    titleSpacing: 10,
    title: Row(
      children: [
        SizedBox(height: Get.height * .06, child: HeroLogo()),
        SizedBox(width: 10),
        if (controller != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${controller.homeWelcomeTitle}👋",
                style: AppTheme.textStyle(color: AppTheme.whiteColor.withOpacity(.7), size: AppTheme.size14),
              ),
              const SizedBox(height: 4),
              controller.isHomeLoading
                  ? ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(AssetsConsts.loading, width: Get.width * .35, fit: BoxFit.cover, height: 10),
                    )
                  : Text(
                      controller.customerData?.customerInfo?.fullName ?? "",
                      style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size18),
                    ),
            ],
          ),
      ],
    ),
  );
}
