import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/usecases/usecase.dart';
import 'package:my_custom_widget/features/ordering/domain/repositories/ordering_repository.dart';

import '../../../../core/error/failures.dart';
import '../entity/order_details.dart';

class GetOrderDetails implements UseCase<OrderDetails, BodyParams> {
  final OrderingRepositories repository;

  GetOrderDetails(this.repository);

  @override
  Future<Either<AppFailure, OrderDetails>> call(BodyParams params) async {
    return await repository.getOrderDetails(body: params.body);
  }
}
