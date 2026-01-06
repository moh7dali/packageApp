import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/rewards/domain/entity/user_rewards.dart';

class CampaignRulesRewards extends Equatable {
  final String? ruleName;
  final List<UserRewards>? ruleRewards;

  const CampaignRulesRewards({this.ruleRewards, this.ruleName});

  @override
  List<Object?> get props => [ruleName, ruleRewards];
}
