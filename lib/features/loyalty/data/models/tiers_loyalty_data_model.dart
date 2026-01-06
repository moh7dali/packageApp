import 'package:my_custom_widget/features/loyalty/domain/entity/tiers_loyalty_data.dart';

class TiersLoyaltyDataModel extends TiersLoyaltyData {
  const TiersLoyaltyDataModel({required super.conversionValue, required super.discount, required super.brandName});

  factory TiersLoyaltyDataModel.fromJson(Map<String, dynamic> json) => TiersLoyaltyDataModel(
        conversionValue: json["ConversionValue"]?.toDouble(),
        discount: json["Discount"] ?? 0,
        brandName: json["BrandName"],
      );
}
