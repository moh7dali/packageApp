import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/topup/domain/entities/top_up_history.dart';
import 'package:my_custom_widget/features/topup/domain/repositories/top_up_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetCustomerWalletHistory implements UseCase<TopUpHistoryList?, BodyParams> {
  final TopUpRepository repository;

  GetCustomerWalletHistory(this.repository);

  @override
  Future<Either<AppFailure, TopUpHistoryList?>> call(BodyParams params) async {
    return await repository.getCustomerWalletHistory(body: params.body);
  }
}
