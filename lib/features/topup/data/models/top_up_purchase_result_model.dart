import 'package:my_custom_widget/features/topup/domain/entities/purchase.dart';

class TopUpPurchaseResultModel extends TopUpPurchaseResult {
  const TopUpPurchaseResultModel({super.orderId, super.totalOrderAmount, super.paymentToken});

  factory TopUpPurchaseResultModel.fromJson(Map<String, dynamic> json) {
    return TopUpPurchaseResultModel(
      orderId: json['OrderId'] is int ? json['OrderId'] as int : (json['OrderId'] as num?)?.toInt(),
      totalOrderAmount: (json['TotalOrderAmount'] as num?)?.toDouble(),
      paymentToken: json['PaymentToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'OrderId': orderId, 'TotalOrderAmount': totalOrderAmount, 'PaymentToken': paymentToken};
  }
}
