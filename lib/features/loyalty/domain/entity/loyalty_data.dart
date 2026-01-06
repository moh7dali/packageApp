import 'package:equatable/equatable.dart';

class LoyaltyData extends Equatable {
  final int? currentTier;
  final double? tierAmount;
  final DateTime? tierExpiryDate;
  final int? pointsBalance;
  final int? addedPoints;
  final int? redeemedPoints;
  final int? expiredPoints;
  final int? numberOfVisits;
  final dynamic numberOfOrders;
  final dynamic cashBalance;
  final double? walletBalance;

  const LoyaltyData({
    required this.currentTier,
    required this.tierAmount,
    required this.tierExpiryDate,
    required this.pointsBalance,
    required this.addedPoints,
    required this.redeemedPoints,
    required this.expiredPoints,
    required this.numberOfOrders,
    required this.numberOfVisits,
    required this.walletBalance,
    required this.cashBalance,
  });

  @override
  List<Object?> get props => [
    currentTier,
    tierAmount,
    tierExpiryDate,
    pointsBalance,
    addedPoints,
    redeemedPoints,
    expiredPoints,
    numberOfVisits,
    cashBalance,
  ];
}
