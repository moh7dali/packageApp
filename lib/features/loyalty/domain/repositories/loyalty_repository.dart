import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entity/point_schema_brand.dart';
import '../entity/user_balance_history_list.dart';
import '../entity/user_loyalty_data.dart';

abstract class LoyaltyRepository {
  Future<Either<AppFailure, UserBalanceHistoryList>> getUserBalanceHistory({Map<String, dynamic>? body});

  Future<Either<AppFailure, UserLoyaltyData?>> getUserLoyaltyData();

  Future<Either<AppFailure, List<PointSchemaBrand>>> getTiersLoyaltyData();
}
