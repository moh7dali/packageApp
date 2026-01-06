import '../../domain/entities/brand_data.dart';
import '../../domain/entities/brand_data_list.dart';
import 'brand_data_model.dart';

class BrandDataListModel extends BrandDataList {
  const BrandDataListModel({
    required super.brandsData,
    required super.totalNumberOfResult,
  });

  factory BrandDataListModel.fromJson(Map<String, dynamic> json) => BrandDataListModel(
        totalNumberOfResult: json["TotalNumberOfResult"],
        brandsData: json["BrandsData"] == null ? [] : List<BrandsData>.from(json["BrandsData"]!.map((x) => BrandDataModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "TotalNumberOfResult": totalNumberOfResult,
        "BrandsData": brandsData,
      };
}
