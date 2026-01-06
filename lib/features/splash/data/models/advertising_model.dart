import '../../domain/entities/advertising.dart';
import '../../domain/entities/advertising_list.dart';

class AdvertisingListModel extends AdvertisingList {
  const AdvertisingListModel({required super.advertisingList});

  factory AdvertisingListModel.fromJson(Map<String, dynamic> json) => AdvertisingListModel(
      advertisingList:
          json["AdvertisingList"] == null ? [] : List<Advertising>.from(json["AdvertisingList"]!.map((x) => AdvertisingModel.fromJson(x))));

  Map<String, dynamic> toMap() => {
        "AdvertisingList": advertisingList,
      };
}

class AdvertisingModel extends Advertising {
  const AdvertisingModel({
    required super.id,
    required super.assignType,
    required super.assignTypeId,
    required super.displayOrder,
    required super.advertisingImages,
  });

  factory AdvertisingModel.fromJson(Map<String, dynamic> json) => AdvertisingModel(
        id: json["Id"],
        assignType: json["AssignType"],
        assignTypeId: json["AssignTypeId"],
        displayOrder: json["DisplayOrder"],
        advertisingImages: json["AdvertisingImages"] == null ? [] : List<String>.from(json["AdvertisingImages"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "Id": id,
        "AssignType": assignType,
        "AssignTypeId": assignTypeId,
        "DisplayOrder": displayOrder,
        "AdvertisingImages": advertisingImages,
      };
}
