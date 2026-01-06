import 'package:my_custom_widget/features/branch/domain/entities/branch_image.dart';

class BranchImagesModel extends BranchImages {
  const BranchImagesModel({
    required super.id,
    required super.imageUrl,
  });

  factory BranchImagesModel.fromJson(Map<String, dynamic> json) => BranchImagesModel(
    id: json['Id'],
    imageUrl: json['ImageUrl'],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ImageUrl": imageUrl,
  };
}
