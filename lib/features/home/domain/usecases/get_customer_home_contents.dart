import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/home_details.dart';
import '../repositories/home_repository.dart';

class GetCustomerHomeContents implements UseCase<HomeDetails, BodyParams> {
  final HomeRepository repository;

  GetCustomerHomeContents(this.repository);

  @override
  Future<Either<AppFailure, HomeDetails>> call(BodyParams params) async {
    return await repository.getCustomerHomeContents(body: params.body);
  }
}
