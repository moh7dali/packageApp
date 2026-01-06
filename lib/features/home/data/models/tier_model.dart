import '../../domain/entities/tier.dart';

class TierModel extends TiersData {
  const TierModel({
    required super.id,
    required super.lowerLimit,
    required super.name,
    required super.maintainingAmount,
    required super.latinName,
    required super.merchantId,
    required super.creationDate,
    required super.createdBy,
    required super.modificationDate,
    required super.modifiedBy,
    required super.isActive,
    required super.imageUrl,
    required super.tierColor,
  });

  factory TierModel.fromMap(Map<String, dynamic> json) => TierModel(
      id: json["Id"],
      lowerLimit: json["LowerLimit"],
      name: json["Name"],
      maintainingAmount: json["MaintainingAmount"],
      latinName: json["LatinName"],
      merchantId: json["MerchantId"],
      creationDate: json["CreationDate"] == null ? null : DateTime.parse(json["CreationDate"]),
      createdBy: json["CreatedBy"],
      modificationDate: json["ModificationDate"],
      modifiedBy: json["ModifiedBy"],
      isActive: json["IsActive"],
      imageUrl: json["ImageUrl"],
      tierColor: json["TierColor"]);

  Map<String, dynamic> toMap() => {
        "Id": id,
        "LowerLimit": lowerLimit,
        "Name": name,
        "MaintainingAmount": maintainingAmount,
        "LatinName": latinName,
        "MerchantId": merchantId,
        "CreationDate": creationDate?.toIso8601String(),
        "CreatedBy": createdBy,
        "ModificationDate": modificationDate,
        "ModifiedBy": modifiedBy,
        "IsActive": isActive,
        "ImageUrl": imageUrl,
        "TierColor": tierColor
      };
}
