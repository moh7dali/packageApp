import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/usecases/usecase.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_checkout_data.dart';
import 'package:my_custom_widget/features/ordering/domain/repositories/ordering_repository.dart';

import '../../../../core/error/failures.dart';

class CheckOrderingStatus implements UseCase<OrderingStatus, BodyParams> {
  final OrderingRepositories repository;

  CheckOrderingStatus(this.repository);

  @override
  Future<Either<AppFailure, OrderingStatus>> call(BodyParams params) async {
    return await repository.checkOrderingStatus(body: params.body);
  }
}
