import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/rate/presentation/widgets/rate_face_icon_widget.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/model/push_notification_model.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../../../../shared/widgets/profile_text_field.dart';
import '../../../../shared/widgets/shake_widget.dart';
import '../getx/rate_branch_visit_controller.dart';

class RateWidget extends StatelessWidget {
  const RateWidget({super.key, required this.notification});

  final PushNotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RateController>(
      init: RateController(notification: notification),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () => SharedHelper().closeAllDialogs(),
          child: Container(
            color: Colors.black.withOpacity(0.45),
            child: Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: Get.width * 0.90,
                  constraints: BoxConstraints(maxHeight: Get.height * 0.50),
                  decoration: BoxDecoration(
                    gradient: AppTheme.gradient1,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: AppTheme.whiteColor.withOpacity(0.18)),
                    boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.28), blurRadius: 30, offset: const Offset(0, 18))],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Stack(
                      children: [
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(color: Colors.white.withOpacity(0.06)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                notification.title ?? "",
                                textAlign: TextAlign.center,
                                style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size18, isBold: true),
                              ),
                              const SizedBox(height: 14),

                              Text(
                                notification.body ?? "",
                                textAlign: TextAlign.center,
                                style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14),
                              ),

                              const SizedBox(height: 14),
                              Text(
                                'rateYourExperienceWithUs'.tr,
                                style: AppTheme.textStyle(color: AppTheme.whiteColor, size: AppTheme.size14),
                              ),
                              const SizedBox(height: 6),

                              if (controller.isLoading)
                                SizedBox(
                                  height: Get.height * .2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Center(child: const CircularProgressIndicator(color: AppTheme.whiteColor))],
                                  ),
                                )
                              else
                                Column(
                                  children: [
                                    ShakeWidget(
                                      key: controller.rateShake,
                                      shakeOffset: 10,
                                      child: SizedBox(
                                        height: 50,
                                        child: Row(
                                          children: List.generate(
                                            5,
                                            (index) => Expanded(
                                              child: FaceIconWidget(imageName: controller.imageListName[index], index: index, controller: controller),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ProfileTextField(
                                      label: 'leaveAFeedback'.tr,
                                      maxLength: 25,
                                      type: TextInputType.text,
                                      controller: controller.rateController,
                                      isOptional: true,
                                      shakeKey: controller.rateTextShake,
                                    ),
                                  ],
                                ),

                              const SizedBox(height: 18),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppButton(
                                      title: "send".tr,
                                      function: () {
                                        if (controller.rateValue > 0 && !controller.isLoading) {
                                          controller.rateVisit();
                                        } else {
                                          controller.rateShake.currentState!.shake();
                                        }
                                      },
                                      state: controller.btnState,
                                      isSmall: true,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: AppButton(
                                      isDoneBtn: false,
                                      title: 'cancel'.tr,
                                      function: () => SharedHelper().closeAllDialogs(),
                                      isSmall: true,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
