import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/closest_branches.dart';
import '../repositories/branch_repository.dart';

class GetClosestBranches implements UseCase<ClosestBranches?, BodyParams> {
  final BranchRepository repository;

  GetClosestBranches(this.repository);

  @override
  Future<Either<AppFailure, ClosestBranches?>> call(BodyParams params) async {
    return await repository.getClosestBranches(body: params.body);
  }
}
