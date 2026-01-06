import 'package:my_custom_widget/features/topup/domain/entities/purchase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/top_up_repository.dart';

class PurchaseTopUp extends UseCase<TopUpPurchaseResult, BodyParams> {
  final TopUpRepository repository;

  PurchaseTopUp(this.repository);

  @override
  Future<Either<AppFailure, TopUpPurchaseResult>> call(BodyParams params) async {
    return await repository.purchaseTopUp(body: params.body);
  }
}
