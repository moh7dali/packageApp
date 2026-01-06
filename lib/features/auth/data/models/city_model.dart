import 'dart:convert';

import 'package:my_custom_widget/core/utils/app_log.dart';
import 'package:my_custom_widget/features/auth/domain/entities/city.dart';

List<CityModel>? countriesFromJson(dynamic str) {
  appLog(str, tag: "countriesFromJson");
  return str == null ? [] : List<CityModel>.from(json.decode(json.encode(str)).map((x) => CityModel.fromJson(x)));
}

class CityModel extends City {
  const CityModel({
    required super.id,
    required super.name,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(id: json["Id"], name: json["Name"]);

  Map<String, dynamic> toMap() => {
        "Id": id,
        "Name": name,
      };
}
