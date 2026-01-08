import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/branch/domain/entities/branch_details.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/branch_repository.dart';

class GetClosestBranch implements UseCase<BranchDetails?, BodyParams> {
  final BranchRepository repository;

  GetClosestBranch(this.repository);

  @override
  Future<Either<AppFailure, BranchDetails?>> call(BodyParams params) async {
    return await repository.getClosestBranch(body: params.body);
  }
}
