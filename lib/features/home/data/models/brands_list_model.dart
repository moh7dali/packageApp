import '../../domain/entities/brand_list.dart';
import '../../domain/entities/brands.dart';
import 'brands_model.dart';

class BrandsListModel extends BrandsList {
  const BrandsListModel({
    required super.brands,
    required super.totalNumberOfResult,
  });

  factory BrandsListModel.fromJson(Map<String, dynamic> json) => BrandsListModel(
        totalNumberOfResult: json["TotalNumberOfResult"],
        brands: json["List"] == null ? [] : List<Brands>.from(json["List"]!.map((x) => BrandsModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "TotalNumberOfResult": totalNumberOfResult,
        "List": brands,
      };
}
