import 'package:my_custom_widget/features/rewards_gallery/domain/repositories/rewards_gallery_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class RedeemReward implements UseCase<dynamic, BodyParams> {
  final RewardsGalleryRepository repository;

  RedeemReward(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(BodyParams params) async {
    return await repository.redeemReward(body: params.body);
  }
}
