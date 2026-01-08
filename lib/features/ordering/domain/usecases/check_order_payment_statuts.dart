import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/usecases/usecase.dart';
import 'package:my_custom_widget/features/ordering/domain/repositories/ordering_repository.dart';

import '../../../../core/error/failures.dart';
import '../entity/payment_status.dart';

class CheckOrderPaymentStatus implements UseCase<PaymentStatus, BodyParams> {
  final OrderingRepositories repository;

  CheckOrderPaymentStatus(this.repository);

  @override
  Future<Either<AppFailure, PaymentStatus>> call(BodyParams params) async {
    return await repository.checkOrderPaymentStatus(body: params.body);
  }
}
