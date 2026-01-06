import 'package:my_custom_widget/features/loyalty/data/models/tiers_loyalty_data_model.dart';
import 'package:my_custom_widget/features/loyalty/domain/entity/business_unit_Loyalty_data.dart';

import '../../domain/entity/tiers_loyalty_data.dart';

class BusinessUnitLoyaltyDataModel extends BusinessUnitLoyaltyData {
  const BusinessUnitLoyaltyDataModel({required super.businessUnitId, required super.businessUnitName, required super.tiersLoyaltyDataList});

  factory BusinessUnitLoyaltyDataModel.fromJson(Map<String, dynamic> json) => BusinessUnitLoyaltyDataModel(
        businessUnitId: json["BusinessUnitId"],
        businessUnitName: json["BusinessUnitName"],
        tiersLoyaltyDataList: json["TiersLoyaltyDataList"] == null
            ? []
            : List<TiersLoyaltyData>.from(json["TiersLoyaltyDataList"]!.map((x) => TiersLoyaltyDataModel.fromJson(x))),
      );
}
