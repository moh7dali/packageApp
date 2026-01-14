import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../entity/point_schema_brand.dart';
import '../repositories/loyalty_repository.dart';

class GetTiersLoyaltyData implements UseCase<List<PointSchemaBrand>, NoParams> {
  final LoyaltyRepository repository;

  GetTiersLoyaltyData(this.repository);

  @override
  Future<Either<AppFailure, List<PointSchemaBrand>>> call(NoParams params) async {
    return await repository.getTiersLoyaltyData();
  }
}
