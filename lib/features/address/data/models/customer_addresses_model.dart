import 'package:my_custom_widget/features/address/domain/entity/customer_addresses.dart';

import 'address_model.dart';

class CustomerAddressesModel extends CustomerAddresses {
  const CustomerAddressesModel({
    super.addresses,
  });

  factory CustomerAddressesModel.fromJson(List<dynamic> jsonList) {
    return CustomerAddressesModel(
      addresses: jsonList.map((json) => AddressModel.fromJson(json)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    if (addresses == null) {
      return [];
    }
    return addresses!.map((address) {
      if (address is AddressModel) {
        return address.toJson();
      } else {
        return {
          'Id': address.id,
          'Name': address.name,
          'Address': address.address,
          'Latitude': address.latitude,
          'Longitude': address.longitude,
        };
      }
    }).toList();
  }
}
