import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/error/failures.dart';
import 'package:my_custom_widget/features/rate/data/datasourse/rate_api_datasourse.dart';
import 'package:my_custom_widget/features/rate/domian/repositories/rate_repository.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';

class RateRepositoryImpl implements RateRepositories {
  final RateApiDataSource remoteDataSource;
  

  RateRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, dynamic>> rateBranchVisit({Map<String, dynamic>? body}) async {
   
      try {
        final remoteRateBranchVisit = await remoteDataSource.rateBranchVisit(body: body!);
        return Right(remoteRateBranchVisit);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }
}
