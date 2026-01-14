import 'package:equatable/equatable.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/user_rewards.dart';

class CampaignRulesRewards extends Equatable {
  final String? ruleName;
  final List<UserRewards>? ruleRewards;

  const CampaignRulesRewards({this.ruleRewards, this.ruleName});

  @override
  List<Object?> get props => [ruleName, ruleRewards];
}
