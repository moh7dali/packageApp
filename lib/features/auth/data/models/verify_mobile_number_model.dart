import '../../domain/entities/verify_mobile_number.dart';

class VerifyMobileNumberModel extends VerifyMobileNumber {
  const VerifyMobileNumberModel({
    required super.token,
  });

  factory VerifyMobileNumberModel.fromJson(Map<String, dynamic> json) => VerifyMobileNumberModel(
        token: json["Token"],
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Token'] = token;
    return map;
  }
}
