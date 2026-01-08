import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/ordering/presentation/widget/cart_icon_widget.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../core/utils/theme.dart';
import '../../../../my_custom_widget.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../barcode/presentation/getx/user_barcode_controller.dart';
import '../../../barcode/presentation/pages/barcode_screen.dart';
import '../../../home/presentation/getx/home_controller.dart';

AppBar heroAppBar({HomeController? controller, required Color bg}) {
  return AppBar(
    backgroundColor: bg,
    titleSpacing: 10,
    actions: [
      CartIconWidget(isHome: true),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () {
            Get.delete<UserBarcodeController>();
            SharedHelper().needLogin(() => SharedHelper().scaleDialog(BarcodeScreen()));
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.accentColor,
              boxShadow: [BoxShadow(color: AppTheme.secondaryColor, blurRadius: 5, offset: Offset(0, 0), blurStyle: BlurStyle.outer)],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(AssetsConsts.qr, height: Get.width * .075, color: AppTheme.primaryColor),
            ),
          ),
        ),
      ),
      Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            child: GestureDetector(
              onTap: () {
                SharedHelper().needLogin(() => SDKNav.toNamed(RouteConstant.notificationsPage));
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accentColor,
                  boxShadow: [BoxShadow(color: AppTheme.secondaryColor, blurRadius: 5, offset: Offset(0, 0), blurStyle: BlurStyle.outer)],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(AssetsConsts.notificationIcon, height: Get.width * .1),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: numOfUnReadNotifications,
            builder: (context, value, child) {
              if (value > 0) {
                return Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    height: 20,
                    width: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        '${value <= 9 ? value : '+9'}',
                        style: AppTheme.textStyle(color: AppTheme.accentColor, size: AppTheme.size16, isBold: true),
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    ],
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
