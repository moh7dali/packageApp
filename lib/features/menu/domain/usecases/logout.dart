import 'package:my_custom_widget/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/menu_repository.dart';

class Logout implements UseCase<dynamic, NoParams> {
  final MenuRepositories repository;

  Logout(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(NoParams params) async {
    return await repository.logOut();
  }
}
