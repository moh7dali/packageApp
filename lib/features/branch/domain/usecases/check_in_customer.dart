import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/core/error/failures.dart';
import 'package:mozaic_loyalty_sdk/core/usecases/usecase.dart';

import '../repositories/branch_repository.dart';

class CheckInCustomer implements UseCase<dynamic, BodyParams> {
  final BranchRepository repository;

  CheckInCustomer(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(BodyParams params) async {
    return await repository.checkInCustomer(queryParameters: params.body);
  }
}
