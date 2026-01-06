import 'package:my_custom_widget/features/brand/domain/entities/brand_details.dart';
import 'package:my_custom_widget/features/brand/domain/entities/brands_list.dart';

import 'brand_details_model.dart';

class BrandDetailsListModel extends BrandDetailsList {
  const BrandDetailsListModel({
    required super.totalNumberofResult,
    required super.brands,
  });

  factory BrandDetailsListModel.fromJson(Map<String, dynamic> json) => BrandDetailsListModel(
        totalNumberofResult: json["TotalNumberofResult"],
        brands: json["Brands"] == null ? [] : List<BrandDetails>.from(json["Brands"]!.map((x) => BrandDetailsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TotalNumberofResult": totalNumberofResult,
        "Brands": brands,
      };
}
