import 'package:equatable/equatable.dart';

class TopUpPurchaseResult extends Equatable {
  final int? orderId;
  final double? totalOrderAmount;
  final String? paymentToken;

  const TopUpPurchaseResult({this.orderId, this.totalOrderAmount, this.paymentToken});

  @override
  List<Object?> get props => [orderId, totalOrderAmount, paymentToken];
}
