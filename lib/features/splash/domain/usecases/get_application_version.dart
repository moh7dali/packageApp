import 'package:my_custom_widget/core/error/failures.dart';
import 'package:my_custom_widget/core/usecases/usecase.dart';
import 'package:my_custom_widget/features/splash/domain/entities/application_version.dart';
import 'package:my_custom_widget/features/splash/domain/repositories/splash_repository.dart';
import 'package:dartz/dartz.dart';

class GetApplicationVersion implements UseCase<ApplicationVersion, String> {
  final SplashRepository repository;

  GetApplicationVersion(this.repository);

  @override
  Future<Either<AppFailure, ApplicationVersion>> call(String params) async {
    return await repository.getApplicationVersion(params);
  }
}
