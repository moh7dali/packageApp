import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/menu/domain/entity/profile_attribute.dart';

import '../../../auth/domain/entities/area.dart';
import '../../../auth/domain/entities/city.dart';

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
  final City? city;
  final Area? area;
  final List<ProfileAttribute>? profileAttributes;

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
    required this.city,
    required this.area,
    required this.profileAttributes,
  });

  @override
  List<Object?> get props => [
        id,
        merchantId,
        gender,
        birthDate,
        anniversary,
        maritalStatusId,
        firstName,
        lastName,
        mobileNumber,
        profileAttributes,
        city,
        area,
      ];
}
