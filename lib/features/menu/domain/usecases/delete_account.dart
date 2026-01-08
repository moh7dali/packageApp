import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/usecases/usecase.dart';

import '../../../../core/error/failures.dart';
import '../repositories/menu_repository.dart';

class DeleteAccount implements UseCase<dynamic, NoParams> {
  final MenuRepositories repository;

  DeleteAccount(this.repository);

  @override
  Future<Either<AppFailure, dynamic>> call(NoParams params) async {
    return await repository.deleteAccount();
  }
}
