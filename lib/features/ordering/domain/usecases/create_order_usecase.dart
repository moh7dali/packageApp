import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/usecases/usecase.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/create_order.dart';
import 'package:my_custom_widget/features/ordering/domain/repositories/ordering_repository.dart';

import '../../../../core/api/api_response.dart';
import '../../../../core/error/failures.dart';

class CreateOrderUsecase implements UseCase<ApiResponse<CreateOrder>, BodyParams> {
  final OrderingRepositories repository;

  CreateOrderUsecase(this.repository);

  @override
  Future<Either<AppFailure, ApiResponse<CreateOrder>>> call(BodyParams params) async {
    return await repository.createOrder(body: params.body);
  }
}
