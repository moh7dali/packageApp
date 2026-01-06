import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final int? id;
  final String? name;
  final String? address;
  final double? latitude;
  final double? longitude;

  const Address({
    this.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [id, name, address, latitude, longitude];
}
