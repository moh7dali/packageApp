import 'package:my_custom_widget/features/rewards/domain/entity/campaign_details.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/theme.dart';

class OccasionCampaignCard extends StatelessWidget {
  const OccasionCampaignCard({super.key, required this.campaignDetails, required this.onTap});

  final CampaignDetails campaignDetails;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final title = campaignDetails.name ?? "";
    final desc = campaignDetails.description ?? "";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(1.4),
          decoration: BoxDecoration(
            borderRadius: AppTheme.bigBorderRadius,
            gradient: LinearGradient(
              colors: [AppTheme.primaryColor.withOpacity(.55), AppTheme.primaryColor.withOpacity(.18)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.whiteColor,
              borderRadius: AppTheme.bigBorderRadius,
              boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 8))],
            ),
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Title + icon bubble
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16, isBold: true),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.primaryColor.withOpacity(0.10),
                        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.18)),
                      ),
                      child: Icon(Icons.celebration_rounded, size: 20, color: AppTheme.primaryColor),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.05),
                    borderRadius: AppTheme.borderRadius,
                    border: Border.all(color: AppTheme.primaryColor.withOpacity(0.10)),
                  ),
                  child: Text(
                    desc,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size12),
                  ),
                ),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
