import 'package:equatable/equatable.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/user_rewards.dart';

class UserRewardsList extends Equatable {
  final List<UserRewards>? userRewardsList;
  final int? totalNumberOfResult;

  const UserRewardsList({required this.userRewardsList, required this.totalNumberOfResult});

  @override
  List<Object?> get props => [userRewardsList, totalNumberOfResult];
}
