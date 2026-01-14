import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../entity/user_balance_history_list.dart';
import '../repositories/loyalty_repository.dart';

class GetUserBalanceHistory implements UseCase<UserBalanceHistoryList, BodyParams> {
  final LoyaltyRepository repository;

  GetUserBalanceHistory(this.repository);

  @override
  Future<Either<AppFailure, UserBalanceHistoryList>> call(BodyParams params) async {
    return await repository.getUserBalanceHistory(body: params.body);
  }
}
