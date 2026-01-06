import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';

class NotificationCardLoading extends StatelessWidget {
  const NotificationCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppTheme.accentColor, width: 2),
          borderRadius: AppTheme.borderRadius,
          color:AppTheme.accentColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: Get.width * .06,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        image: DecorationImage(image: AssetImage(AssetsConsts.loading), fit: BoxFit.cover)),
                    child: Text(
                      "",
                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: Get.width * .5,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: AppTheme.borderRadius,
                          image: DecorationImage(image: AssetImage(AssetsConsts.loading), fit: BoxFit.cover)),
                      child: Text(
                        "",
                        style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: Get.width * .5,
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: AppTheme.borderRadius,
                          image: DecorationImage(image: AssetImage(AssetsConsts.loading), fit: BoxFit.cover)),
                      child: Text(
                        "",
                        style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: Get.width * .25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        image: DecorationImage(image: AssetImage(AssetsConsts.loading), fit: BoxFit.cover)),
                    child: Text(
                      "",
                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
