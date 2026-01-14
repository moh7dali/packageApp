import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/user_reward_list.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/repositories/rewards_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetUserRewards implements UseCase<UserRewardsList, BodyParams> {
  final RewardsRepository repository;

  GetUserRewards(this.repository);

  @override
  Future<Either<AppFailure, UserRewardsList>> call(BodyParams params) async {
    return await repository.getUserRewards(body: params.body);
  }
}
