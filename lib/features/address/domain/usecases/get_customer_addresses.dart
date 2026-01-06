import 'package:my_custom_widget/features/address/domain/repositories/address_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/customer_addresses.dart';

class GetCustomerAddresses implements UseCase<CustomerAddresses, NoParams> {
  final AddressRepository repository;

  GetCustomerAddresses(this.repository);

  @override
  Future<Either<AppFailure, CustomerAddresses>> call(NoParams p) async {
    return await repository.getCustomerAddresses();
  }
}
