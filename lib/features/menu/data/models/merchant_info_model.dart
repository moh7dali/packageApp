import 'package:my_custom_widget/features/menu/domain/entity/merchant_info.dart';

class MerchantInfoModel extends MerchantInfo {
  const MerchantInfoModel({
    required super.phone,
    required super.mobile,
    required super.email,
    required super.id,
    required super.name,
    required super.webSiteUrl,
    required super.faceBookUrl,
    required super.twitterUrl,
    required super.instagramUrl,
  });

  factory MerchantInfoModel.fromJson(Map<String, dynamic> json) => MerchantInfoModel(
        phone: json['Phone'],
        mobile: json['Mobile'],
        email: json['Email'],
        id: json['Id'],
        name: json['Name'],
        webSiteUrl: json['WebSiteUrl'],
        faceBookUrl: json['FaceBookUrl'],
        twitterUrl: json['TwitterUrl'],
        instagramUrl: json['InstagramUrl'],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Phone'] = phone;
    map['Mobile'] = mobile;
    map['Email'] = email;
    map['Id'] = id;
    map['Name'] = name;
    map['WebSiteUrl'] = webSiteUrl;
    map['FaceBookUrl'] = faceBookUrl;
    map['TwitterUrl'] = twitterUrl;
    map['InstagramUrl'] = instagramUrl;
    return map;
  }
}
