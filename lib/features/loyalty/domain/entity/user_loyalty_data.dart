import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/loyalty/domain/entity/loyalty_data.dart';

import '../../../home/domain/entities/tier.dart';

class UserLoyaltyData extends Equatable {
  final LoyaltyData? loyaltyData;
  final List<TiersData>? tiers;

  const UserLoyaltyData({required this.loyaltyData,required this.tiers});

  @override
  List<Object?> get props => [loyaltyData];
}
