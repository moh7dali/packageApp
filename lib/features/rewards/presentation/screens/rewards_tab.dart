import 'package:my_custom_widget/features/rewards/presentation/screens/my_rewards_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(gradient: AppTheme.gradient1),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor.withOpacity(0.10),
                    borderRadius: AppTheme.bigBorderRadius,
                    border: Border.all(color: AppTheme.whiteColor.withOpacity(0.16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.10),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: TabBar(
                    controller: controller.tabController,
                    dividerHeight: 0,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.all(4),
                    labelStyle: AppTheme.textStyle(color: AppTheme.whiteColor, isBold: true, size: AppTheme.size14),
                    unselectedLabelStyle: AppTheme.textStyle(color: AppTheme.whiteColor.withOpacity(.75), size: AppTheme.size14),
                    indicator: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.95),
                      borderRadius: AppTheme.borderRadius,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.25),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    tabs: controller.pageTabs.map((e) {
                      return Tab(
                        child: Center(
                          child: Text(e.tr, textAlign: TextAlign.center),
                        ),
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
        );
      },
    );
  }
}
