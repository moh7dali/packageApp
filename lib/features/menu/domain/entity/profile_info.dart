import 'package:equatable/equatable.dart';

class ProfileInfo extends Equatable {
  final int? id;
  final int? merchantId;
  final int? gender;
  final String? birthDate;
  final String? anniversary;
  final int? maritalStatusId;
  final String? firstName;
  final String? lastName;
  final String? mobileNumber;

  const ProfileInfo({
    required this.id,
    required this.merchantId,
    required this.gender,
    required this.birthDate,
    required this.anniversary,
    required this.maritalStatusId,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
  });

  @override
  List<Object?> get props => [id, merchantId, gender, birthDate, anniversary, maritalStatusId, firstName, lastName, mobileNumber];
}
