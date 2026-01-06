import 'package:my_custom_widget/core/api/api_response.dart';
import 'package:my_custom_widget/features/address/data/models/customer_addresses_model.dart';
import 'package:my_custom_widget/features/address/domain/entity/customer_addresses.dart';

import '../../../../core/api/api_end_points.dart';
import '../../../../core/api/api_request.dart';
import '../../../../core/constants/constants.dart';

abstract class AddressApiDataSource {
  Future<dynamic> addNewCustomerAddress({required Map<String, dynamic> body});
  Future<dynamic> deleteCustomerAddress({required Map<String, dynamic> body});

  Future<CustomerAddresses> getCustomerAddresses();
}

class AddressApiDataSourceImpl implements AddressApiDataSource {
  @override
  Future<dynamic> addNewCustomerAddress({required Map<String, dynamic> body}) async {
    dynamic addAddress = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.addNewCustomerAddress,
      body: body,
      authorized: true,
      fromJson: getDynamic,
    );
    return addAddress;
  }

  @override
  Future<CustomerAddresses> getCustomerAddresses() async {
    CustomerAddresses addresses = await ApiRequest<CustomerAddresses>().request(
      method: HttpMethodRequest.getMethode,
      url: ApiEndPoints.getCustomerAddresses,
      body: {},
      authorized: true,
      fromJson: CustomerAddressesModel.fromJson,
    );
    return addresses;
  }

  @override
  Future deleteCustomerAddress({required Map<String, dynamic> body}) async {
    dynamic addAddress = await ApiRequest<dynamic>().request(
      method: HttpMethodRequest.postMethode,
      url: ApiEndPoints.deleteCustomerAddress,
      body: {},
      queryParameters: body,
      authorized: true,
      fromJson: getDynamic,
    );
    return addAddress;
  }
}
