import 'package:mozaic_loyalty_sdk/features/barcode/domain/entities/user_barcode.dart';

class UserBarcodeModel extends UserBarcode {
  const UserBarcodeModel({
    required super.id,
    required super.fullName,
    required super.cashBalance,
    required super.walletBalance,
    required super.mobileNumber,
    required super.loyaltyProviderId,
    required super.loyaltyProviderName,
    required super.loyaltyCode,
    required super.redeemCode,
  });

  factory UserBarcodeModel.fromMap(Map<String, dynamic> json) {
    return UserBarcodeModel(
      id: json['Id'],
      fullName: json['FullName'],
      cashBalance: (json['CashBalance'] as num?)?.toDouble(),
      walletBalance: (json['WalletBalance'] as num?)?.toDouble(),
      mobileNumber: json['MobileNumber'],
      loyaltyProviderId: json['LoyaltyProviderId'],
      loyaltyProviderName: json['LoyaltyProviderName'],
      loyaltyCode: json['LoyaltyCode'],
      redeemCode: json['RedeemCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'FullName': fullName,
      'CashBalance': cashBalance,
      'WalletBalance': walletBalance,
      'MobileNumber': mobileNumber,
      'LoyaltyProviderId': loyaltyProviderId,
      'LoyaltyProviderName': loyaltyProviderName,
      'LoyaltyCode': loyaltyCode,
      'RedeemCode': redeemCode,
    };
  }
}
