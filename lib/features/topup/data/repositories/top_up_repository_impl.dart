import 'package:my_custom_widget/features/topup/domain/entities/purchase.dart';
import 'package:my_custom_widget/features/topup/domain/entities/top_up_history.dart';
import 'package:my_custom_widget/features/topup/domain/entities/top_up_list.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/top_up_repository.dart';
import '../datasources/top_up_datasource.dart';

class TopUpRepositoryImpl implements TopUpRepository {
  final TopUpApiDataSource remoteDataSource;

  TopUpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, TopUpList>> getTopUp({required Map<String, dynamic> body}) async {
    try {
      final topUpList = await remoteDataSource.getTopUp(body: body);
      return Right(topUpList);
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
  Future<Either<AppFailure, TopUpPurchaseResult>> purchaseTopUp({required Map<String, dynamic> body}) async {
    try {
      final purchase = await remoteDataSource.purchase(body: body);
      return Right(purchase);
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
  Future<Either<AppFailure, TopUpHistoryList>> getCustomerWalletHistory({required Map<String, dynamic> body}) async {
    try {
      final history = await remoteDataSource.getCustomerWalletHistory(body: body);
      return Right(history);
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
