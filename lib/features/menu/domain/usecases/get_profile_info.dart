import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entity/profile_info.dart';
import '../repositories/menu_repository.dart';

class GetProfileInfo implements UseCase<ProfileInfo, NoParams> {
  final MenuRepositories repository;

  GetProfileInfo(this.repository);

  @override
  Future<Either<AppFailure, ProfileInfo>> call(NoParams params) async {
    return await repository.getProfileInfo();
  }
}
