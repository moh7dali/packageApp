import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/brand/data/datasources/brand_api_datasource.dart';
import 'package:my_custom_widget/features/brand/domain/entities/brand_details.dart';
import 'package:my_custom_widget/features/brand/domain/entities/brands_list.dart';
import 'package:my_custom_widget/features/brand/domain/repositories/brand_repository.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class BrandRepositoryImpl implements BrandRepository {
  final BrandApiDataSource remoteDataSource;

  

  BrandRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, BrandDetailsList>> getAllBrands({Map<String, dynamic>? queryParameters}) async {
   
      try {
        final brandDetailsList = await remoteDataSource.getAllBrands(queryParameters: queryParameters);
        return Right(brandDetailsList);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }

  @override
  Future<Either<AppFailure, BrandDetails?>> getBrandDetails({Map<String, dynamic>? queryParameters}) async {
   
      try {
        final brandDetails = await remoteDataSource.getBrandDetails(queryParameters: queryParameters);
        return Right(brandDetails);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }

  @override
  Future<Either<AppFailure, BrandDetailsList?>> getBusinessUnitBrands({Map<String, dynamic>? queryParameters}) async {
   
      try {
        final brandDetailsList = await remoteDataSource.getBusinessUnitBrands(queryParameters: queryParameters);
        return Right(brandDetailsList);
      } on ApiErrorsException catch (e) {
        return Left(
            AppFailure(errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage), failureType: FailureType.serverFailure));
      }
    
  }
}
