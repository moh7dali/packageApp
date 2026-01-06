import 'package:my_custom_widget/features/category/data/datasources/category_api_datasource.dart';
import 'package:my_custom_widget/features/category/domain/entities/category.dart';
import 'package:my_custom_widget/features/category/domain/entities/filters.dart';
import 'package:my_custom_widget/features/category/domain/entities/product.dart';
import 'package:my_custom_widget/features/category/domain/entities/product_details.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryApiDataSource remoteDataSource;

  CategoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, CategoryList>> getBrandCategories({required Map<String, dynamic> body}) async {
    try {
      final brandCategoryList = await remoteDataSource.getBrandCategories(body: body);
      return Right(brandCategoryList);
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
  Future<Either<AppFailure, CategoryList>> getCategorySubCategories({Map<String, dynamic>? queryParameters}) async {
    try {
      final subCategoryList = await remoteDataSource.getCategorySubCategories(queryParameters: queryParameters);
      return Right(subCategoryList);
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
  Future<Either<AppFailure, ProductList>> getCategoryProducts({required Map<String, dynamic> body}) async {
    try {
      final productList = await remoteDataSource.getCategoryProducts(body: body);
      return Right(productList);
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
  Future<Either<AppFailure, ProductDetails>> getProductDetails({Map<String, dynamic>? queryParameters}) async {
    try {
      final productDetails = await remoteDataSource.getProductDetails(queryParameters: queryParameters);
      return Right(productDetails);
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
  Future<Either<AppFailure, FiltersList>> getCategoryFilters({Map<String, dynamic>? queryParameters}) async {
    try {
      final filtersList = await remoteDataSource.getCategoryFilters(queryParameters: queryParameters);
      return Right(filtersList);
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
