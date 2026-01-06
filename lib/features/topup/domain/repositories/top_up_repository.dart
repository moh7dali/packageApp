import 'package:my_custom_widget/features/topup/domain/entities/purchase.dart';
import 'package:my_custom_widget/features/topup/domain/entities/top_up_history.dart';
import 'package:my_custom_widget/features/topup/domain/entities/top_up_list.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class TopUpRepository {
  Future<Either<AppFailure, TopUpList>> getTopUp({required Map<String, dynamic> body});

  Future<Either<AppFailure, TopUpPurchaseResult>> purchaseTopUp({required Map<String, dynamic> body});

  Future<Either<AppFailure, TopUpHistoryList>> getCustomerWalletHistory({required Map<String, dynamic> body});
}
