import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../home/presentation/getx/home_controller.dart';

AppBar heroAppBar({HomeController? controller, required Color bg}) {
  return AppBar(
    backgroundColor: bg,
    titleSpacing: 10,
    title: Row(
      children: [
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.whiteColor),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgPicture.asset(AssetsConsts.iconLogo, height: Get.height * .04),
          ),
        ),
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
