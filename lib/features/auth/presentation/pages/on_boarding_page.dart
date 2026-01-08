import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/features/auth/presentation/getx/onboarding_controller.dart';
import 'package:my_custom_widget/features/auth/presentation/widgets/curved_widget.dart';
import 'package:my_custom_widget/shared/widgets/button_widget.dart';

import '../../../../shared/model/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      init: OnboardingController(),
      builder: (controller) {
        return Scaffold(
          body: PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            itemCount: controller.pages.length,
            itemBuilder: (context, index) {
              final item = controller.pages[index];
              return _OnboardingCard(item: item);
            },
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 14),
                  Text("title".tr, style: AppTheme.textStyle(color: AppTheme.primaryColor)),
                  Obx(() {
                    final current = controller.currentPage.value;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(controller.pages.length, (i) {
                        final isActive = i == current;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: isActive ? 14 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: isActive ? AppTheme.primaryColor : AppTheme.textColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    );
                  }),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        final isLast = controller.currentPage.value == controller.pages.length - 1;
                        return Visibility(
                          visible: !isLast,
                          child: GestureDetector(
                            onTap: controller.skip,
                            child: Text('skip'.tr, style: AppTheme.textStyle(color: AppTheme.primaryColor)),
                          ),
                        );
                      }),

                      SizedBox(
                        width: Get.width * .35,
                        child: Obx(() {
                          final isLast = controller.currentPage.value == controller.pages.length - 1;
                          return AppButton(title: isLast ? 'start'.tr : 'next'.tr, function: controller.next);
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _OnboardingCard extends StatelessWidget {
  const _OnboardingCard({required this.item});

  final OnboardingItem item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double cardHeight = size.height * 0.3;

    return Stack(
      children: [
        Positioned.fill(child: Image.asset(item.image, fit: BoxFit.fill)),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ClipPath(
            clipper: CurvedBottomClipper(),
            child: Container(
              height: cardHeight,
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 90, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size18, isBold: true),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item.description,
                    textAlign: TextAlign.center,
                    style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.7), size: AppTheme.size16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
