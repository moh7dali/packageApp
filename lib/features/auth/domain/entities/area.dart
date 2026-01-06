import 'package:equatable/equatable.dart';

class Area extends Equatable {
  final int? id;
  final String name;
  final int? cityId;

  const Area({required this.id, required this.name, required this.cityId});

  @override
  List<Object?> get props => [id, name, cityId];
}
