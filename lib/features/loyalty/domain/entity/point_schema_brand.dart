import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/home/domain/entities/tier.dart';
import 'package:my_custom_widget/features/loyalty/domain/entity/tiers_loyalty_data.dart';

class PointSchemaBrand extends Equatable {
  final TiersData? tierData;
  final List<TiersLoyaltyData>? loyaltyDataList;

  const PointSchemaBrand({
    this.tierData,
    this.loyaltyDataList,
  });

  @override
  List<Object?> get props => [
        tierData,
        loyaltyDataList,
      ];
}
