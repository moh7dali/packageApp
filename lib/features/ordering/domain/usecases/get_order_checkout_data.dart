import 'package:my_custom_widget/core/usecases/usecase.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_checkout_data.dart';
import 'package:my_custom_widget/features/ordering/domain/repositories/ordering_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

class GetOrderCheckoutData implements UseCase<OrderCheckoutData, BodyParams> {
  final OrderingRepositories repository;

  GetOrderCheckoutData(this.repository);

  @override
  Future<Either<AppFailure, OrderCheckoutData>> call(BodyParams params) async {
    return await repository.getOrderCheckoutData(body: params.body);
  }
}
