import 'package:my_custom_widget/shared/widgets/card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/utils/theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.text = 'loading'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondaryColor.withOpacity(.75),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: CardAppWidget(
            child: SizedBox(
              width: Get.width * .5,
              height: Get.height * .25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.staggeredDotsWave(
                    color: AppTheme.primaryColor,
                    size: Get.width * .25,
                  ),
                  SizedBox(height: AppTheme.size12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(text.tr, style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size18, isBold: true)),
                      SizedBox(width: 10),
                      LoadingAnimationWidget.progressiveDots(
                        color: AppTheme.primaryColor,
                        size: Get.width * .07,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomLoadingWidget extends StatelessWidget {
  const BottomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .33,
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.scale(scale: 5, child: CupertinoActivityIndicator(color: AppTheme.primaryColor)),
          SizedBox(
            height: Get.height * .1,
          ),
          Text(
            'pleaseWait'.tr,
            style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size18),
          )
        ],
      ),
    );
  }
}
