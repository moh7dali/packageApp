import 'package:equatable/equatable.dart';

import 'customer_tier_data.dart';

class CustomerLoyaltyData extends Equatable {
  final int? pointsBalance;
  final int? addedPoints;
  final int? redeemedPoints;
  final int? expiredPoints;
  final double? cashBalance;
  final double? wallet;
  final CustomerTierData? customerTierData;

  const CustomerLoyaltyData({
    this.pointsBalance,
    this.addedPoints,
    this.redeemedPoints,
    this.expiredPoints,
    this.cashBalance,
    this.customerTierData,
    this.wallet,
  });

  @override
  List<Object?> get props => [pointsBalance, addedPoints, redeemedPoints, expiredPoints, cashBalance, customerTierData, wallet];
}
