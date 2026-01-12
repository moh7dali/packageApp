import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/loyalty/presentation/widgets/loyalty_card_loading_widget.dart';
import 'package:my_custom_widget/features/loyalty/presentation/widgets/new_loyalty_card_widget.dart';

import '../../../../core/utils/theme.dart';
import '../getx/points_controller.dart';
import '../widgets/point_history_list.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: GetBuilder<UserBalanceHistoryController>(
        init: UserBalanceHistoryController(context: context),
        builder: (controller) {
          return NestedScrollView(
            controller: controller.scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      controller.isLoadingLoyalty ? const LoyaltyCardLoading() : NewLoyaltyCardWidget(controller: controller),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppTheme.gradient1,
                            borderRadius: AppTheme.bigBorderRadius,
                            border: Border.all(color: AppTheme.whiteColor.withOpacity(0.16)),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 16, offset: const Offset(0, 8))],
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppTheme.whiteColor.withOpacity(0.10),
                              borderRadius: AppTheme.bigBorderRadius,
                              border: Border.all(color: AppTheme.whiteColor.withOpacity(0.16)),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 16, offset: const Offset(0, 8))],
                            ),
                            child: TabBar(
                              dividerHeight: 0,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorPadding: const EdgeInsets.all(4),
                              labelStyle: AppTheme.textStyle(color: AppTheme.whiteColor, isBold: true, size: AppTheme.size14),
                              unselectedLabelStyle: AppTheme.textStyle(color: AppTheme.whiteColor.withOpacity(.75), size: AppTheme.size14),
                              indicator: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.95),
                                borderRadius: AppTheme.borderRadius,
                                boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 5))],
                              ),
                              tabs: [Tab(text: 'loyaltyTransactions'.tr)],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(children: [PointsHistoryTab(controller: controller)]),
          );
        },
      ),
    );
  }
}
