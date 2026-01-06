import 'package:my_custom_widget/core/error/exceptions.dart';
import 'package:my_custom_widget/core/error/failures.dart';
import 'package:my_custom_widget/core/utils/network_info.dart';
import 'package:my_custom_widget/features/splash/data/datasources/splash_api_datasource.dart';
import 'package:my_custom_widget/features/splash/domain/entities/application_version.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../core/api/api_response_error.dart';
import '../../domain/entities/advertising_list.dart';
import '../../domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashApiDataSource remoteDataSource;

  

  SplashRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, AdvertisingList>> getAdvertising({required Map<String, dynamic> queryParameters}) async {
   
      try {
        final remoteAdvertising = await remoteDataSource.getAdvertisingApi(queryParameters: queryParameters);
        return Right(remoteAdvertising);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }

  @override
  Future<Either<AppFailure, ApplicationVersion>> getApplicationVersion(String? buildNumber) async {
   
      try {
        final remoteApplicationVersion = await remoteDataSource.getApplicationVersionApi(buildNumber);
        return Right(remoteApplicationVersion);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }
}
