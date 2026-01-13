import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/features/home/presentation/getx/home_controller.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_routes.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/button_widget.dart';
import '../widget/hero_app_bar.dart';
import '../widget/loyalty_card_loading.dart';
import '../widget/loyalty_card_widget.dart';
import '../widget/missioons_widget.dart';
import '../widget/pages_card_loading.dart';
import '../widget/rewards_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        appBar: heroAppBar(),
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
                      PagesCardsLoading(),
                    ],
                  )
                : Column(
                    children: [
                      LoyaltyCardWidget(homeController: controller),
                      LAdoreNavButtons(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: AppButton(
                          title: "redeemPoints".tr,
                          isDoneBtn: false,
                          isSmall: true,
                          function: () {
                            controller.redeemPoints();
                          },
                        ),
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
                                              SDKNav.toNamed(RouteConstant.campaignRewards, arguments: controller.missions[index]);
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
                                                  SDKNav.back();
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

class LAdoreNavButtons extends StatelessWidget {
  const LAdoreNavButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.4), width: 1.2),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    SDKNav.toNamed(RouteConstant.pointsScreen);
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Points".tr,
                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.stars_outlined, color: AppTheme.primaryColor, size: AppTheme.size20),
                      ],
                    ),
                  ),
                ),
              ),
              Container(width: 1, height: 25, color: AppTheme.primaryColor.withOpacity(0.3)),
              Expanded(
                child: InkWell(
                  onTap: () {
                    SDKNav.toNamed(RouteConstant.rewardsScreen);
                  },
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.card_giftcard, color: AppTheme.primaryColor, size: AppTheme.size20),
                        SizedBox(width: 8),
                        Text(
                          "Rewards".tr,
                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
