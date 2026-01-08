import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/auth/domain/entities/area.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class GetArea implements UseCase<List<Area>, BodyParams> {
  final AuthRepositories repository;

  GetArea(this.repository);

  @override
  Future<Either<AppFailure, List<Area>>> call(BodyParams params) async {
    return await repository.getArea();
  }
}
