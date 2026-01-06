import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/countries_list.dart';
import '../repositories/auth_repository.dart';

class GetCountries implements UseCase<CountriesList, BodyParams> {
  final AuthRepositories repository;

  GetCountries(this.repository);

  @override
  Future<Either<AppFailure, CountriesList>> call(BodyParams params) async {
    return await repository.getCountries();
  }
}
