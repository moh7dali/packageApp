import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/assets_constants.dart';

import '../../../../core/utils/theme.dart';


class ProductDetailsLoading extends StatelessWidget {
  const ProductDetailsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: AppTheme.borderRadius,
                ),
                child: ClipRRect(
                  borderRadius: AppTheme.borderRadius,
                  child: Image.asset(
                    AssetsConsts.loading,
                    fit: BoxFit.cover,
                    width: Get.width * .6,
                    height: Get.width * .6,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
                  child: ClipRRect(
                    borderRadius: AppTheme.borderRadius,
                    child: Image.asset(
                      AssetsConsts.loading,
                      fit: BoxFit.cover,
                      height: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: ClipRRect(
                    borderRadius: AppTheme.borderRadius,
                    child: Image.asset(
                      AssetsConsts.loading,
                      fit: BoxFit.cover,
                      height: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: ClipRRect(
                    borderRadius: AppTheme.borderRadius,
                    child: Image.asset(
                      AssetsConsts.loading,
                      fit: BoxFit.cover,
                      width: Get.width*.25,
                      height: 40,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: ClipRRect(
                    borderRadius: AppTheme.borderRadius,
                    child: Image.asset(
                      AssetsConsts.loading,
                      fit: BoxFit.cover,
                      width: Get.width*.25,
                      height: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0,vertical: 10),
                  child: ClipRRect(
                    borderRadius: AppTheme.borderRadius,
                    child: Image.asset(
                      AssetsConsts.loading,
                      fit: BoxFit.cover,
                      height: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(
                        AssetsConsts.loading,
                        fit: BoxFit.cover,
                        width: Get.width*.36,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(
                        AssetsConsts.loading,
                        fit: BoxFit.cover,
                        width: Get.width*.09,
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(
                        AssetsConsts.loading,
                        fit: BoxFit.cover,
                        width: Get.width*.36,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(
                        AssetsConsts.loading,
                        fit: BoxFit.cover,
                        width: Get.width*.09,
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(
                        AssetsConsts.loading,
                        fit: BoxFit.cover,
                        width: Get.width*.36,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(
                        AssetsConsts.loading,
                        fit: BoxFit.cover,
                        width: Get.width*.09,
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(
                        AssetsConsts.loading,
                        fit: BoxFit.cover,
                        width: Get.width*.36,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(
                        AssetsConsts.loading,
                        fit: BoxFit.cover,
                        width: Get.width*.09,
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(
                        AssetsConsts.loading,
                        fit: BoxFit.cover,
                        width: Get.width*.36,
                        height: 40,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: ClipRRect(
                      borderRadius: AppTheme.borderRadius,
                      child: Image.asset(
                        AssetsConsts.loading,
                        fit: BoxFit.cover,
                        width: Get.width*.09,
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
