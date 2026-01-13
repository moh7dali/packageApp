import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/theme.dart';
import '../../../rewards/domain/entity/campaign_details.dart';

class MissionsWidget extends StatelessWidget {
  const MissionsWidget({super.key, required this.campaignDetails, required this.onTab, this.isHome = false, this.isPrimary = false});

  final CampaignDetails campaignDetails;
  final Function onTab;
  final bool isHome;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    if (isHome) {
      return _buildHomeCard(context);
    }
    Color textColor = AppTheme.textColor;
    return GestureDetector(
      onTap: () => onTab(),
      child: Container(
        width: Get.width,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: AppTheme.borderRadius,
          border: Border.all(color: AppTheme.primaryColor.withOpacity(.1), width: 2),
          boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(.2), blurRadius: 2, blurStyle: BlurStyle.outer)],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                campaignDetails.name ?? "",
                style: AppTheme.textStyle(color: textColor, size: AppTheme.size20, isBold: true),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      campaignDetails.description ?? "",
                      style: AppTheme.textStyle(color: textColor, size: AppTheme.size14),
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "discoverNow".tr,
                    style: AppTheme.textStyle(
                      color: isPrimary ? AppTheme.whiteColor : AppTheme.primaryColor,
                      size: AppTheme.size16,
                    ).copyWith(decoration: TextDecoration.underline, decorationColor: isPrimary ? AppTheme.whiteColor : AppTheme.primaryColor),
                  ),
                  Icon(Icons.navigate_next, color: isPrimary ? AppTheme.whiteColor : AppTheme.primaryColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeCard(BuildContext context) {
    final Color textColor = AppTheme.textColor;
    return GestureDetector(
      onTap: () => onTab(),
      child: Container(
        width: Get.width * .60,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        decoration: BoxDecoration(
          color: AppTheme.bgThemeColor.withOpacity(.75),
          borderRadius: AppTheme.bigBorderRadius,
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.12), width: 1.4),
          boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(.06), blurRadius: 12, offset: const Offset(0, 6))],
        ),
        child: Container(
          margin: const EdgeInsets.all(1),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppTheme.bgThemeColor.withOpacity(.75),
            borderRadius: AppTheme.borderRadius,
            boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(.10), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.06), borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("✨", style: TextStyle(fontSize: 12)),
                          const SizedBox(width: 4),
                          Text(
                            "Deals".tr,
                            style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size10, isBold: true),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      campaignDetails.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.textStyle(color: textColor, size: AppTheme.size14, isBold: true),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      campaignDetails.description ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.textStyle(color: textColor.withOpacity(0.8), size: AppTheme.size12),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.06), borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppTheme.primaryColor),
                              const SizedBox(width: 4),
                              Text(
                                "discoverNow".tr,
                                style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size10, isBold: true),
                              ),
                            ],
                          ),
                        ),
                      ],
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
