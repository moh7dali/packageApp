import 'package:my_custom_widget/core/usecases/usecase.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_history.dart';
import 'package:my_custom_widget/features/ordering/domain/repositories/ordering_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetCustomerOrders implements UseCase<OrderHistoryList, BodyParams> {
  final OrderingRepositories repository;

  GetCustomerOrders(this.repository);

  @override
  Future<Either<AppFailure, OrderHistoryList>> call(BodyParams params) async {
    return await repository.getCustomerOrders(body: params.body);
  }
}
