import 'package:my_custom_widget/features/address/domain/repositories/address_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class AddNewCustomerAddress implements UseCase<dynamic, BodyParams> {
  final AddressRepository repository;

  AddNewCustomerAddress(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(BodyParams params) async {
    return await repository.addNewCustomerAddress(body: params.body);
  }
}
