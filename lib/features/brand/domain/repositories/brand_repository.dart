import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/brand/domain/entities/brand_details.dart';
import 'package:my_custom_widget/features/brand/domain/entities/brands_list.dart';

import '../../../../core/error/failures.dart';

abstract class BrandRepository {
  Future<Either<AppFailure, BrandDetailsList>> getAllBrands({Map<String, dynamic>? queryParameters});

  Future<Either<AppFailure, BrandDetails?>> getBrandDetails({Map<String, dynamic>? queryParameters});

  Future<Either<AppFailure, BrandDetailsList?>> getBusinessUnitBrands({Map<String, dynamic>? queryParameters});
}
