import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/loyalty/domain/entity/tiers_loyalty_data.dart';

class BusinessUnitLoyaltyData extends Equatable {
  final int? businessUnitId;
  final String? businessUnitName;
  final List<TiersLoyaltyData>? tiersLoyaltyDataList;

  const BusinessUnitLoyaltyData({required this.businessUnitId, required this.businessUnitName, required this.tiersLoyaltyDataList});

  @override
  List<Object?> get props => [
        businessUnitId,
        businessUnitName,
        tiersLoyaltyDataList,
      ];
}
