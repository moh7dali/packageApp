import '../../domain/entities/top_up_history.dart';

class TopUpHistoryModel extends TopUpHistory {
  const TopUpHistoryModel({super.id, super.profileId, super.purchaseAmount, super.transactionId, super.transactionTypeName, super.transactionType,super.creationDate});

  factory TopUpHistoryModel.fromJson(Map<String, dynamic> json) {
    return TopUpHistoryModel(
      id: json['Id'],
      profileId: json['ProfileId'],
      purchaseAmount: (json['PurchaseAmount'] as num?)?.toDouble(),
      transactionId: json['TransactionId'],
      transactionTypeName: json['TransactionTypeName'],
      transactionType: json['TransactionType'],
      creationDate: json["CreationDate"] == null ? null : DateTime.parse(json["CreationDate"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'ProfileId': profileId,
      'PurchaseAmount': purchaseAmount,
      'TransactionId': transactionId,
      'TransactionTypeName': transactionTypeName,
      'TransactionType': transactionType,
      'CreationDate': creationDate,
    };
  }
}

class TopUpHistoryListModel extends TopUpHistoryList {
  const TopUpHistoryListModel({super.customerWalletHistoryModelList, super.totalNumberofResult});

  factory TopUpHistoryListModel.fromJson(Map<String, dynamic> json) {
    return TopUpHistoryListModel(
      totalNumberofResult: json['TotalNumberofResult'],
      customerWalletHistoryModelList: json['CustomerWalletHistoryModelList'] == null
          ? []
          : List<TopUpHistory>.from(
              (json['CustomerWalletHistoryModelList'] as List).map((e) => TopUpHistoryModel.fromJson(e as Map<String, dynamic>)),
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'TotalNumberofResult': totalNumberofResult, 'CustomerWalletHistoryModelList': customerWalletHistoryModelList};
  }
}
