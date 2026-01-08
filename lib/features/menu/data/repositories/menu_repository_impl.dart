import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/error/failures.dart';
import 'package:my_custom_widget/features/menu/domain/entity/invite_friend.dart';
import 'package:my_custom_widget/features/menu/domain/entity/merchant_info.dart';
import 'package:my_custom_widget/features/menu/domain/entity/profile_info.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/menu_repository.dart';
import '../datasources/menu_api_datasource.dart';

class MenuRepositoryImpl implements MenuRepositories {
  final MenuApiDataSource remoteDataSource;
  

  const MenuRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, ProfileInfo>> getProfileInfo() async {
   
      try {
        final remoteProfileInfo = await remoteDataSource.getProfileInfo();
        return Right(remoteProfileInfo);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }

  @override
  Future<Either<AppFailure, InviteFriends>> getSystemResource({Map<String, dynamic>? body}) async {
   
      try {
        final remoteSystemResource = await remoteDataSource.getSystemResource(body: body!);
        return Right(remoteSystemResource);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }

  @override
  Future<Either<AppFailure, MerchantInfo>> getMerchantContactInfo({Map<String, dynamic>? body}) async {
   
      try {
        final remoteMerchantContactInfo = await remoteDataSource.getMerchantContactInfo(body: body!);
        return Right(remoteMerchantContactInfo);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }

  @override
  Future<Either<AppFailure, dynamic>> deleteAccount() async {
   
      try {
        final remoteDeleteAccount = await remoteDataSource.deleteAccount();
        return Right(remoteDeleteAccount);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }

  @override
  Future<Either<AppFailure, dynamic>> logOut() async {
   
      try {
        final remoteDeleteAccount = await remoteDataSource.logOut();
        return Right(remoteDeleteAccount);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }
}
