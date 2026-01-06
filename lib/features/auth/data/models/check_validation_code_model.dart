import '../../domain/entities/check_validation_code.dart';

class CheckValidationCodeModel extends CheckValidationCode {
  const CheckValidationCodeModel({
    required super.sessionToken,
    required super.isCompleted,
    required super.hasReferral,
    required super.userCode,
    required super.accessToken,
    required super.firstName,
    required super.lastName,
    required super.profileId,
    required super.merchantId,
  });

  factory CheckValidationCodeModel.fromJson(Map<String, dynamic> json) => CheckValidationCodeModel(
        sessionToken: json['SessionToken'],
        isCompleted: json['IsCompleted'],
        hasReferral: json['HasReferral'],
        userCode: json['UserCode'],
        accessToken: json['AccessToken'],
        firstName: json['FirstName'],
        lastName: json['LastName'],
        profileId: json['ProfileId'],
        merchantId: json['MerchantId'],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['SessionToken'] = sessionToken;
    map['IsCompleted'] = isCompleted;
    map['HasReferral'] = hasReferral;
    map['UserCode'] = userCode;
    map['AccessToken'] = accessToken;
    map['FirstName'] = firstName;
    map['LastName'] = lastName;
    map['ProfileId'] = profileId;
    map['MerchantId'] = merchantId;
    return map;
  }

  bool get isAllNotNull {
    return props.every((element) => element != null);
  }
}
