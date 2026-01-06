import 'dart:convert';

import '../../domain/entities/area.dart';

List<AreaModel>? areasFromJson(dynamic str) => List<AreaModel>.from(json.decode(json.encode(str)).map((x) => x != null ? AreaModel.fromJson(x) : []));

class AreaModel extends Area {
  const AreaModel({
    required super.id,
    required super.name,
    required super.cityId,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(id: json["Id"], name: json["Name"], cityId: json['CityId']);

  Map<String, dynamic> toMap() => {"Id": id, "Name": name, 'CityId': cityId};
}
