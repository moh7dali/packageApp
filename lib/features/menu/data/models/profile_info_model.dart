import 'package:my_custom_widget/features/menu/data/models/profile_attribute_model.dart';

import '../../domain/entity/profile_info.dart';

class ProfileInfoModel extends ProfileInfo {
  const ProfileInfoModel({
    required super.id,
    required super.merchantId,
    required super.gender,
    required super.birthDate,
    required super.anniversary,
    required super.maritalStatusId,
    required super.firstName,
    required super.lastName,
    required super.mobileNumber,
  });

  factory ProfileInfoModel.fromJson(Map<String, dynamic> json) => ProfileInfoModel(
    id: json["Id"],
    merchantId: json['MerchantId'],
    gender: json['Gender'],
    birthDate: json['BirthDate'],
    anniversary: json['AnniversaryDate'],
    maritalStatusId: json['MaritalStatusId'],
    firstName: json['FirstName'],
    lastName: json['LastName'],
    mobileNumber: json['MobileNumber'],
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = id;
    map['MerchantId'] = merchantId;
    map['Gender'] = gender;
    map['BirthDate'] = birthDate;
    map['AnniversaryDate'] = anniversary;
    map['MaritalStatusId'] = maritalStatusId;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['MobileNumber'] = mobileNumber;
    return map;
  }
}
