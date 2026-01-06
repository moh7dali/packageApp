import 'package:my_custom_widget/features/rewards/presentation/getx/campaign_rewards_controller.dart';
import 'package:my_custom_widget/features/rewards/presentation/widgets/reward_widget.dart';
import 'package:my_custom_widget/features/rewards/presentation/widgets/rewards_card_widget.dart';
import 'package:my_custom_widget/features/rewards/presentation/widgets/rule_rewards_widget.dart';
import 'package:my_custom_widget/shared/widgets/no_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/theme.dart';
import '../../domain/entity/campaign_details.dart';
import '../widgets/user_rewards_loading_widget.dart';

class CampaignRewardsScreen extends StatelessWidget {
  const CampaignRewardsScreen({super.key, required this.selectedCampaignDetails});

  final CampaignDetails selectedCampaignDetails;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignRewardsController>(
      init: CampaignRewardsController(selectedCampaignDetails: selectedCampaignDetails),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text(selectedCampaignDetails.name ?? "")),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: OccasionCampaignCard(campaignDetails: selectedCampaignDetails, onTap: () {}),
              ),
            ],
            body: controller.isLoading
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const UserRewardsLoadingWidget(hasImg: false);
                    },
                  )
                : (controller.campaignRewards?.hasRules ?? false) == false
                ? (controller.campaignRewards?.campaignRewards?.isEmpty ?? true)
                      ? Center(
                          child: Column(
                            children: [
                              NoItemWidget(),
                              Text(
                                'emptyRewards'.tr,
                                style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.campaignRewards?.campaignRewards?.length ?? 0,
                          itemBuilder: (context, index) {
                            return RewardCardWidget(reward: controller.campaignRewards?.campaignRewards?[index]);
                          },
                        )
                : (controller.campaignRewards?.campaignRulesRewards?.isEmpty ?? true)
                ? Center(
                    child: Column(
                      children: [
                        NoItemWidget(),
                        Text(
                          'emptyRewards'.tr,
                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size14),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : RuleRewardsWidget(campaignRulesRewards: controller.campaignRewards?.campaignRulesRewards),
          ),
        );
      },
    );
  }
}
