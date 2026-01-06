import '../../domain/entities/customer_tier_data.dart';

class CustomerTierDataModel extends CustomerTierData {
  const CustomerTierDataModel({
    required super.currentTier,
    required super.tierAmount,
    required super.tierExpiryDate,
  });

  factory CustomerTierDataModel.fromMap(Map<String, dynamic> json) => CustomerTierDataModel(
        currentTier: json["CurrentTier"],
        tierAmount: json["TierAmount"]?.toDouble(),
        tierExpiryDate: json["TierExpiryDate"] == null ? null : DateTime.parse(json["TierExpiryDate"]),
      );

  Map<String, dynamic> toMap() => {
        "CurrentTier": currentTier,
        "TierAmount": tierAmount,
        "TierExpiryDate": tierExpiryDate?.toIso8601String(),
      };
}
