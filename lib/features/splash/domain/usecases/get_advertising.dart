import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/core/error/failures.dart';
import 'package:my_custom_widget/core/usecases/usecase.dart';
import 'package:my_custom_widget/features/splash/domain/repositories/splash_repository.dart';

import '../entities/advertising_list.dart';

class GetAdvertising implements UseCase<AdvertisingList, BodyParams> {
  final SplashRepository repository;

  GetAdvertising(this.repository);

  @override
  Future<Either<AppFailure, AdvertisingList>> call(BodyParams params) async {
    return await repository.getAdvertising(queryParameters: params.body);
  }
}
