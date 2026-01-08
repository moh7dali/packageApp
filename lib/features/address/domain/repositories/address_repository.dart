import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/address/domain/entity/customer_addresses.dart';

import '../../../../core/error/failures.dart';

abstract class AddressRepository {
  Future<Either<AppFailure, dynamic>> addNewCustomerAddress({required Map<String, dynamic> body});

  Future<Either<AppFailure, CustomerAddresses>> getCustomerAddresses();

  Future<Either<AppFailure, dynamic>> deleteCustomerAddress({required Map<String, dynamic> body});
}
