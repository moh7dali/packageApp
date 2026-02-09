import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mozaic_loyalty_sdk/core/utils/translate/translation.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../domain/entity/user_rewards.dart';

class UserRewardsWidget extends StatelessWidget {
  const UserRewardsWidget({super.key, required this.userRewards});

  final UserRewards userRewards;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: AppTheme.borderRadius,
        border: Border.all(color: AppTheme.primaryColor.withOpacity(.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(.4),
            blurRadius: 5,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: AppTheme.borderRadius,
            child: CachedNetworkImage(
              imageUrl: userRewards.imageUrl ?? "",
              placeholder: (w, e) => Image.asset(
                AssetsConsts.loading,
                fit: BoxFit.cover,
              ),
              errorWidget: (c, e, s) => Image.asset(AssetsConsts.loading),
              width: Get.width,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              userRewards.title ?? "",
              style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  userRewards.description ?? "",
                  style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                )),
              ],
            ),
          ),
          if (userRewards.expiryDate != null)
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${'validUntil'.sdkTr}: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(userRewards.expiryDate!))}',
                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                    ),
                  ),
                ],
              ),
            ),
          if (userRewards.status != null && userRewards.rewardTypeId != 3)
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    '${'status'.sdkTr}: ',
                    style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                  ),
                  userRewards.status == 1
                      ? Expanded(
                          child: Text(
                            '[${'valid'.sdkTr}]',
                            style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                          ),
                        )
                      : userRewards.status == 2
                          ? Expanded(
                              child: Text(
                                '[${'redeemed'.sdkTr}]',
                                style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                              ),
                            )
                          : userRewards.status == 3
                              ? Expanded(
                                  child: Text(
                                    '[${'expired'.sdkTr}]',
                                    style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                                  ),
                                )
                              : Text("")
                ],
              ),
            )
        ],
      ),
    );
  }
}
