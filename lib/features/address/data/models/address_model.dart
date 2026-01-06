import 'package:my_custom_widget/features/address/domain/entity/address.dart';


class AddressModel extends Address {
  const AddressModel({
    super.id,
    super.name,
    super.address,
    super.latitude,
    super.longitude,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['Id'] as int?,
      name: json['Name'] as String?,
      address: json['Address'] as String?,
      latitude: (json['Latitude'] as num?)?.toDouble(),
      longitude: (json['Longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Address': address,
      'Latitude': latitude,
      'Longitude': longitude,
    };
  }
}
