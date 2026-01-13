import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/utils/theme.dart';

class LoyaltyCardLoading extends StatelessWidget {
  const LoyaltyCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: AppTheme.bigBorderRadius,
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.25), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LoadingAnimationWidget.beat(color: AppTheme.primaryColor, size: Get.height * .12)],
          ),
        ),
      ),
    );
  }
}
