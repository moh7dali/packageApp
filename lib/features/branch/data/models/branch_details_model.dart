import 'package:mozaic_loyalty_sdk/features/branch/data/models/branch_image_model.dart';
import 'package:mozaic_loyalty_sdk/features/branch/domain/entities/branch_image.dart';

import '../../domain/entities/branch_details.dart';

class BranchDetailsModel extends BranchDetails {
  const BranchDetailsModel({
    required super.id,
    required super.name,
    required super.description,
    required super.mobile,
    required super.latitude,
    required super.longitude,
    required super.openTime,
    required super.closeTime,
    required super.address,
    required super.branchImages,
  });

  factory BranchDetailsModel.fromJson(Map<String, dynamic> json) => BranchDetailsModel(
        id: json['Id'],
        name: json['Name'],
        description: json['Description'],
        mobile: json['Phone'],
        latitude: json['Latitude'],
        longitude: json['Longitude'],
        openTime: json['OpenTime'],
        closeTime: json['CloseTime'],
        address: json['Address'],
        branchImages: json["BranchImages"] == null ? [] : List<BranchImages>.from(json["BranchImages"]!.map((x) => BranchImagesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Description": description,
        "Phone": mobile,
        "Latitude": latitude,
        "Longitude": longitude,
        "OpenTime": openTime,
        "CloseTime": closeTime,
        "Address": address,
        "BranchImages": branchImages?.map((image) => (image as BranchImagesModel).toJson()).toList(),
      };
}
