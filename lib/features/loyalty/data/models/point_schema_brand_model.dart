import 'package:mozaic_loyalty_sdk/features/home/data/models/tier_model.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/data/models/tiers_loyalty_data_model.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/domain/entity/point_schema_brand.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/domain/entity/tiers_loyalty_data.dart';

List<PointSchemaBrand> tierSchemaBrandFromMap(dynamic str) => List<PointSchemaBrand>.from(str.map((x) => PointSchemaBrandModel.fromJson(x)));

class PointSchemaBrandModel extends PointSchemaBrand {
  const PointSchemaBrandModel({required super.tierData, required super.loyaltyDataList});

  factory PointSchemaBrandModel.fromJson(Map<String, dynamic> json) => PointSchemaBrandModel(
        tierData: json["TierData"] == null ? null : TierModel.fromMap(json["TierData"]),
        loyaltyDataList: json["LoyaltyDataList"] == null
            ? []
            : List<TiersLoyaltyData>.from(json["LoyaltyDataList"]!.map((x) => TiersLoyaltyDataModel.fromJson(x))),
      );
}
