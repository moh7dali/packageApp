import 'package:dartz/dartz.dart';
import 'package:mozaic_loyalty_sdk/features/branch/domain/entities/branch_details.dart';

import '../../../../core/error/failures.dart';
import '../entities/closest_branches.dart';

abstract class BranchRepository {
  Future<Either<AppFailure, BranchDetails?>> getBranchDetails({Map<String, dynamic>? queryParameters});

  Future<Either<AppFailure, ClosestBranches?>> getClosestBranches({Map<String, dynamic>? body});

  Future<Either<AppFailure, dynamic>> checkInCustomer({Map<String, dynamic>? queryParameters});
}
