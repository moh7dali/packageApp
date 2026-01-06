import 'package:equatable/equatable.dart';

class CustomerInfo extends Equatable {
  final int? id;
  final String? fullName;
  final String? mobileNumber;
  final String? gender;

  const CustomerInfo({
    this.id,
    this.fullName,
    this.mobileNumber,
    this.gender,
  });

  @override
  List<Object?> get props => [id, fullName, mobileNumber, gender];
}
