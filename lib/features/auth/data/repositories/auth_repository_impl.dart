import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/api/api_response_error.dart';
import 'package:my_custom_widget/features/auth/domain/entities/area.dart';
import 'package:my_custom_widget/features/auth/domain/entities/check_validation_code.dart';
import 'package:my_custom_widget/features/auth/domain/entities/city.dart';
import 'package:my_custom_widget/features/auth/domain/entities/verify_mobile_number.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/countries_list.dart';
import '../../domain/entities/look_up.dart';
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
  Future<Either<AppFailure, List<City>>> getCities({Map<String, dynamic>? body}) async {
    try {
      final remoteGetCity = await remoteDataSource.getCities(body: body!);
      return Right(remoteGetCity);
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
  Future<Either<AppFailure, List<Area>>> getArea({Map<String, dynamic>? body}) async {
    try {
      final remoteGetArea = await remoteDataSource.getArea(body: body!);
      return Right(remoteGetArea);
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
  Future<Either<AppFailure, dynamic>> addReferral({Map<String, dynamic>? body}) async {
    try {
      final remoteAddReferral = await remoteDataSource.addReferral(body: body!);
      return Right(remoteAddReferral);
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

  @override
  Future<Either<AppFailure, List<LookUp>>> getLookUp({Map<String, dynamic>? body}) async {
    try {
      final remoteGetCity = await remoteDataSource.getLookUps(body: body!);
      return Right(remoteGetCity);
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
