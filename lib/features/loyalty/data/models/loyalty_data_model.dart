import '../../domain/entity/loyalty_data.dart';

class LoyaltyDataModel extends LoyaltyData {
  const LoyaltyDataModel({
    required super.currentTier,
    required super.tierAmount,
    required super.tierExpiryDate,
    required super.pointsBalance,
    required super.addedPoints,
    required super.redeemedPoints,
    required super.expiredPoints,
    required super.numberOfVisits,
    required super.numberOfOrders,
    required super.walletBalance,
    required super.cashBalance,
  });

  factory LoyaltyDataModel.fromJson(Map<String, dynamic> json) => LoyaltyDataModel(
    currentTier: json['CurrentTier'],
    tierAmount: json['TierAmount'].toDouble(),
    tierExpiryDate: json["TierExpiryDate"] == null ? null : DateTime.parse(json["TierExpiryDate"]),
    pointsBalance: json['PointsBalance'],
    addedPoints: json['AddedPoints'],
    redeemedPoints: json['RedeemedPoints'],
    expiredPoints: json['ExpiredPoints'],
    cashBalance: json['CashBalance'],
    numberOfVisits: json['NumberOfVisits'],
    numberOfOrders: json['NumberOfOrders'],
    walletBalance: (json['WalletBalance'] as num?)?.toDouble(),
  );
}
