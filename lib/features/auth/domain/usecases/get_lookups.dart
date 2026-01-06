import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/look_up.dart';
import '../repositories/auth_repository.dart';

class GetLookups implements UseCase<List<LookUp>, BodyParams> {
  final AuthRepositories repository;

  GetLookups(this.repository);

  @override
  Future<Either<AppFailure, List<LookUp>>> call(BodyParams params) async {
    return await repository.getLookUp();
  }
}
