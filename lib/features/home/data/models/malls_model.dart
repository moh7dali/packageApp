import '../../domain/entities/malls.dart';

class MallsModel extends Malls {
  const MallsModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory MallsModel.fromMap(Map<String, dynamic> json) => MallsModel(id: json["Id"], name: json["Name"], imageUrl: json["ImageUrl"]);

  Map<String, dynamic> toMap() => {"Id": id, "Name": name, "ImageUrl": imageUrl};
}
