import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/features/home/presentation/getx/home_controller.dart';
import 'package:my_custom_widget/features/home/presentation/widget/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../main/presentation/widgets/hero_app_bar.dart';
import '../../../order_method/presentation/pages/selected_order_method.dart';
import '../../../rewards/presentation/screens/campign_rewards_screen.dart';
import '../../domain/entities/slider.dart';
import '../widget/curved.dart';
import '../widget/loyalty_card_loading.dart';
import '../widget/loyalty_card_widget.dart';
import '../widget/missioons_widget.dart';
import '../widget/pages_card_loading.dart';
import '../widget/pick_up_branch_widget.dart';
import '../widget/refere_widget.dart';
import '../widget/rewards_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppTheme.bgColor,
        appBar: heroAppBar(controller: controller),
        body: RefreshIndicator(
          color: AppTheme.primaryColor,
          onRefresh: () async {
            if (controller.isHomeLoading == false) {
              await Future.delayed(Duration(milliseconds: 500));
              controller.init();
            }
          },
          child: SingleChildScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: controller.isHomeLoading
                ? Column(
                    children: [
                      LoyaltyCardLoading(),
                      SizedBox(height: Get.height * .02),
                      SliderAdsWidget(slides: const [SliderItem(), SliderItem(), SliderItem()], isLoading: controller.isHomeLoading),
                      SizedBox(height: Get.height * .02),
                      PagesCardsLoading(),
                    ],
                  )
                : Column(
                    children: [
                      LoyaltyCardWidget(homeController: controller),
                      if (controller.isLogin)
                        PickupBranchCard(
                          selectedBranch: controller.selectedBranch,
                          onChangeTap: () {
                            SharedHelper().scaleDialog(
                              SelectedOrderMethod(
                                onFinish: () async {
                                  controller.setSelectedBranch();
                                },
                              ),
                            );
                          },
                        ),
                      CurvedCategoryScroller(
                        items: controller.homeDetails?.categoryList?.category ?? [],
                        onTap: (category) {
                          if (!controller.isLogin) {
                            controller.gotoSubOrProduct(category);
                            return;
                          }
                          if (controller.selectedBranch != null) {
                            controller.gotoSubOrProduct(category);
                            return;
                          }
                          SharedHelper().scaleDialog(
                            SelectedOrderMethod(
                              onFinish: () async {
                                controller.setSelectedBranch();
                                controller.gotoSubOrProduct(category);
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: Get.height * .01),
                      SliderAdsWidget(
                        slides: (controller.homeDetails?.sliders?.sliders ?? []).firstOrNull?.sliderItems ?? [],
                        isLoading: controller.isHomeLoading,
                      ),
                      SizedBox(height: Get.height * .01),
                      if (controller.isShowReferral && controller.referralCampaign != null)
                        SuperPremiumReferAndEarnButton(
                          onTap: () {
                            SharedHelper().needLogin(() => Get.toNamed(RouteConstant.invitePage));
                          },
                        ),
                      SizedBox(height: Get.height * .01),
                      if ((controller.missions).isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Deals".tr,
                                      textAlign: TextAlign.center,
                                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size20, isBold: true),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.gotoRewards(isDeals: true);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryColor.withOpacity(0.06),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          "seeMore".tr,
                                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12, isBold: true),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: Get.height * .22,
                                      child: ListView.builder(
                                        itemCount: controller.missions.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return MissionsWidget(
                                            campaignDetails: controller.missions[index],
                                            onTab: () {
                                              Get.to(CampaignRewardsScreen(selectedCampaignDetails: controller.missions[index]));
                                            },
                                            isHome: true,
                                            isPrimary: index % 2 != 0,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      if ((controller.userRewardsList).isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "myRewards".tr,
                                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size20, isBold: true),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.gotoRewards();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryColor.withOpacity(0.06),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          "seeMore".tr,
                                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12, isBold: true),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: Get.height * .25,
                                      child: ListView.builder(
                                        itemCount: controller.userRewardsList.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final reward = controller.userRewardsList[index];
                                          return HomeRewardCard(
                                            reward: reward,
                                            onTap: () {
                                              SharedHelper().actionDialog(
                                                "${reward.title}",
                                                "${reward.description}",
                                                hasImage: true,
                                                image: "${reward.imageUrl}",
                                                confirmText: "close".tr,
                                                noCancel: true,
                                                confirm: () {
                                                  Get.back();
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: Get.height * .04),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
