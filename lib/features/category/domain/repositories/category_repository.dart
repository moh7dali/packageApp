import 'package:my_custom_widget/features/category/domain/entities/product.dart';
import 'package:my_custom_widget/features/category/domain/entities/product_details.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/category.dart';
import '../entities/filters.dart';

abstract class CategoryRepository {
  Future<Either<AppFailure, CategoryList>> getBrandCategories({required Map<String, dynamic> body});

  Future<Either<AppFailure, CategoryList>> getCategorySubCategories({Map<String, dynamic>? queryParameters});

  Future<Either<AppFailure, ProductList>> getCategoryProducts({required Map<String, dynamic> body});

  Future<Either<AppFailure, ProductDetails>> getProductDetails({Map<String, dynamic>? queryParameters});

  Future<Either<AppFailure, FiltersList>> getCategoryFilters({Map<String, dynamic>? queryParameters});
}
