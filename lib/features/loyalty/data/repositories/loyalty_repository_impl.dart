import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/core/error/failures.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/data/datasources/loyalty_api_datasource.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/domain/entity/point_schema_brand.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/domain/entity/user_loyalty_data.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/domain/repositories/loyalty_repository.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entity/user_balance_history_list.dart';

class LoyaltyRepositoryImpl implements LoyaltyRepository {
  final LoyaltyApiDataSource remoteDataSource;

  LoyaltyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, UserBalanceHistoryList>> getUserBalanceHistory({Map<String, dynamic>? body}) async {
    try {
      final remoteUserBalanceHistory = await remoteDataSource.getUserBalanceHistory(body: body!);
      return Right(remoteUserBalanceHistory);
    } on ApiErrorsException catch (e) {
      return Left(
        AppFailure(
          errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage),
          failureType: FailureType.serverFailure,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, UserLoyaltyData>> getUserLoyaltyData() async {
    try {
      final remoteUserLoyaltyData = await remoteDataSource.getUserLoyaltyData();
      return Right(remoteUserLoyaltyData);
    } on ApiErrorsException catch (e) {
      return Left(
        AppFailure(
          errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage),
          failureType: FailureType.serverFailure,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, List<PointSchemaBrand>>> getTiersLoyaltyData({Map<String, dynamic>? body}) async {
    try {
      final remoteTiersLoyaltyDataByBusinessUnit = await remoteDataSource.getTiersLoyaltyData();
      return Right(remoteTiersLoyaltyDataByBusinessUnit);
    } on ApiErrorsException catch (e) {
      return Left(
        AppFailure(
          errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage),
          failureType: FailureType.serverFailure,
        ),
      );
    }
  }
}
