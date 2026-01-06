import 'dart:convert';

import '../../domain/entities/look_up.dart';

List<LookUpModel>? lookUpFromJson(dynamic str) {
  return str == null ? [] : List<LookUpModel>.from(json.decode(json.encode(str)).map((x) => LookUpModel.fromJson(x)));
}

class LookUpModel extends LookUp {
  const LookUpModel({
    required super.id,
    required super.name,
  });

  factory LookUpModel.fromJson(Map<String, dynamic> json) => LookUpModel(id: json["Id"], name: json["Name"]);

  Map<String, dynamic> toMap() => {
    "Id": id,
    "Name": name,
  };
}
