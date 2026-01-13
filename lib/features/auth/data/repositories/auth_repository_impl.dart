import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/api/api_response_error.dart';
import 'package:my_custom_widget/features/auth/domain/entities/check_validation_code.dart';
import 'package:my_custom_widget/features/auth/domain/entities/verify_mobile_number.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/countries_list.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_api_datasource.dart';

class AuthRepositoryImpl implements AuthRepositories {
  final AuthApiDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, VerifyMobileNumber>> postVerifyMobileNumber({Map<String, dynamic>? body}) async {
    try {
      final remoteVerifyMobileNumber = await remoteDataSource.postVerifyMobileNumber(body: body!);
      return Right(remoteVerifyMobileNumber);
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
  Future<Either<AppFailure, CheckValidationCode>> postCheckValidationCode({Map<String, dynamic>? body}) async {
    try {
      final remoteCheckValidationCode = await remoteDataSource.postCheckValidationCode(body: body!);
      return Right(remoteCheckValidationCode);
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
  Future<Either<AppFailure, bool>> resendVerificationCode() async {
    try {
      final remoteResendVerificationCode = await remoteDataSource.resendVerificationCode();
      return Right(remoteResendVerificationCode);
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
  Future<Either<AppFailure, dynamic>> postCompleteProfile({Map<String, dynamic>? body}) async {
    try {
      final remoteCompleteProfile = await remoteDataSource.postCompleteProfile(body: body!);
      return Right(remoteCompleteProfile);
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
  Future<Either<AppFailure, CountriesList>> getCountries({Map<String, dynamic>? body}) async {
    try {
      final remoteGetCountry = await remoteDataSource.getCountries(body: body!);
      return Right(remoteGetCountry);
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
