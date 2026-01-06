import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/brand/domain/entities/brand_details.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/brand_repository.dart';

class GetBrandDetails implements UseCase<BrandDetails?, BodyParams> {
  final BrandRepository repository;

  GetBrandDetails(this.repository);

  @override
  Future<Either<AppFailure, BrandDetails?>> call(BodyParams params) async {
    return await repository.getBrandDetails(queryParameters: params.body);
  }
}
