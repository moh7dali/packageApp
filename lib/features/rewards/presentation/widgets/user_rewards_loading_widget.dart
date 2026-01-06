import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';

class UserRewardsLoadingWidget extends StatelessWidget {
  const UserRewardsLoadingWidget({super.key, this.hasImg = true});

  final bool hasImg;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.accentColor,
        borderRadius: AppTheme.borderRadius,
        border: Border.all(color: AppTheme.accentColor, width: 2),
      ),
      child: Column(
        children: [
          if (hasImg)
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: AppTheme.borderRadius,
                    child: Image.asset(AssetsConsts.loading, width: Get.width * .4, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: AppTheme.borderRadius,
                    child: Image.asset(AssetsConsts.loading, height: 20, width: Get.width, fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: AppTheme.borderRadius,
                    child: Image.asset(AssetsConsts.loading, height: 40, width: Get.width, fit: BoxFit.cover),
                  ),
                ),
              ),
            ],
          ),
          if (hasImg)
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(AssetsConsts.loading, height: 20, width: Get.width * .4, fit: BoxFit.cover),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(AssetsConsts.loading, height: 20, width: Get.width * .4, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
