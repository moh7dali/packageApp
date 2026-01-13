import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/loyalty/presentation/getx/points_controller.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../pages/point_schema_page.dart';

class NewLoyaltyCardWidget extends StatelessWidget {
  const NewLoyaltyCardWidget({super.key, required this.controller});

  final UserBalanceHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => SharedHelper().scaleDialog(PointSchemaPage()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: AppTheme.bigBorderRadius,
            border: Border.all(color: AppTheme.primaryColor.withOpacity(0.25), width: 1),
            boxShadow: [BoxShadow(color: AppTheme.textColor.withOpacity(0.10), blurRadius: 18, offset: const Offset(0, 10))],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 40),
                    Expanded(
                      child: Text(
                        (controller.userTierData?.name ?? "").toUpperCase(),
                        textAlign: TextAlign.center,
                        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size20, isBold: true),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.textColor.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.textColor.withOpacity(0.14)),
                      ),
                      child: Icon(Icons.info_outline, color: AppTheme.textColor, size: 18),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                if ((controller.userLoyaltyData?.loyaltyData?.currentTier != 1))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "${'validUntil'.tr} ${SharedHelper.dateFormatToString(controller.userLoyaltyData?.loyaltyData?.tierExpiryDate ?? DateTime.now())}",
                      textAlign: TextAlign.center,
                      style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.85), size: AppTheme.size12),
                    ),
                  ),

                if ((controller.userLoyaltyData?.loyaltyData?.currentTier ?? 0) < (controller.userLoyaltyData?.tiers?.length ?? 0))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(children: [Expanded(child: getNextTier((controller.userLoyaltyData?.loyaltyData?.currentTier ?? 0), controller))]),
                  ),

                Row(children: [Expanded(child: getMaintainingAmountText((controller.userLoyaltyData?.loyaltyData?.currentTier ?? 0), controller))]),

                const SizedBox(height: 14),

                Container(height: 1, color: AppTheme.textColor.withOpacity(0.12)),

                const SizedBox(height: 14),

                Row(
                  children: [
                    LoyaltyCardDetails(
                      controller: controller,
                      label: "visits".tr,
                      value: controller.userLoyaltyData?.loyaltyData?.numberOfVisits ?? 0,
                    ),
                    const SizedBox(width: 10),
                    LoyaltyCardDetails(
                      controller: controller,
                      label: "points".tr,
                      value: controller.userLoyaltyData?.loyaltyData?.pointsBalance ?? 0,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    LoyaltyCardDetails(
                      controller: controller,
                      label: "redeemed".tr,
                      value: controller.userLoyaltyData?.loyaltyData?.redeemedPoints ?? 0,
                    ),
                    const SizedBox(width: 10),
                    LoyaltyCardDetails(
                      controller: controller,
                      label: "expired".tr,
                      value: controller.userLoyaltyData?.loyaltyData?.expiredPoints ?? 0,
                    ),
                  ],
                ),
                // const SizedBox(height: 10),
                // Row(
                //   children: [
                //     LoyaltyCardDetails(
                //       img: AssetsConsts.loyaltyRedeemedIcon,
                //       controller: controller,
                //       label: "redeemed".tr,
                //       value: controller.userLoyaltyData?.loyaltyData?.redeemedPoints ?? 0,
                //     ),
                //     const SizedBox(width: 10),
                //     LoyaltyCardDetails(
                //       img: AssetsConsts.loyaltyExpiredIcon,
                //       controller: controller,
                //       label: "expired".tr,
                //       value: controller.userLoyaltyData?.loyaltyData?.expiredPoints ?? 0,
                //     ),
                //   ],
                // ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getNextTier(int currentTier, UserBalanceHistoryController controller) {
    return RichText(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: "spend".tr,
        style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
        children: [
          TextSpan(
            style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
            children: [
              TextSpan(text: " ${getRemaining(currentTier, controller)} "),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: SarWidget(size: 14, color: AppTheme.textColor),
              ),
            ],
          ),
          TextSpan(
            text: ' ${'toReach'.tr} ',
            style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
          ),
          TextSpan(
            text: '${controller.nextTier}',
            style: AppTheme.textStyle(
              color: AppTheme.fromHex(
                controller.userLoyaltyData?.tiers?.firstWhereOrNull((element) => element.id == (currentTier + 1))?.tierColor ??
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

  Widget getMaintainingAmountText(int currentTier, UserBalanceHistoryController controller) {
    return getMaintainingAmount(currentTier, controller) != null
        ? RichText(
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
            text: TextSpan(
              text: "spend".tr,
              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
              children: [
                TextSpan(
                  style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                  children: [
                    TextSpan(text: " ${getMaintainingAmount(currentTier, controller)} "),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: SarWidget(size: 14, color: AppTheme.textColor),
                    ),
                  ],
                ),
                TextSpan(
                  text: ' ${'toStayIn'.tr} ',
                  style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                ),
                TextSpan(
                  text: controller.userTierData?.name ?? "",
                  style: AppTheme.textStyle(color: controller.getTierColor(), size: AppTheme.size14),
                ),
              ],
            ),
          )
        : Container();
  }

  String getRemaining(int currentTier, UserBalanceHistoryController controller) {
    double max = controller.tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["max"];
    double min = controller.tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["lower"];
    double tierAmount = controller.userLoyaltyData?.loyaltyData?.tierAmount ?? 0;
    return SharedHelper.getNumberFormat((max - (min + tierAmount)), isCurrency: true);
  }

  String? getMaintainingAmount(int currentTier, UserBalanceHistoryController controller) {
    double maintainingAmount = controller.tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["maintainingAmount"] ?? 0;
    double tierAmount = controller.userLoyaltyData?.loyaltyData?.tierAmount ?? 0;
    if (maintainingAmount > tierAmount) {
      return SharedHelper.getNumberFormat(maintainingAmount - tierAmount);
    } else {
      return null;
    }
  }
}

class LoyaltyCardDetails extends StatelessWidget {
  const LoyaltyCardDetails({super.key, required this.label, this.value = 0, required this.controller});

  final String label;
  final dynamic value;
  final UserBalanceHistoryController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.textColor.withOpacity(0.06),
          border: Border.all(color: AppTheme.textColor.withOpacity(0.12)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label.tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(0.85), size: AppTheme.size12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "$value",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16, isBold: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
