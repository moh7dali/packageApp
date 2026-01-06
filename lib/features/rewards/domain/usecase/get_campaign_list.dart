import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/rewards/domain/entity/campaign_rewards.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/rewards_repository.dart';

class GetCampaignList implements UseCase<CampaignRewards, BodyParams> {
  final RewardsRepository repository;

  GetCampaignList(this.repository);

  @override
  Future<Either<AppFailure, CampaignRewards>> call(BodyParams params) async {
    return await repository.getCampaignRewards(body: params.body);
  }
}
