import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/entity/reward_gallery.dart';

import '../../../../core/error/failures.dart';

abstract class RewardsGalleryRepository {
  Future<Either<AppFailure, RewardsGalleryList>> getGalleryRewards({Map<String, dynamic>? queryParameters});

  Future<Either<AppFailure, dynamic>> redeemReward({required Map<String, dynamic> body});
}
