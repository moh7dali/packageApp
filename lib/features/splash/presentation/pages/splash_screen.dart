import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mozaic_loyalty_sdk/features/splash/presentation/getx/splash_controller.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/hero_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          Expanded(
            child: GetBuilder<SDKSplashController>(
              init: SDKSplashController(),
              builder: (controller) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(top: Get.height * .35, left: 0, right: 0, child: HeroLogo()),
                    AnimatedPositioned(
                      bottom: Get.height * .1,
                      left: 0,
                      right: 0,
                      duration: const Duration(milliseconds: 300),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [LoadingAnimationWidget.newtonCradle(color: AppTheme.primaryColor, size: Get.height * .25)],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Text(
                        ApiEndPoints.apiLink.contains("staging") ? "staging" : "",
                        style: AppTheme.textStyle(size: AppTheme.size14, color: AppTheme.primaryColor),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
