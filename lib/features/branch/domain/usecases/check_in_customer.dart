import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/error/failures.dart';
import 'package:my_custom_widget/core/usecases/usecase.dart';

import '../repositories/branch_repository.dart';

class CheckInCustomer implements UseCase<dynamic, BodyParams> {
  final BranchRepository repository;

  CheckInCustomer(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(BodyParams params) async {
    return await repository.checkInCustomer(queryParameters: params.body);
  }
}
