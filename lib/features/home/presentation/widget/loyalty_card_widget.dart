import 'package:my_custom_widget/features/home/presentation/widget/loyalty_card_no_user_widget.dart';
import 'package:my_custom_widget/shared/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../../../barcode/presentation/getx/user_barcode_controller.dart';
import '../../../barcode/presentation/pages/barcode_screen.dart';
import '../getx/home_controller.dart';

class LoyaltyCardWidget extends StatelessWidget {
  const LoyaltyCardWidget({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return homeController.customerData == null
        ? LoyaltyCardNoUserWidget(homeController: homeController)
        : GestureDetector(
            onTap: () {
              homeController.gotoRewards(isPoints: true, isDeals: false);
            },
            child: Container(
              decoration: BoxDecoration(gradient: AppTheme.gradient1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BalanceCard(
                          title: "wallet".tr,
                          value: SharedHelper.getNumberFormat(homeController.customerData?.customerLoyaltyData?.wallet ?? 0, isCurrency: true),
                          icon: Icons.account_balance_wallet_outlined,
                          showCurrency: true,
                          onInfoTap: () {
                            // Get.toNamed(RouteConstant.topUpPage, arguments: homeController.customerData?.customerLoyaltyData?.wallet);
                            homeController.gotoRewards(isPoints: true, isDeals: false);
                          },
                        ),

                        BalanceCard(
                          title: "points".tr,
                          value: SharedHelper.getNumberFormat(homeController.customerData?.customerLoyaltyData?.pointsBalance ?? 0),
                          icon: Icons.star_border_rounded,
                          onInfoTap: () {
                            homeController.gotoRewards(isPoints: true, isDeals: false);
                          },
                        ),
                        Column(
                          children: [
                            Text(
                              homeController.currentTier ?? "",
                              style: AppTheme.textStyle(color: AppTheme.whiteColor.withOpacity(0.9), size: AppTheme.size20, isBold: true),
                            ),
                            const SizedBox(height: 8),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: Stack(
                                children: [
                                  LiquidCustomProgressIndicator(
                                    value: homeController.valueOfTheLine(homeController.currentTierId ?? 0) ?? 0,
                                    valueColor: AlwaysStoppedAnimation(homeController.getTierColor(homeController.currentTierId ?? 0)),
                                    backgroundColor: AppTheme.whiteColor,
                                    direction: Axis.vertical,
                                    shapePath: buildCupPath(),
                                  ),
                                  Image.asset(AssetsConsts.cup, height: 100, width: 100),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppButton(
                              title: "topUp".tr,
                              isDoneBtn: true,
                              function: () {
                                Get.toNamed(RouteConstant.topUpListScreen);
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: AppButton(
                              title: "redeemPoints".tr,
                              isDoneBtn: false,
                              function: () {
                                Get.delete<UserBarcodeController>();
                                SharedHelper().needLogin(() => SharedHelper().scaleDialog(BarcodeScreen()));
                              },
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

  Widget tier3DCircle({required HomeController homeController}) {
    final percent = homeController.valueOfTheLine(homeController.customerData?.customerLoyaltyData?.customerTierData?.currentTier ?? 0) ?? 0.0;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              center: Alignment(-0.3, -0.3),
              radius: 0.9,
              colors: [
                homeController.getTierColor(homeController.currentTierId ?? 1),
                homeController.getTierColor(homeController.currentTierId ?? 1),
              ],
            ),
            border: Border.all(color: const Color(0xFFCACACA), width: 1.2),
            boxShadow: const [
              BoxShadow(color: Colors.white, blurRadius: 8, offset: Offset(-3, -3)),
              BoxShadow(color: Color(0x33000000), blurRadius: 18, offset: Offset(4, 8)),
            ],
          ),
        ),

        Transform.scale(
          scale: 0.985,
          child: CircularPercentIndicator(
            radius: 65,
            lineWidth: 15,
            percent: 1,
            backgroundColor: Colors.transparent,
            circularStrokeCap: CircularStrokeCap.round,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFD8D8D8), AppTheme.whiteColor.withOpacity(0.08), Color(0xFF7E6E6E)],
            ),
          ),
        ),

        CircularPercentIndicator(
          radius: 65,
          lineWidth: 15,
          percent: percent.clamp(0.0, 1.0),
          backgroundColor: Colors.transparent,
          circularStrokeCap: CircularStrokeCap.round,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [homeController.getTierColor(homeController.currentTierId ?? 1), homeController.getTierColor(homeController.currentTierId ?? 1)],
          ),
          center: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${homeController.currentTier}",
                style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size20),
              ),
              const SizedBox(height: 4),
              Text(
                "${(percent * 100).toStringAsFixed(0)} %",
                style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Path buildCupPath() {
    final path = Path()
      ..moveTo(19, 15)
      ..lineTo(31, 94)
      ..lineTo(69, 94)
      ..lineTo(81, 15);
    return path;
  }
}

class BalanceCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onInfoTap;
  final bool showCurrency;

  const BalanceCard({super.key, required this.title, required this.value, required this.icon, required this.onInfoTap, this.showCurrency = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onInfoTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          // color: AppTheme.whiteColor.withOpacity(0.04),
          // borderRadius: AppTheme.bigBorderRadius,
          // border: Border.all(color: AppTheme.whiteColor.withOpacity(0.15), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTheme.textStyle(color: AppTheme.whiteColor.withOpacity(0.9), size: AppTheme.size12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: AppTheme.whiteColor.withOpacity(0.08), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, size: AppTheme.size30, color: AppTheme.whiteColor),
            ),
            const SizedBox(height: 8),
            FittedBox(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    value,
                    style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14).copyWith(fontWeight: FontWeight.w600),
                  ),
                  if (showCurrency) ...[const SizedBox(width: 4), SarWidget(color: AppTheme.whiteColor)],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
