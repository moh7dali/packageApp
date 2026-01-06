import '../../domain/entity/order_history.dart';

class OrderHistoryModel extends OrderHistory {
  const OrderHistoryModel({
    super.id,
    super.creationDate,
    super.orderStatus,
    super.isRated,
    super.deliveryDate,
    super.deliveryMethodId,
    super.isScheduled,
    super.brandImage,
    super.brandName,
    super.totalAmount,
    super.currencyCode,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['Id'] as int?,
      creationDate: json['CreationDate'] != null ? DateTime.tryParse(json['LocalCreationDate']) : null,
      orderStatus: json['OrderStatus'] as int?,
      isRated: json['IsRated'] as bool?,
      deliveryDate: json['DeliveryDate'] != null ? DateTime.tryParse(json['DeliveryDate']) : null,
      deliveryMethodId: json['DeliveryMethodId'] as int?,
      isScheduled: json['IsScheduled'] as bool?,
      brandImage: json['BrandImage'] as String?,
      brandName: json['BrandName'] as String?,
      totalAmount: (json['TotalAmount'] as num?)?.toDouble(),
      currencyCode: json['CurrencyCode'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'LocalCreationDate': creationDate?.toIso8601String(),
      'OrderStatus': orderStatus,
      'IsRated': isRated,
      'DeliveryDate': deliveryDate?.toIso8601String(),
      'DeliveryMethodId': deliveryMethodId,
      'IsScheduled': isScheduled,
      'BrandImage': brandImage,
      'BrandName': brandName,
      'TotalAmount': totalAmount,
      'CurrencyCode': currencyCode,
    };
  }
}

class OrderHistoryListModel extends OrderHistoryList {
  const OrderHistoryListModel({super.totalNumberOfResult, super.list});

  factory OrderHistoryListModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryListModel(
      totalNumberOfResult: json['TotalNumberOfResult'] as int?,
      list: (json['List'] as List<dynamic>?)?.map((item) => OrderHistoryModel.fromJson(item as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'TotalNumberOfResult': totalNumberOfResult, 'List': list?.map((item) => (item as OrderHistoryModel).toJson()).toList()};
  }
}
