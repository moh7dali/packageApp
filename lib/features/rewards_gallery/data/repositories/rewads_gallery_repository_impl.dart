import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/rewards_gallery/data/datasource/rewards_gallery_api_datasource.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/entity/reward_gallery.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/repositories/rewards_gallery_repository.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class RewardsGalleryRepositoryImpl implements RewardsGalleryRepository {
  final RewardsGalleryApiDatasource remoteDataSource;

  

  RewardsGalleryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, RewardsGalleryList>> getGalleryRewards({Map<String, dynamic>? queryParameters}) async {
   
      try {
        final subCategoryList = await remoteDataSource.getGalleryRewards(queryParameters: queryParameters);
        return Right(subCategoryList);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }

  @override
  Future<Either<AppFailure, dynamic>> redeemReward({required Map<String, dynamic> body}) async {
   
      try {
        final redeemReward = await remoteDataSource.redeemReward(body: body);
        return Right(redeemReward);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }
}
