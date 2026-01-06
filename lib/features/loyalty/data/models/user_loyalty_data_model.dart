import 'package:my_custom_widget/features/loyalty/data/models/loyalty_data_model.dart';
import 'package:my_custom_widget/features/loyalty/domain/entity/user_loyalty_data.dart';

import '../../../home/data/models/tier_model.dart';
import '../../../home/domain/entities/tier.dart';

class UserLoyaltyDataModel extends UserLoyaltyData {
  const UserLoyaltyDataModel({required super.loyaltyData, required super.tiers});

  factory UserLoyaltyDataModel.fromJson(Map<String, dynamic> json) => UserLoyaltyDataModel(
      tiers: json["Tiers"] == null ? [] : List<TiersData>.from(json["Tiers"]!.map((x) => TierModel.fromMap(x))),
      loyaltyData: LoyaltyDataModel.fromJson(json['LoyaltyData']));
}
