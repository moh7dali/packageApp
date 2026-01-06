import 'package:my_custom_widget/features/loyalty/data/models/business_unit_loyalty_data_model.dart';
import 'package:my_custom_widget/features/loyalty/domain/entity/business_unit_Loyalty_data.dart';
import 'package:my_custom_widget/features/loyalty/domain/entity/point_schema_brand_by_business_unit.dart';

List<PointSchemaBrandByBusinessUnit> tierSchemaBrandByBusinessUnitFromMap(dynamic str) =>
    List<PointSchemaBrandByBusinessUnit>.from(str.map((x) => PointSchemaBrandByBusinessUnitModel.fromJson(x)));

class PointSchemaBrandByBusinessUnitModel extends PointSchemaBrandByBusinessUnit {
  const PointSchemaBrandByBusinessUnitModel(
      {required super.tierId,
      required super.tierName,
      required super.tierLowerLimit,
      required super.businessUnitLoyaltyDataList,
      required super.imageUrl,
      required super.tierColor});

  factory PointSchemaBrandByBusinessUnitModel.fromJson(Map<String, dynamic> json) => PointSchemaBrandByBusinessUnitModel(
        tierId: json["TierId"],
        tierName: json["TierName"],
        tierLowerLimit: json["TierLowerLimit"],
        imageUrl: json["ImageUrl"],
        tierColor: json["TierColor"],
        businessUnitLoyaltyDataList: json["BusinessUnitLoyaltyDataList"] == null
            ? []
            : List<BusinessUnitLoyaltyData>.from(json["BusinessUnitLoyaltyDataList"]!.map((x) => BusinessUnitLoyaltyDataModel.fromJson(x))),
      );
}
