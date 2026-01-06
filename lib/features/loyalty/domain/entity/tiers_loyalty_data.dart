import 'package:equatable/equatable.dart';

class TiersLoyaltyData extends Equatable {
  final double? conversionValue;
  final double? discount;
  final String? brandName;

  const TiersLoyaltyData({required this.conversionValue, required this.discount, required this.brandName});

  @override
  List<Object?> get props => [conversionValue, discount, brandName];
}
