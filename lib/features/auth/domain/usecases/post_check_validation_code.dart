import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/features/auth/domain/entities/check_validation_code.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class PostCheckValidationCode implements UseCase<CheckValidationCode, BodyParams> {
  final AuthRepositories repository;

  PostCheckValidationCode(this.repository);

  @override
  Future<Either<AppFailure, CheckValidationCode>> call(BodyParams params) async {
    return await repository.postCheckValidationCode(body: params.body);
  }
}
