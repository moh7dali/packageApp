import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/sdk/sdk_routes.dart';
import '../../../../core/utils/theme.dart';
import '../../../../mozaic_loyalty_sdk.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../domain/entity/user_rewards.dart';

class RewardCardWidget extends StatelessWidget {
  const RewardCardWidget({super.key, this.reward, this.isMyRewards = false});

  final UserRewards? reward;
  final bool isMyRewards;

  @override
  Widget build(BuildContext context) {
    final img = reward?.imageUrl ?? "";
    final hasStatus = reward?.status != null && reward?.rewardTypeId != 3;

    final statusText = !hasStatus
        ? ""
        : reward?.status == 1
        ? 'valid'.tr
        : reward?.status == 2
        ? 'redeemed'.tr
        : reward?.status == 3
        ? 'expired'.tr
        : '';

    final statusColor = !hasStatus
        ? AppTheme.primaryColor
        : reward?.status == 1
        ? Colors.green
        : reward?.status == 2
        ? AppTheme.primaryColor
        : reward?.status == 3
        ? Colors.red
        : AppTheme.primaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: GestureDetector(
        onTap: () {
          SharedHelper().actionDialog(
            "${reward?.title}",
            "${reward?.description}${isMyRewards ? "\n\n${reward?.creationDate != null ? '${"creationDate".tr}: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(reward!.creationDate!))}' : ""}\n ${reward?.expiryDate != null ? '${"expiryDate".tr}: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(reward!.expiryDate!))}'
                            '${(reward?.status != null && reward?.rewardTypeId != 3) ? '\n${"status".tr}:' : ""}${(reward?.status != null && reward?.rewardTypeId != 3)
                                ? reward?.status == 1
                                      ? 'valid'.tr
                                      : reward?.status == 2
                                      ? 'redeemed'.tr
                                      : reward?.status == 3
                                      ? 'expired'.tr
                                      : ''
                                : ''}' : ""}" : ""}",
            hasImage: true,
            image: img,
            confirmText: "close".tr,
            noCancel: true,
            confirm: () => SDKNav.back(),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.bgThemeColor,
            borderRadius: AppTheme.bigBorderRadius,
            border: Border.all(color: AppTheme.primaryColor),
            boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.06), blurRadius: 14, offset: const Offset(0, 6))],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE (constrained width => AspectRatio works, no crash)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: appLanguage == "en" ? const Radius.circular(16) : Radius.zero,
                  bottomLeft: appLanguage == "en" ? const Radius.circular(16) : Radius.zero,
                  topRight: appLanguage == "ar" ? const Radius.circular(16) : Radius.zero,
                  bottomRight: appLanguage == "ar" ? const Radius.circular(16) : Radius.zero,
                ),
                child: SizedBox(
                  width: Get.width * 0.33,
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: CachedNetworkImage(
                      imageUrl: img,
                      fit: BoxFit.cover,
                      placeholder: (w, e) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
                      errorWidget: (c, e, s) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),

              // CONTENT
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title + status pill
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${reward?.title.toString().capitalize}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16, isBold: true),
                            ),
                          ),
                          if (hasStatus) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.10),
                                border: Border.all(color: statusColor.withOpacity(0.30)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                statusText,
                                style: AppTheme.textStyle(color: statusColor, size: AppTheme.size10, isBold: true),
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 8),
                      Text(
                        reward?.description ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(0.75), size: AppTheme.size12),
                      ),

                      if (isMyRewards) ...[
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            if (reward?.creationDate != null)
                              _dateChip(
                                icon: Icons.calendar_today_outlined,
                                label: "creationDate".tr,
                                value: DateFormat('yyyy-MM-dd').format(DateTime.parse(reward!.creationDate!)),
                              ),
                            if (reward?.expiryDate != null)
                              _dateChip(
                                icon: Icons.event_outlined,
                                label: "expiryDate".tr,
                                value: DateFormat('yyyy-MM-dd').format(DateTime.parse(reward!.expiryDate!)),
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateChip({required IconData icon, required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.06),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.12)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.primaryColor.withOpacity(0.8)),
          const SizedBox(width: 6),
          Text(
            "$label: $value",
            style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(0.75), size: AppTheme.size10, isBold: true),
          ),
        ],
      ),
    );
  }
}
