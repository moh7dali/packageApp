import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/verify_mobile_number.dart';
import '../repositories/auth_repository.dart';

class PostVerifyMobileNumber implements UseCase<VerifyMobileNumber, BodyParams> {
  final AuthRepositories repository;

  PostVerifyMobileNumber(this.repository);

  @override
  Future<Either<AppFailure, VerifyMobileNumber>> call(BodyParams params) async {
    return await repository.postVerifyMobileNumber(body: params.body);
  }
}
