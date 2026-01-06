import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/branch/domain/entities/branches_list.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/branch_repository.dart';

class GetAllBranches implements UseCase<BranchDetailsList?, BodyParams> {
  final BranchRepository repository;

  GetAllBranches(this.repository);

  @override
  Future<Either<AppFailure, BranchDetailsList?>> call(BodyParams params) async {
    return await repository.getAllBranches(body: params.body);
  }
}
