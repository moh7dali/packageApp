import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/theme.dart';
import '../getx/rewards_controller.dart';
import 'occasion_rewards_page.dart';

class MoreRewardsPage extends StatelessWidget {
  const MoreRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardsController>(
        init: RewardsController(),
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TabBar(
                  dividerHeight: 0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(4),
                  indicatorColor: AppTheme.primaryColor,
                  labelStyle: AppTheme.textStyle(color: AppTheme.primaryColor, isBold: true, size: AppTheme.size16),
                  unselectedLabelStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
                  controller: controller.moreRewardsTabController,
                  indicator: BoxDecoration(color: AppTheme.primaryColor, borderRadius: AppTheme.borderRadius),
                  tabs: controller.moreRewardsTabs.map((e) {
                    return Tab(
                      child: GestureDetector(
                        child: Text(
                          e.tr,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                  child: TabBarView(
                controller: controller.moreRewardsTabController,
                children: const [
                  OccasionRewards(categoriesId: "2"),
                  OccasionRewards(categoriesId: "1,3,4"),
                ],
              ))
            ],
          );
        });
  }
}
