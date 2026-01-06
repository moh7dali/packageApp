import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/error/failures.dart';
import 'package:my_custom_widget/features/loyalty/domain/entity/point_schema_brand_by_business_unit.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/loyalty_repository.dart';

class GetTiersLoyaltyDataByBusinessUnit implements UseCase<List<PointSchemaBrandByBusinessUnit>, NoParams> {
  final LoyaltyRepository repository;

  GetTiersLoyaltyDataByBusinessUnit(this.repository);

  @override
  Future<Either<AppFailure, List<PointSchemaBrandByBusinessUnit>>> call(NoParams params) async {
    return await repository.getTiersLoyaltyDataByBusinessUnit();
  }
}
