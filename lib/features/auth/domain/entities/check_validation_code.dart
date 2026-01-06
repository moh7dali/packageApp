import 'package:equatable/equatable.dart';

class CheckValidationCode extends Equatable {
  final String? sessionToken;
  final bool? isCompleted;
  final bool? hasReferral;
  final String? userCode;
  final String? accessToken;
  final String? firstName;
  final String? lastName;
  final num? profileId;
  final num? merchantId;

  const CheckValidationCode(
      {required this.sessionToken,
      required this.isCompleted,
      required this.hasReferral,
      required this.userCode,
      required this.accessToken,
      required this.firstName,
      required this.lastName,
      required this.profileId,
      required this.merchantId});

  @override
  List<Object?> get props => [sessionToken, accessToken];
}
