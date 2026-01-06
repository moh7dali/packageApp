import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/rewards/domain/entity/campaign_rules_rewards.dart';
import 'package:my_custom_widget/features/rewards/domain/entity/user_rewards.dart';

class CampaignRewards extends Equatable {
  final bool? hasRules;
  final List<UserRewards>? campaignRewards;
  final List<CampaignRulesRewards>? campaignRulesRewards;

  const CampaignRewards({this.campaignRewards, this.campaignRulesRewards, this.hasRules});

  @override
  List<Object?> get props => [hasRules, campaignRewards, campaignRulesRewards];
}
