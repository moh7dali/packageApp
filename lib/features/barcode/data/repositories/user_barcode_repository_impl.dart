import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/features/barcode/data/datasources/user_barcode_api_datasource.dart';
import 'package:mozaic_loyalty_sdk/features/barcode/data/models/user_barcode_model.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/user_barcode_repository.dart';

class UserBarcodeRepositoryImpl implements UserBarcodeRepository {
  final UserBarCodeApiDataSource remoteDataSource;

  UserBarcodeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, UserBarcodeModel>> getUserBarcode() async {
    try {
      final userBarcode = await remoteDataSource.getUserBarcode();
      return Right(userBarcode);
    } on ApiErrorsException catch (e) {
      return Left(AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
    }
  }
}
