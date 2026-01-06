import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class AddReferral implements UseCase<dynamic, BodyParams> {
  final AuthRepositories repository;

  AddReferral(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(BodyParams params) async {
    return await repository.addReferral();
  }
}
