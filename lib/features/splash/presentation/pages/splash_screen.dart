import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/splash/presentation/getx/splash_controller.dart';
import 'package:my_custom_widget/features/splash/presentation/widgets/popup_widget.dart';
import 'package:my_custom_widget/shared/widgets/app_background.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/hero_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Expanded(
              child: GetBuilder<SplashController>(
                init: SplashController(),
                builder: (controller) {
                  if (controller.advertisingDone) {
                    return PopupWidget(advertising: controller.advertisingList?.advertisingList ?? [], controller: controller);
                  }
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedPositioned(
                        top: controller.isLoading ? Get.height * .05 : Get.height * .35,
                        left: 0,
                        right: 0,
                        duration: const Duration(milliseconds: 2000),
                        child: HeroLogo(smallLogo: true),
                      ),
                      AnimatedPositioned(
                        bottom: controller.isLoadingCircle ? Get.height * .3 : 0,
                        left: 0,
                        right: 0,
                        duration: const Duration(milliseconds: 300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedOpacity(
                              opacity: controller.isLoadingCircle ? 1 : 0,
                              duration: const Duration(milliseconds: 300),
                              child:  CircularProgressIndicator(color: AppTheme.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: FutureBuilder<PackageInfo>(
                          future: PackageInfo.fromPlatform(),
                          builder: (context, snapshot) => Text(
                            'V.${snapshot.data?.version ?? ""} ${ApiEndPoints.apiLink.contains("staging") ? "staging" : ""}',
                            style: AppTheme.textStyle(size: AppTheme.size14, color: AppTheme.primaryColor),
                          ),
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
      ),
    );
  }
}
