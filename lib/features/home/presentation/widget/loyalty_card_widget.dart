import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/home/presentation/widget/loyalty_card_no_user_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../getx/home_controller.dart';

class LoyaltyCardWidget extends StatelessWidget {
  const LoyaltyCardWidget({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return homeController.customerData == null
        ? LoyaltyCardNoUserWidget(homeController: homeController)
        : Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                homeController.gotoRewards(isPoints: true, isDeals: false);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: AppTheme.bigBorderRadius,
                  border: Border.all(color: AppTheme.primaryColor.withOpacity(0.25), width: 1),
                  boxShadow: [BoxShadow(color: AppTheme.textColor.withOpacity(0.10), blurRadius: 18, offset: const Offset(0, 10))],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ("${homeController.currentTier}").toUpperCase().tr,
                              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                            ),
                            BalanceCard(
                              title: "balance".tr,
                              value:
                                  "${SharedHelper.getNumberFormat(homeController.customerData?.customerLoyaltyData?.cashBalance ?? 0, isCurrency: true)}",
                              showCurrency: true,
                              onInfoTap: () {
                                homeController.gotoRewards(isPoints: true, isDeals: false);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: Get.height * .03,
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    final progress =
                                        homeController.valueOfTheLine(
                                          homeController.customerData?.customerLoyaltyData?.customerTierData?.currentTier ?? 0,
                                        ) ??
                                        0;
                                    final iconSize = Get.height * .03;
                                    final barWidth = constraints.maxWidth;
                                    return Stack(
                                      alignment: Alignment.bottomLeft,
                                      children: [
                                        Positioned(
                                          child: LinearPercentIndicator(
                                            width: barWidth,
                                            lineHeight: Get.height * .03,
                                            animation: true,
                                            animationDuration: 3000,
                                            barRadius: const Radius.circular(20),
                                            percent: progress,
                                            linearGradient: AppTheme.gradient1,
                                            linearGradientBackgroundColor: AppTheme.gradient1.withOpacity(.2),
                                          ),
                                        ),
                                        Positioned(
                                          left: (barWidth - iconSize) * (progress),
                                          child: CachedNetworkImage(
                                            imageUrl: homeController.currentImageTier ?? "",
                                            errorWidget: (context, url, error) => Container(),
                                            fit: BoxFit.cover,
                                            height: iconSize,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            if ((homeController.customerData?.customerLoyaltyData?.customerTierData?.currentTier ?? 0) <
                                (homeController.homeDetails?.tiers?.tiers?.length ?? 0))
                              CachedNetworkImage(
                                imageUrl: homeController.nextImageTier ?? "",
                                errorWidget: (context, url, error) => Container(),
                                height: Get.height * .03,
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      if ((homeController.currentTierId ?? 0) < (homeController.homeDetails?.tiers?.tiers?.length ?? 0))
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(children: [Expanded(child: getNextTier((homeController.currentTierId ?? 0), homeController))]),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  String getRemaining(int currentTier, HomeController controller) {
    double max = controller.tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["max"];
    double min = controller.tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["lower"];
    double tierAmount = controller.customerData?.customerLoyaltyData?.customerTierData?.tierAmount ?? 0;
    return SharedHelper.getNumberFormat((max - (min + tierAmount)));
  }

  Widget getNextTier(int currentTier, HomeController controller) {
    return RichText(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: "${"spend".tr}",
        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
        children: [
          TextSpan(
            style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
            children: [
              TextSpan(text: " ${getRemaining(currentTier, controller)} "),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: SarWidget(size: 14, color: AppTheme.primaryColor),
              ),
            ],
          ),
          TextSpan(
            text: ' ${'toReach'.tr} ',
            style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
          ),
          TextSpan(
            text: '${controller.nextTier}',
            style: AppTheme.textStyle(
              color: AppTheme.fromHex(
                controller.homeDetails?.tiers?.tiers?.firstWhereOrNull((element) => element.id == (currentTier + 1))?.tierColor ??
                    AppTheme.primaryColorString,
              ),
              size: AppTheme.size14,
              isBold: true,
            ),
          ),
        ],
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onInfoTap;
  final bool showCurrency;

  const BalanceCard({super.key, required this.title, required this.value, required this.onInfoTap, this.showCurrency = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onInfoTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  value,
                  style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14).copyWith(fontWeight: FontWeight.w600),
                ),
                if (showCurrency) ...[const SizedBox(width: 4), SarWidget(color: AppTheme.textColor)],
              ],
            ),
          ),
          Text(
            title,
            style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(0.9), size: AppTheme.size12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
