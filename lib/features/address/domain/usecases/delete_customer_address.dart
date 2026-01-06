import 'package:my_custom_widget/features/address/domain/repositories/address_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class DeleteCustomerAddress implements UseCase<dynamic, BodyParams> {
  final AddressRepository repository;

  DeleteCustomerAddress(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(BodyParams params) async {
    return await repository.deleteCustomerAddress(body: params.body);
  }
}
