import 'package:equatable/equatable.dart';

class CustomerTierData extends Equatable {
  final int? currentTier;
  final double? tierAmount;
  final DateTime? tierExpiryDate;

  const CustomerTierData({
    this.currentTier,
    this.tierAmount,
    this.tierExpiryDate,
  });

  @override
  List<Object?> get props => [currentTier, tierAmount, tierExpiryDate];
}
