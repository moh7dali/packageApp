import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/campaign_rewards.dart';

import '../../../../core/error/failures.dart';
import '../entity/campaign_list.dart';
import '../entity/user_reward_list.dart';

abstract class RewardsRepository {
  Future<Either<AppFailure, CampaignList>> getCampaignList({Map<String, dynamic>? body});

  Future<Either<AppFailure, UserRewardsList>> getUserRewards({Map<String, dynamic>? body});

  Future<Either<AppFailure, CampaignRewards>> getCampaignRewards({Map<String, dynamic>? body});
}
