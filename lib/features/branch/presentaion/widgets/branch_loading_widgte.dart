import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/core/constants/assets_constants.dart';

import '../../../../core/utils/theme.dart';

class BranchLoadingWidget extends StatelessWidget {
  const BranchLoadingWidget({super.key, this.extraHeight = false});
  final bool extraHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.bgThemeColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppTheme.borderRadius,
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              AssetsConsts.loading,
              width: Get.width,
              fit: BoxFit.cover,
              height: extraHeight ? Get.height * .4 : Get.height * .1,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    AssetsConsts.loading,
                    fit: BoxFit.cover,
                    width: Get.width,
                    height: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
