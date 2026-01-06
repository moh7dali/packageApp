import 'package:my_custom_widget/features/rewards/data/models/user_rewards_model.dart';
import 'package:my_custom_widget/features/rewards/domain/entity/campaign_rules_rewards.dart';

import '../../domain/entity/user_rewards.dart';

class CampaignRulesRewardsModel extends CampaignRulesRewards {
  const CampaignRulesRewardsModel({required super.ruleName, required super.ruleRewards});

  factory CampaignRulesRewardsModel.fromJson(Map<String, dynamic> json) => CampaignRulesRewardsModel(
      ruleRewards: json["RuleRewards"] == null
          ? []
          : List<UserRewards>.from(
              json["RuleRewards"]!.map((x) => UserRewardsModel.fromJson(x)),
            ),
      ruleName: json["RuleName"]);

  Map<String, dynamic> toMap() => {
        "RuleName": ruleName,
        "RuleRewards": ruleRewards,
      };
}
