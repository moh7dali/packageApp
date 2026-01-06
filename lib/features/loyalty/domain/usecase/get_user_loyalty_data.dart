import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/user_loyalty_data.dart';
import '../repositories/loyalty_repository.dart';

class GetUserLoyaltyData implements UseCase<UserLoyaltyData?, NoParams> {
  final LoyaltyRepository repository;

  GetUserLoyaltyData(this.repository);

  @override
  Future<Either<AppFailure, UserLoyaltyData?>> call(NoParams params) async {
    return await repository.getUserLoyaltyData();
  }
}
