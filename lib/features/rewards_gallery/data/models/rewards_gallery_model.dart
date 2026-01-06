import '../../domain/entity/reward_gallery.dart';

class RewardsGalleryModel extends RewardsGallery {
  const RewardsGalleryModel({
    super.typeId,
    super.id,
    super.title,
    super.name,
    super.imageUrl,
    super.description,
    super.numberOfPoints,
  });

  factory RewardsGalleryModel.fromJson(Map<String, dynamic> json) {
    return RewardsGalleryModel(
      typeId: json['TypeId'] as int?,
      id: json['Id'] as int?,
      title: json['Title'] as String?,
      name: json['Name'] as String?,
      imageUrl: (json['ImageUrl'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['Description'] as String?,
      numberOfPoints: (json['NumberOfPoints'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TypeId': typeId,
      'Title': title,
      'Name': name,
      "Id": id,
      'ImageUrl': imageUrl != null ? [imageUrl] : [],
      'Description': description,
      'NumberOfPoints': numberOfPoints,
    };
  }
}

class RewardsGalleryListModel extends RewardsGalleryList {
  const RewardsGalleryListModel({
    super.totalNumberofResult,
    super.rewardsList,
  });

  factory RewardsGalleryListModel.fromJson(Map<String, dynamic> json) {
    return RewardsGalleryListModel(
      totalNumberofResult: json['TotalNumberOfResult'] as int?,
      rewardsList: json["RewardsGalleryList"] == null
          ? []
          : List<RewardsGallery>.from(json["RewardsGalleryList"]!.map((x) => RewardsGalleryModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TotalNumberOfResult': totalNumberofResult,
      'RewardsGalleryList': rewardsList?.map((e) {
        if (e is RewardsGalleryModel) {
          return e.toJson();
        }
        return const {};
      }).toList(),
    };
  }
}
