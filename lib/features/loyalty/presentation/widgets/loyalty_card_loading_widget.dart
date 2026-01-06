import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';

class LoyaltyCardLoading extends StatelessWidget {
  const LoyaltyCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppTheme.gradient1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(radius: 48, backgroundImage: AssetImage(AssetsConsts.loading)),
                SizedBox(width: 16),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: AppTheme.borderRadius,
                    child: Image.asset(AssetsConsts.loading, height: Get.height * .025, width: Get.width * .25, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_buildLoadingColumn("Points"), _buildLoadingColumn("Visits")]),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_buildLoadingColumn("Redeem"), _buildLoadingColumn("Expired")]),
          ],
        ),
      ),
    );
  }

  // Helper method to build individual loading columns
  Widget _buildLoadingColumn(String title) {
    return Row(
      children: [
        CircleAvatar(radius: 24, backgroundImage: AssetImage(AssetsConsts.loading)),
        const SizedBox(height: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: AppTheme.borderRadius,
                child: Image.asset(AssetsConsts.loading, height: Get.height * .015, width: Get.width * .15, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: AppTheme.borderRadius,
                child: Image.asset(AssetsConsts.loading, height: Get.height * .015, width: Get.width * .1, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
