import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final int? id;
  final String? name;
  final String? flag;
  final String? callingCode;
  final String? iso2;

  const Country({required this.callingCode, required this.iso2, required this.id, required this.name, required this.flag});

  @override
  List<Object?> get props => [id, name, flag, callingCode, iso2];
}
