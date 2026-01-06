import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/loyalty/domain/entity/business_unit_Loyalty_data.dart';

class PointSchemaBrandByBusinessUnit extends Equatable {
  final int? tierId;
  final String? tierName;
  final String? imageUrl;
  final String? tierColor;
  final double? tierLowerLimit;
  final List<BusinessUnitLoyaltyData>? businessUnitLoyaltyDataList;

  const PointSchemaBrandByBusinessUnit({this.tierId, this.tierName, this.tierLowerLimit, this.businessUnitLoyaltyDataList,this.imageUrl,this.tierColor});

  @override
  List<Object?> get props => throw UnimplementedError();
}
