import 'package:my_custom_widget/features/rewards_gallery/domain/entity/reward_gallery.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/repositories/rewards_gallery_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetGalleryRewards implements UseCase<RewardsGalleryList?, BodyParams> {
  final RewardsGalleryRepository repository;

  GetGalleryRewards(this.repository);

  @override
  Future<Either<AppFailure, RewardsGalleryList?>> call(BodyParams params) async {
    return await repository.getGalleryRewards(queryParameters: params.body);
  }
}
