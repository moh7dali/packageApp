import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/home/domain/entities/home_details.dart';
import 'package:my_custom_widget/features/home/domain/repositories/home_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetHomeDetails implements UseCase<HomeDetails, BodyParams> {
  final HomeRepository repository;

  GetHomeDetails(this.repository);

  @override
  Future<Either<AppFailure, HomeDetails>> call(BodyParams params) async {
    return await repository.getHomeDetails();
  }
}
