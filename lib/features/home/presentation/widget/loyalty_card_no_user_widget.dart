import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/core/utils/translate/translation.dart';

import '../../../../core/utils/theme.dart';
import '../getx/home_controller.dart';

class LoyaltyCardNoUserWidget extends StatelessWidget {
  const LoyaltyCardNoUserWidget({super.key, required this.homeController});

  final SDKHomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppTheme.gradient1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.size18),
        child: Column(
          children: [
            SizedBox(height: Get.height * .02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "notEnrolled".sdkTr,
                    style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14, isBold: true),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(.2), borderRadius: AppTheme.borderRadius),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: homeController.homeDetails?.tiers?.tiers?.firstWhereOrNull((element) => element.id == 1)?.imageUrl ?? "",
                            errorWidget: (context, url, error) => Container(),
                            height: Get.height * .024,
                          ),
                          SizedBox(width: 8),
                          Text(
                            (homeController.homeDetails?.tiers?.tiers?.firstWhereOrNull((element) => element.id == 1)?.name ?? "").toUpperCase().sdkTr,
                            style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14, isBold: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * .02),
          ],
        ),
      ),
    );
  }
}
