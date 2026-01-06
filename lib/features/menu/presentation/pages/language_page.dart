import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../my_custom_widget.dart';
import '../../../../shared/getx/language_controller.dart';
import '../../../../shared/widgets/loading_widget.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    LanguageController controller;
    if (Get.isRegistered<LanguageController>()) {
      controller = Get.find<LanguageController>();
    } else {
      controller = Get.put<LanguageController>(LanguageController());
    }
    return GetBuilder<LanguageController>(
      builder: (c) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                if ((controller.appLang == "en")) {
                  await SharedHelper().closeAllDialogs();
                  SharedHelper().scaleDialog(const LoadingWidget(), dismissible: false);
                  Future.delayed(const Duration(milliseconds: 500), () {
                    controller.changeLanguage('ar', RouteConstant.mainPage);
                  });
                }
              },
              child: Card(
                // width: Get.width,
                // decoration: BoxDecoration(
                color: appLanguage == 'ar' ? AppTheme.primaryColor : AppTheme.accentColor,
                //   boxShadow: [BoxShadow(color: AppTheme.blackColor.withOpacity(.7), blurRadius: 10, blurStyle: BlurStyle.outer)],
                //   borderRadius: AppTheme.borderRadius,
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      if (appLanguage == "ar") Icon(Icons.check, color: AppTheme.accentColor),
                      Expanded(
                        child: Text(
                          'العربية',
                          style: AppTheme.textStyle(
                            color: controller.appLang == "ar" ? AppTheme.accentColor : AppTheme.textColor,
                            size: AppTheme.size18,
                            isBold: true,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * .02),
            GestureDetector(
              onTap: () async {
                if ((controller.appLang == "ar")) {
                  await SharedHelper().closeAllDialogs();
                  SharedHelper().scaleDialog(const LoadingWidget(), dismissible: false);
                  Future.delayed(const Duration(milliseconds: 500), () {
                    controller.changeLanguage('en', RouteConstant.mainPage);
                  });
                }
              },
              child: Card(
                // width: Get.width,
                // decoration: BoxDecoration(
                color: appLanguage == 'en' ? AppTheme.primaryColor : AppTheme.accentColor,
                //   boxShadow: [BoxShadow(color: AppTheme.blackColor.withOpacity(.7), blurRadius: 10, blurStyle: BlurStyle.outer)],
                //   borderRadius: AppTheme.borderRadius,
                // ),
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      if (appLanguage == "en") Icon(Icons.check, color: AppTheme.accentColor),
                      Expanded(
                        child: Text(
                          'English',
                          style: AppTheme.textStyle(
                            color: controller.appLang == "en" ? AppTheme.accentColor : AppTheme.textColor,
                            size: AppTheme.size18,
                            isBold: true,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
