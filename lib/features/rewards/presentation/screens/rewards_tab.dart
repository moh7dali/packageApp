import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/presentation/screens/my_rewards_page.dart';

import '../../../../core/utils/theme.dart';
import '../getx/rewards_controller.dart';
import 'occasion_rewards_page.dart';

class RewardsTabScreen extends StatelessWidget {
  const RewardsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardsController>(
      init: RewardsController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text("Rewards".tr)),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: AppTheme.bigBorderRadius,
                      border: Border.all(color: AppTheme.primaryColor.withOpacity(0.25), width: 1),
                      boxShadow: [BoxShadow(color: AppTheme.textColor.withOpacity(0.10), blurRadius: 18, offset: const Offset(0, 10))],
                    ),
                    child: TabBar(
                      controller: controller.tabController,
                      dividerHeight: 0,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: const EdgeInsets.all(4),
                      labelStyle: AppTheme.textStyle(color: AppTheme.whiteColor, isBold: true, size: AppTheme.size14),
                      unselectedLabelStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                      indicator: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.95),
                        borderRadius: AppTheme.borderRadius,
                        boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 5))],
                      ),
                      tabs: controller.pageTabs.map((e) {
                        return Tab(
                          child: Center(child: Text(e.tr, textAlign: TextAlign.center)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children: const [
                      MyRewardsPage(),
                      OccasionRewards(categoriesId: "1,2,3,4"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
