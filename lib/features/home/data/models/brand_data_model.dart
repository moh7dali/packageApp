import '../../data/models/brands_model.dart';
import '../../domain/entities/brand_data.dart';

class BrandDataModel extends BrandsData {
  const BrandDataModel({
    required super.businessUnitId,
    required super.brands,
  });

  factory BrandDataModel.fromMap(Map<String, dynamic> json) => BrandDataModel(
        businessUnitId: json["BusinessUnitID"],
        brands: json["List"] == null ? [] : List<BrandsModel>.from(json["List"]!.map((x) => BrandsModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "BusinessUnitID": businessUnitId,
        "Brands": brands,
      };
}
