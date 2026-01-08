import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/assets_constants.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../shared/model/onboarding_model.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  final pages = <OnboardingItem>[
    OnboardingItem(image: AssetsConsts.onBoarding1, title: 'OnBoardingTitle1'.tr, description: 'OnBoardingDescription1'.tr),
    OnboardingItem(image: AssetsConsts.onBoarding2, title: 'OnBoardingTitle2'.tr, description: 'OnBoardingDescription2'.tr),
    OnboardingItem(image: AssetsConsts.onBoarding3, title: 'OnBoardingTitle3'.tr, description: 'OnBoardingDescription3'.tr),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void next() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      _goToHome();
    }
  }

  void skip() {
    _goToHome();
  }

  void _goToHome() {
    SDKNav.offAllNamed(RouteConstant.authPage);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
