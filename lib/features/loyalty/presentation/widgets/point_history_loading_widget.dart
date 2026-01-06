import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';

class PointHistoryLoadingWidget extends StatelessWidget {
  const PointHistoryLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: Get.width * .06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    image: DecorationImage(image: AssetImage(AssetsConsts.loading), fit: BoxFit.cover),
                  ),
                  child: Text(
                    "",
                    style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
                  ),
                ),
                const SizedBox(width: 18),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(121),
                    image: DecorationImage(image: AssetImage(AssetsConsts.loading), fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(121),
                      image: DecorationImage(image: AssetImage(AssetsConsts.loading), fit: BoxFit.cover),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(121),
                      image: DecorationImage(image: AssetImage(AssetsConsts.loading), fit: BoxFit.cover),
                    ),
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
