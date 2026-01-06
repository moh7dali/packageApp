import 'package:equatable/equatable.dart';

class UserBarcode extends Equatable {
  final int? id;
  final String? fullName;
  final double? cashBalance;
  final double? walletBalance;
  final String? mobileNumber;
  final int? loyaltyProviderId;
  final String? loyaltyProviderName;
  final String? loyaltyCode;
  final String? redeemCode;

  const UserBarcode({
    this.id,
    this.fullName,
    this.cashBalance,
    this.walletBalance,
    this.mobileNumber,
    this.loyaltyProviderId,
    this.loyaltyProviderName,
    this.loyaltyCode,
    this.redeemCode,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    cashBalance,
    walletBalance,
    mobileNumber,
    loyaltyProviderId,
    loyaltyProviderName,
    loyaltyCode,
    redeemCode,
  ];
}
