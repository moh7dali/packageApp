import 'package:my_custom_widget/core/error/failures.dart';
import 'package:my_custom_widget/features/splash/domain/entities/application_version.dart';
import 'package:dartz/dartz.dart';

import '../entities/advertising_list.dart';

abstract class SplashRepository {
  Future<Either<AppFailure, ApplicationVersion>> getApplicationVersion(String? buildNumber);

  Future<Either<AppFailure, AdvertisingList>> getAdvertising({required Map<String, dynamic> queryParameters});
}
