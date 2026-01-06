import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/rate_repository.dart';

class RateBranchVisit implements UseCase<dynamic, BodyParams> {
  final RateRepositories repository;

  RateBranchVisit(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(BodyParams params) async {
    return await repository.rateBranchVisit(body: params.body);
  }
}
