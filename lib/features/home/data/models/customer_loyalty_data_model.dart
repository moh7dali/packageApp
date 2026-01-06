import '../../domain/entities/customer_loyalty_data.dart';
import 'customer_tier_data_model.dart';

class CustomerLoyaltyDataModel extends CustomerLoyaltyData {
  const CustomerLoyaltyDataModel({
    required super.addedPoints,
    required super.cashBalance,
    required super.customerTierData,
    required super.expiredPoints,
    required super.pointsBalance,
    required super.redeemedPoints,
    required super.wallet,
  });

  factory CustomerLoyaltyDataModel.fromMap(Map<String, dynamic> json) => CustomerLoyaltyDataModel(
    pointsBalance: json["PointsBalance"],
    addedPoints: json["AddedPoints"],
    redeemedPoints: json["RedeemedPoints"],
    expiredPoints: json["ExpiredPoints"],
    cashBalance: json["CashBalance"]?.toDouble(),
    wallet: json["Wallet"]?.toDouble(),
    customerTierData: json["CustomerTierData"] == null ? null : CustomerTierDataModel.fromMap(json["CustomerTierData"]),
  );

  Map<String, dynamic> toMap() => {
    "PointsBalance": pointsBalance,
    "AddedPoints": addedPoints,
    "RedeemedPoints": redeemedPoints,
    "ExpiredPoints": expiredPoints,
    "CashBalance": cashBalance,
    "Wallet": wallet,
    "CustomerTierData": customerTierData,
  };
}
