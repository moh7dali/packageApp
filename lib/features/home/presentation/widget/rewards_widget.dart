import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../rewards/domain/entity/user_rewards.dart';

class HomeRewardCard extends StatelessWidget {
  const HomeRewardCard({super.key, required this.reward, required this.onTap});

  final UserRewards reward;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double cardWidth = Get.width * .45;

    final String statusText = _getStatusText(reward.status, reward.rewardTypeId);
    final Color statusColor = _getStatusColor(reward.status);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: AppTheme.bigBorderRadius),
          elevation: 3,
          shadowColor: AppTheme.primaryColor.withOpacity(0.12),
          color: AppTheme.whiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: AppTheme.bigBorderRadius.topLeft, topRight: AppTheme.bigBorderRadius.topRight),
                  child: CachedNetworkImage(
                    imageUrl: reward.imageUrl ?? "",
                    placeholder: (w, e) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
                    errorWidget: (c, e, s) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
                    width: cardWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            reward.title ?? "",
                            style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (statusText.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: statusColor.withOpacity(0.7), width: 0.7),
                            ),
                            child: Text(
                              statusText,
                              style: AppTheme.textStyle(color: statusColor, size: AppTheme.size10, isBold: true),
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

  String _getStatusText(int? status, int? rewardTypeId) {
    if (status == null) return "";

    if (status == 1) return 'valid'.tr;
    if (status == 2) return 'redeemed'.tr;
    if (status == 3) return 'expired'.tr;
    return "";
  }

  Color _getStatusColor(int? status) {
    if (status == 1) return Colors.green;
    if (status == 2) return Colors.orange;
    if (status == 3) return Colors.red;
    return AppTheme.primaryColor;
  }
}
