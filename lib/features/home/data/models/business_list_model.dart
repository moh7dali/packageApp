import '../../domain/entities/business_unit.dart';
import '../../domain/entities/business_units_list.dart';
import 'business_unit_model.dart';

class BusinessListModel extends BusinessUnitList {
  const BusinessListModel({
    required super.businessUnits,
    required super.totalNumberOfResult,
  });

  factory BusinessListModel.fromJson(Map<String, dynamic> json) => BusinessListModel(
        totalNumberOfResult: json["TotalNumberOfResult"],
        businessUnits: json["List"] == null ? [] : List<BusinessUnit>.from(json["List"]!.map((x) => BusinessUnitModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "TotalNumberOfResult": totalNumberOfResult,
        "BusinessUnits": businessUnits,
      };
}
