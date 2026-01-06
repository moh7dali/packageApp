import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class ResendVerificationCode implements UseCase<bool, BodyParams> {
  final AuthRepositories repository;

  ResendVerificationCode(this.repository);

  @override
  Future<Either<AppFailure, bool>> call(BodyParams params) async {
    return await repository.resendVerificationCode();
  }
}
