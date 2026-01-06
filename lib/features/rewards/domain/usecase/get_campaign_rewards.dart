import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/campaign_list.dart';
import '../repositories/rewards_repository.dart';

class GetCampaignRewards implements UseCase<CampaignList, BodyParams> {
  final RewardsRepository repository;

  GetCampaignRewards(this.repository);

  @override
  Future<Either<AppFailure, CampaignList>> call(BodyParams params) async {
    return await repository.getCampaignList(body: params.body);
  }
}
