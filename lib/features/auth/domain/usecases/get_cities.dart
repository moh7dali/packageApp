import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/city.dart';
import '../repositories/auth_repository.dart';

class GetCities implements UseCase<List<City>, BodyParams> {
  final AuthRepositories repository;

  GetCities(this.repository);

  @override
  Future<Either<AppFailure, List<City>>> call(BodyParams params) async {
    return await repository.getCities();
  }
}
