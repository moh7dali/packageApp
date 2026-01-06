import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';

class PagesCardsLoading extends StatelessWidget {
  const PagesCardsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: AppTheme.borderRadius,
            child: Image.asset(AssetsConsts.loading, width: Get.width, fit: BoxFit.cover, height: Get.height * .15),
          ),
          SizedBox(height: Get.height * .02),
          GridView.builder(
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.85,
            ),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(AssetsConsts.loading, width: Get.width, fit: BoxFit.cover, height: Get.height * .1),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
