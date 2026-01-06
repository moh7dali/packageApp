import 'package:my_custom_widget/features/rewards/data/models/campaign_rules_rewards_model.dart';
import 'package:my_custom_widget/features/rewards/data/models/user_rewards_model.dart';
import 'package:my_custom_widget/features/rewards/domain/entity/campaign_rewards.dart';
import 'package:my_custom_widget/features/rewards/domain/entity/user_rewards.dart';

import '../../domain/entity/campaign_rules_rewards.dart';

class CampaignRewardsModel extends CampaignRewards {
  const CampaignRewardsModel({required super.hasRules, required super.campaignRewards, required super.campaignRulesRewards});

  factory CampaignRewardsModel.fromJson(Map<String, dynamic> json) => CampaignRewardsModel(
        hasRules: json["HasRules"],
        campaignRewards: json["CampaignRewards"] == null
            ? []
            : List<UserRewards>.from(
                json["CampaignRewards"]!.map((x) => UserRewardsModel.fromJson(x)),
              ),
        campaignRulesRewards: json["CampaignRulesRewards"] == null
            ? []
            : List<CampaignRulesRewards>.from(
                json["CampaignRulesRewards"]!.map((x) => CampaignRulesRewardsModel.fromJson(x)),
              ),
      );
}
