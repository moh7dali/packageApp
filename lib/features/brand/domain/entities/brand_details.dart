import 'package:equatable/equatable.dart';

class BrandDetails extends Equatable {
  final String? description;
  final String? webSiteUrl;
  final String? faceBookUrl;
  final String? instagramUrl;
  final String? twitterUrl;
  final String? tikTokUrl;
  final String? mobileNumber;
  final dynamic brandImages;
  final int? id;
  final String? name;
  final String? imageUrl;

  const BrandDetails({
    this.description,
    this.webSiteUrl,
    this.faceBookUrl,
    this.instagramUrl,
    this.twitterUrl,
    this.tikTokUrl,
    this.mobileNumber,
    this.brandImages,
    this.id,
    this.name,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [
        description,
        webSiteUrl,
        faceBookUrl,
        instagramUrl,
        twitterUrl,
        tikTokUrl,
        mobileNumber,
        brandImages,
        id,
        name,
        imageUrl,
      ];
}
