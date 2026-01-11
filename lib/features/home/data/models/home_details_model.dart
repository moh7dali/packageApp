import 'package:my_custom_widget/features/home/data/models/slider_list_model.dart';
import 'package:my_custom_widget/features/home/data/models/tiers_list_model.dart';

import '../../domain/entities/home_details.dart';
import 'brand_data_list_model.dart';
import 'brands_list_model.dart';
import 'business_list_model.dart';
import 'customer_data_nodel.dart';
import 'malls_list_model.dart';

class HomeDetailsModel extends HomeDetails {
  const HomeDetailsModel({
    required super.sliders,
    required super.businessUnits,
    required super.brandsData,
    required super.brands,
    required super.malls,
    required super.customerData,
    required super.tiers,
  });

  factory HomeDetailsModel.fromMap(Map<String, dynamic> json) {
    return HomeDetailsModel(
      sliders: json['Sliders'] == null ? null : SliderListModel.fromJson(json['Sliders']),
      businessUnits: json['BusinessUnits'] == null ? null : BusinessListModel.fromJson(json['BusinessUnits']),
      brands: json['Brands'] == null ? null : BrandsListModel.fromJson(json['Brands']),
      malls: json['Malls'] == null ? null : MallsListModel.fromJson(json['Malls']),
      brandsData: json['BrandsData'] == null ? null : BrandDataListModel.fromJson(json['BrandsData']),
      tiers: json['Tiers'] == null ? null : TiersListModel.fromJson(json['Tiers']),
      customerData: json["LoyaltyData"] == null ? null : CustomerDataModel.fromJson(json["LoyaltyData"]),
    );
  }

  Map<String, dynamic> toMap() => {
    "BusinessUnits": businessUnits,
    "Sliders": sliders,
    "Malls": malls,
    "Brands": brands,
    "BrandsData": brandsData,
    "Tiers": tiers,
    "LoyaltyData": customerData,
  };
}
