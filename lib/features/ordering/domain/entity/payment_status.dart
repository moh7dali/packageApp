import 'package:equatable/equatable.dart';

class PaymentStatus extends Equatable {
  final int paymentStatus;
  final int orderId;
  final int profileId;
  final int paymentTransactionId;
  final int paymentMethod;
  final String? registrationId;
  final String? errorMessage;
  final String? errorCode;
  final String? paymentToken;

  const PaymentStatus({
    required this.paymentStatus,
    required this.orderId,
    required this.profileId,
    required this.paymentTransactionId,
    required this.paymentMethod,
    this.registrationId,
    this.errorMessage,
    this.errorCode,
    this.paymentToken,
  });

  @override
  List<Object?> get props => [
    paymentStatus,
    orderId,
    profileId,
    paymentTransactionId,
    paymentMethod,
    registrationId,
    errorMessage,
    errorCode,
    paymentToken,
  ];
}
