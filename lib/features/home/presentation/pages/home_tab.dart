import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/core/utils/theme.dart';
import 'package:mozaic_loyalty_sdk/features/home/presentation/getx/home_controller.dart';

import '../../../../core/constants/assets_constants.dart';
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
                      LAdoreDualCards(),
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

class LAdoreDualCards extends StatelessWidget {
  const LAdoreDualCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: _buildNavCard(title: "Points".tr, icon: AssetsConsts.points, onTap: () => SDKNav.toNamed(RouteConstant.pointsScreen)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: _buildNavCard(title: "Rewards".tr, icon: AssetsConsts.rewards, onTap: () => SDKNav.toNamed(RouteConstant.rewardsScreen)),
          ),
        ],
      ),
    );
  }

  Widget _buildNavCard({required String title, required String icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppTheme.bigBorderRadius,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.bgThemeColor,
          borderRadius: AppTheme.bigBorderRadius,
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.8), width: 1),
          boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.1), shape: BoxShape.circle),
                child: SvgPicture.asset(icon, color: AppTheme.primaryColor),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
