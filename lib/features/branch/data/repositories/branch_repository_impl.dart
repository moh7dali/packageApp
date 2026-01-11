import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/utils/app_log.dart';
import 'package:my_custom_widget/features/branch/data/datasources/branch_api_datasource.dart';
import 'package:my_custom_widget/features/branch/domain/entities/branch_details.dart';
import 'package:my_custom_widget/features/branch/domain/entities/closest_branches.dart';
import 'package:my_custom_widget/features/branch/domain/repositories/branch_repository.dart';

import '../../../../core/api/api_response_error.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class BranchRepositoryImpl implements BranchRepository {
  final BranchApiDataSource remoteDataSource;

  BranchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppFailure, BranchDetails?>> getBranchDetails({Map<String, dynamic>? queryParameters}) async {
    try {
      final branchDetails = await remoteDataSource.getBranchDetails(queryParameters: queryParameters);
      return Right(branchDetails);
    } on ApiErrorsException catch (e) {
      return Left(
        AppFailure(
          errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage ?? 'somethingWrong'.tr),
          failureType: FailureType.serverFailure,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, ClosestBranches?>> getClosestBranches({Map<String, dynamic>? body}) async {
    try {
      final closestBranch = await remoteDataSource.getClosestBranches(body: body!);
      return Right(closestBranch);
    } on ApiErrorsException catch (e) {
      return Left(
        AppFailure(
          errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage ?? 'somethingWrong'.tr),
          failureType: FailureType.serverFailure,
        ),
      );
    }
  }

  @override
  Future<Either<AppFailure, dynamic>> checkInCustomer({Map<String, dynamic>? queryParameters}) async {
    try {
      final checkInUser = await remoteDataSource.checkInCustomer(queryParameters: queryParameters);
      return Right(checkInUser);
    } on ApiErrorsException catch (e) {
      appLog(e.errorCode, tag: "AAAAAA");
      return Left(
        AppFailure(
          errorsModel: ErrorsModel(errorCode: e.errorCode, errorMessage: e.errorMessage ?? 'somethingWrong'.tr),
          failureType: FailureType.serverFailure,
        ),
      );
    }
  }
}
