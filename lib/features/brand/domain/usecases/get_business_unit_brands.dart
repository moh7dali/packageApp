import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/brand/domain/entities/brands_list.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/brand_repository.dart';

class GetBusinessUnitBrands implements UseCase<BrandDetailsList?, BodyParams> {
  final BrandRepository repository;

  GetBusinessUnitBrands(this.repository);

  @override
  Future<Either<AppFailure, BrandDetailsList?>> call(BodyParams params) async {
    return await repository.getBusinessUnitBrands(queryParameters: params.body);
  }
}
