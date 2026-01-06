import '../../domain/entity/user_rewards.dart';

class UserRewardsModel extends UserRewards {
  UserRewardsModel({
    required super.id,
    required super.title,
    required super.description,
    required super.status,
    required super.imageUrl,
    required super.expiryDate,
    required super.creationDate,
    required super.rewardTypeId,
  });

  factory UserRewardsModel.fromJson(Map<String, dynamic> json) => UserRewardsModel(
        id: json['Id'],
        title: json['Title'],
        description: json['Description'],
        status: json['Status'],
        imageUrl: json['ImageUrl'],
        expiryDate: json['ExpiryDate'],
        creationDate: json['CreationDate'],
        rewardTypeId: json['RewardTypeId'],
      );
}
