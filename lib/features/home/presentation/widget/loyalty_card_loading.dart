import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../core/utils/theme.dart';

class LoyaltyCardLoading extends StatelessWidget {
  const LoyaltyCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppTheme.gradient1),
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [LoadingAnimationWidget.beat(color: AppTheme.accentColor, size: Get.height * .12)],
        ),
      ),
    );
  }
}
