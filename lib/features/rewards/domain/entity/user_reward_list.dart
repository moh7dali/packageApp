import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/rewards/domain/entity/user_rewards.dart';

class UserRewardsList extends Equatable {
  final List<UserRewards>? userRewardsList;
  final int? totalNumberOfResult;

  const UserRewardsList({required this.userRewardsList, required this.totalNumberOfResult});

  @override
  List<Object?> get props => [userRewardsList, totalNumberOfResult];
}
