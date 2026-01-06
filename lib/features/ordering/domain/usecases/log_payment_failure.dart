import 'package:my_custom_widget/core/usecases/usecase.dart';
import 'package:my_custom_widget/features/ordering/domain/repositories/ordering_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class LogPaymentFailure implements UseCase<dynamic, BodyParams> {
  final OrderingRepositories repository;

  LogPaymentFailure(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(BodyParams params) async {
    return await repository.logPaymentFailure(body: params.body);
  }
}
