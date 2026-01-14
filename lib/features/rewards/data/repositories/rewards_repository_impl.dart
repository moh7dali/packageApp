import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/core/error/failures.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/campaign_list.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/campaign_rewards.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/user_reward_list.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/rewards_repository.dart';
import '../datasoursces/rewards_api_datasourse.dart';

class RewardsRepositoryImpl implements RewardsRepository {
  final RewardsApiDataSource remoteDataSource;

  RewardsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, CampaignList>> getCampaignList({Map<String, dynamic>? body}) async {
    try {
      final remoteCampaignList = await remoteDataSource.getCampaignList(body: body!);
      return Right(remoteCampaignList);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }

  @override
  Future<Either<AppFailure, UserRewardsList>> getUserRewards({Map<String, dynamic>? body}) async {
    try {
      final remoteUserRewards = await remoteDataSource.getUserRewards(body: body!);
      return Right(remoteUserRewards);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }

  @override
  Future<Either<AppFailure, CampaignRewards>> getCampaignRewards({Map<String, dynamic>? body}) async {
    try {
      final remoteUserRewards = await remoteDataSource.getCampaignRewards(body: body!);
      return Right(remoteUserRewards);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }
}
