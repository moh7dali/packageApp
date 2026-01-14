import 'package:mozaic_loyalty_sdk/features/rewards/data/models/user_rewards_model.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/user_reward_list.dart';

import '../../domain/entity/user_rewards.dart';

class UserRewardsListModel extends UserRewardsList {
  const UserRewardsListModel({required super.userRewardsList, required super.totalNumberOfResult});

  factory UserRewardsListModel.fromJson(Map<String, dynamic> json) => UserRewardsListModel(
        userRewardsList: json["CustomerRewardList"] == null
            ? []
            : List<UserRewards>.from(
                json["CustomerRewardList"]!.map((x) => UserRewardsModel.fromJson(x)),
              ),
        totalNumberOfResult: json['TotalNumberofResult'],
      );

  Map<String, dynamic> toMap() => {
        "CustomerRewardList": userRewardsList,
        "TotalNumberofResult": totalNumberOfResult,
      };
}
