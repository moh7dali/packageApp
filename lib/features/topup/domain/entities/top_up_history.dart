import 'package:equatable/equatable.dart';

class TopUpHistory extends Equatable {
  final int? id;
  final int? profileId;
  final double? purchaseAmount;
  final int? transactionId;
  final String? transactionTypeName;
  final int? transactionType;
  final DateTime? creationDate;

  const TopUpHistory({
    this.id,
    this.purchaseAmount,
    this.transactionId,
    this.transactionTypeName,
    this.profileId,
    this.transactionType,
    this.creationDate,
  });

  @override
  List<Object?> get props => [id, profileId, purchaseAmount, transactionId, transactionTypeName, transactionType];
}

class TopUpHistoryList extends Equatable {
  final int? totalNumberofResult;
  final List<TopUpHistory>? customerWalletHistoryModelList;

  const TopUpHistoryList({this.customerWalletHistoryModelList, this.totalNumberofResult});

  @override
  List<Object?> get props => [customerWalletHistoryModelList, totalNumberofResult];
}
