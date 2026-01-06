import 'package:dartz/dartz.dart';
import 'package:my_custom_widget/features/home/domain/entities/home_details.dart';

import '../../../../core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<AppFailure, HomeDetails>> getHomeDetails({Map<String, dynamic>? body});

  Future<Either<AppFailure, HomeDetails>> getCustomerHomeContents({Map<String, dynamic>? body});
}
