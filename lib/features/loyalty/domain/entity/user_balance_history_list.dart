import 'package:equatable/equatable.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/domain/entity/user_balance_history.dart';

class UserBalanceHistoryList extends Equatable {
  final List<UserBalanceHistory>? userBalanceHistoryList;
  final int? totalNumberOfResult;

  const UserBalanceHistoryList({required this.userBalanceHistoryList, required this.totalNumberOfResult});

  @override
  List<Object?> get props => [userBalanceHistoryList, totalNumberOfResult];
}
