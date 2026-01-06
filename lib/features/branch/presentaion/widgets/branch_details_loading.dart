import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';

class BranchDetailsLoading extends StatelessWidget {
  const BranchDetailsLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AssetsConsts.loading,
          fit: BoxFit.cover,
          width: Get.width,
          height: Get.height * .28,
        ),
        SizedBox(height: 8),
        Image.asset(
          AssetsConsts.loading,
          fit: BoxFit.cover,
          width: Get.width,
          height: Get.height * .04,
        ),
        SizedBox(height: 8),
        Image.asset(
          AssetsConsts.loading,
          fit: BoxFit.cover,
          width: Get.width,
          height: Get.height * .04,
        ),
        SizedBox(height: 8),
        Image.asset(
          AssetsConsts.loading,
          fit: BoxFit.cover,
          width: Get.width,
          height: Get.height * .04,
        ),
        SizedBox(height: 8),
        Image.asset(
          AssetsConsts.loading,
          fit: BoxFit.cover,
          width: Get.width,
          height: Get.height * .04,
        ),
        SizedBox(height: Get.height * .2),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClipRRect(
                borderRadius: AppTheme.borderRadius,
                child: Image.asset(
                  AssetsConsts.loading,
                  fit: BoxFit.cover,
                  width: Get.width * .3,
                  height: 40,
                ),
              ),
              ClipRRect(
                borderRadius: AppTheme.borderRadius,
                child: Image.asset(
                  AssetsConsts.loading,
                  fit: BoxFit.cover,
                  width: Get.width * .3,
                  height: 40,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
