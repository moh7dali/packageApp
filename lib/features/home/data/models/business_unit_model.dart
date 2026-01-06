import '../../domain/entities/business_unit.dart';

class BusinessUnitModel extends BusinessUnit {
  const BusinessUnitModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory BusinessUnitModel.fromMap(Map<String, dynamic> json) => BusinessUnitModel(id: json["Id"], name: json["Name"], imageUrl: json["ImageUrl"]);

  Map<String, dynamic> toMap() => {"Id": id, "Name": name, "ImageUrl": imageUrl};
}
