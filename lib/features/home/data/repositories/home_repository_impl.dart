import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/home/data/datasources/home_api_datasorce.dart';
import 'package:my_custom_widget/features/home/domain/entities/home_details.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApiDataSource remoteDataSource;

  

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, HomeDetails>> getHomeDetails({Map<String, dynamic>? body}) async {
   
      try {
        final homeDetailsData = await remoteDataSource.getHomeDetails(body: body!);
        return Right(homeDetailsData);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }

  @override
  Future<Either<AppFailure, HomeDetails>> getCustomerHomeContents({Map<String, dynamic>? body}) async {
   
      try {
        final homeDetailsData = await remoteDataSource.getCustomerHomeContents(body: body!);
        return Right(homeDetailsData);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }
}
