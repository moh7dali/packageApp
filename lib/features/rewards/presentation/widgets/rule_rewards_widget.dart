import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/core/utils/translate/translation.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/presentation/widgets/rewards_card_widget.dart';
import 'package:mozaic_loyalty_sdk/shared/widgets/no_item_widget.dart';

import '../../../../core/utils/theme.dart';
import '../../domain/entity/campaign_rules_rewards.dart';
import '../getx/widget_controller.dart';

class RuleRewardsWidget extends StatelessWidget {
  const RuleRewardsWidget({super.key, this.campaignRulesRewards});

  final List<CampaignRulesRewards>? campaignRulesRewards;

  @override
  Widget build(BuildContext context) {
    final rules = (campaignRulesRewards ?? []);
    return GetBuilder<SDKWidgetController>(
      init: SDKWidgetController(length: rules.length),
      builder: (controller) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.gradient1,
                  borderRadius: AppTheme.bigBorderRadius,
                  border: Border.all(color: AppTheme.whiteColor.withOpacity(0.16)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 16, offset: const Offset(0, 8))],
                ),
                // padding: const EdgeInsets.all(8),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.whiteColor.withOpacity(0.10),
                    borderRadius: AppTheme.bigBorderRadius,
                    border: Border.all(color: AppTheme.whiteColor.withOpacity(0.16)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 16, offset: const Offset(0, 8))],
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
                      boxShadow: [BoxShadow(color: AppTheme.primaryColor.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 5))],
                    ),
                    tabs: rules.map((e) {
                      return Tab(
                        child: Center(
                          child: Text((e.ruleName ?? "").sdkTr, textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: rules.map((rule) {
                  final list = rule.ruleRewards ?? [];
                  if (list.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          NoItemWidget(),
                          Text(
                            'emptyRewards'.sdkTr,
                            style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14, isBold: true),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 14),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return RewardCardWidget(reward: list[index]);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
