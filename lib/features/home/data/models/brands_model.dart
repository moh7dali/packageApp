import '../../domain/entities/brands.dart';

class BrandsModel extends Brands {
  const BrandsModel({
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory BrandsModel.fromMap(Map<String, dynamic> json) => BrandsModel(
        id: json["Id"],
        name: json["Name"],
        imageUrl: json["ImageUrl"],
      );

  Map<String, dynamic> toMap() => {
        "Id": id,
        "Name": name,
        "ImageUrl": imageUrl,
      };
}
