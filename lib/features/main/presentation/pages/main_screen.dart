import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/features/main/presentation/getx/main_controller.dart';
import 'package:my_custom_widget/features/main/presentation/widgets/hero_app_bar.dart';
import 'package:my_custom_widget/shared/widgets/bottom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../shared/helper/shared_helper.dart';
import '../widgets/bottom_nav_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, this.pageIndex});

  final Map<String, int>? pageIndex;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(pageIndex),
      builder: (controller) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (controller.currentIndex != 0) {
              controller.onTapChanged(0);
            } else {
              SharedHelper().bottomSheet(
                BottomWidget(
                  title: "exitApp".tr,
                  description: "confirmExitApp".tr,
                  onCancel: () {
                    Get.back();
                  },
                  onConfirm: () {
                    SystemNavigator.pop();
                  },
                ),
              );
            }
          },
          child: Scaffold(
            appBar: controller.currentIndex != 0 ? heroAppBar(bg: AppTheme.primaryColor) : null,
            bottomNavigationBar: const AppBottomNavigationBar(),
            body: Column(children: [Expanded(child: controller.currentWidget)]),
            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            // floatingActionButton: SizedBox(
            //   height: Get.height * .08,
            //   width: Get.width * .16,
            //   child: FloatingActionButton(
            //     shape: const CircleBorder(),
            //     backgroundColor: AppTheme.accentColor,
            //     onPressed: () {
            //       SharedHelper().needLogin(() {
            //         controller.getUserLocation();
            //       });
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.all(12.0),
            //       child: SvgPicture.asset(AssetsConsts.checkIn, color: AppTheme.primaryColor),
            //     ),
            //   ),
            // ),
            // drawer: MenuTab(),
          ),
        );
      },
    );
  }
}
