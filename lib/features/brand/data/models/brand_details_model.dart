import 'package:my_custom_widget/features/brand/domain/entities/brand_details.dart';

class BrandDetailsModel extends BrandDetails {
  const BrandDetailsModel({
    required super.description,
    required super.webSiteUrl,
    required super.faceBookUrl,
    required super.instagramUrl,
    required super.twitterUrl,
    required super.tikTokUrl,
    required super.mobileNumber,
    required super.brandImages,
    required super.id,
    required super.name,
    required super.imageUrl,
  });

  factory BrandDetailsModel.fromJson(Map<String, dynamic> json) => BrandDetailsModel(
        description: json["Description"],
        webSiteUrl: json["WebSiteUrl"],
        faceBookUrl: json["FaceBookUrl"],
        instagramUrl: json["InstagramUrl"],
        twitterUrl: json["TwitterUrl"],
        tikTokUrl: json["TikTokUrl"],
        mobileNumber: json["MobileNumber"],
        brandImages: json["BrandImages"],
        id: json["Id"],
        name: json["Name"],
        imageUrl: json["ImageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "Description": description,
        "WebSiteUrl": webSiteUrl,
        "FaceBookUrl": faceBookUrl,
        "InstagramUrl": instagramUrl,
        "TwitterUrl": twitterUrl,
        "TikTokUrl": tikTokUrl,
        "MobileNumber": mobileNumber,
        "BrandImages": brandImages,
        "Id": id,
        "Name": name,
        "ImageUrl": imageUrl,
      };
}
