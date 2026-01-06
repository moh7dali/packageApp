import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:my_custom_widget/shared/widgets/bottom_widget.dart';

import '../../core/constants/assets_constants.dart';
import '../getx/language_controller.dart';
import 'loading_widget.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({super.key, required this.pageRoute});

  final String pageRoute;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguageController>(
      init: LanguageController(),
      builder: (controller) => GestureDetector(
        onTap: () {
          SharedHelper().bottomSheet(
            BottomWidget(
              title: 'changeLanguage'.tr,
              description: 'confirmChangeLanguage'.tr,
              onCancel: () {
                SharedHelper().closeAllDialogs();
              },
              onConfirm: () async {
                await SharedHelper().closeAllDialogs();
                SharedHelper().scaleDialog(const LoadingWidget(), dismissible: false);
                Future.delayed(const Duration(milliseconds: 500), () {
                  controller.changeLanguage(controller.appLang == 'ar' ? "en" : "ar", pageRoute);
                });
              },
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [SvgPicture.asset(AssetsConsts.translateIcon, width: 30, fit: BoxFit.cover)],
            ),
          ),
        ),
      ),
    );
  }
}
