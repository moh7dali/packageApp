import 'package:mozaic_loyalty_sdk/features/loyalty/data/models/user_balance_history_model.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/domain/entity/user_balance_history_list.dart';

import '../../domain/entity/user_balance_history.dart';

class UserBalanceHistoryListModel extends UserBalanceHistoryList {
  const UserBalanceHistoryListModel({required super.userBalanceHistoryList, required super.totalNumberOfResult});

  factory UserBalanceHistoryListModel.fromJson(Map<String, dynamic> json) => UserBalanceHistoryListModel(
      userBalanceHistoryList: json["UserBalanceHistoryList"] == null
          ? []
          : List<UserBalanceHistory>.from(json["UserBalanceHistoryList"]!.map((x) => UserBalanceHistoryModel.fromJson(x))),
      totalNumberOfResult: json['TotalNumberofResult']);

  Map<String, dynamic> toMap() => {"UserBalanceHistoryList": userBalanceHistoryList, "TotalNumberofResult": totalNumberOfResult};
}
