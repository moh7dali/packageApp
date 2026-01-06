import 'package:equatable/equatable.dart';

class MerchantInfo extends Equatable {
  final String? phone;
  final String? mobile;
  final String? email;
  final int? id;
  final String? name;
  final String? webSiteUrl;
  final String? faceBookUrl;
  final String? twitterUrl;
  final String? instagramUrl;

  const MerchantInfo({
    this.phone,
    this.mobile,
    this.email,
    this.id,
    this.name,
    this.webSiteUrl,
    this.faceBookUrl,
    this.twitterUrl,
    this.instagramUrl,
  });

  @override
  List<Object?> get props => [
        phone,
        mobile,
        email,
        id,
        name,
        webSiteUrl,
        faceBookUrl,
        twitterUrl,
        instagramUrl,
      ];
}
