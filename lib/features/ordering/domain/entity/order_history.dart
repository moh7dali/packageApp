import 'package:equatable/equatable.dart';

class OrderHistory extends Equatable {
  final int? id;
  final DateTime? creationDate;
  final int? orderStatus;
  final bool? isRated;
  final DateTime? deliveryDate;
  final int? deliveryMethodId;
  final bool? isScheduled;
  final String? brandImage;
  final String? brandName;
  final double? totalAmount;
  final String? currencyCode;

  const OrderHistory({
    this.id,
    this.creationDate,
    this.orderStatus,
    this.isRated,
    this.deliveryDate,
    this.deliveryMethodId,
    this.isScheduled,
    this.brandImage,
    this.brandName,
    this.totalAmount,
    this.currencyCode,
  });

  @override
  List<Object?> get props => [
        id,
        creationDate,
        orderStatus,
        isRated,
        deliveryDate,
        deliveryMethodId,
        isScheduled,
        brandImage,
        brandName,
        totalAmount,
        currencyCode,
      ];
}

class OrderHistoryList extends Equatable {
  final int? totalNumberOfResult;
  final List<OrderHistory>? list;

  const OrderHistoryList({
    this.totalNumberOfResult,
    this.list,
  });

  @override
  List<Object?> get props => [totalNumberOfResult, list];
}
