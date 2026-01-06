import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class RateRepositories {
  Future<Either<AppFailure, dynamic>> rateBranchVisit({Map<String, dynamic>? body});
}
