import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class PostCompleteProfile implements UseCase<dynamic, BodyParams> {
  final AuthRepositories repository;

  PostCompleteProfile(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(BodyParams params) async {
    return await repository.postCompleteProfile(body: params.body);
  }
}
