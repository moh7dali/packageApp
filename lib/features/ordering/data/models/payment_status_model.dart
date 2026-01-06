import '../../domain/entity/payment_status.dart';

class PaymentStatusModel extends PaymentStatus {
  const PaymentStatusModel({
    required super.paymentStatus,
    required super.orderId,
    required super.profileId,
    required super.paymentTransactionId,
    required super.paymentMethod,
    super.registrationId,
    super.errorMessage,
    super.errorCode,
    super.paymentToken,
  });

  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) {
    return PaymentStatusModel(
      paymentStatus: json['PaymentStatus'] ?? 0,
      orderId: json['OrderId'] ?? 0,
      profileId: json['ProfileId'] ?? 0,
      paymentTransactionId: json['PaymentTransactionId'] ?? 0,
      paymentMethod: json['PaymentMethod'] ?? 0,
      registrationId: json['RegistrationId'],
      errorMessage: json['ErrorMessage'],
      errorCode: json['ErrorCode'],
      paymentToken: json['PaymentToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PaymentStatus': paymentStatus,
      'OrderId': orderId,
      'ProfileId': profileId,
      'PaymentTransactionId': paymentTransactionId,
      'PaymentMethod': paymentMethod,
      'RegistrationId': registrationId,
      'ErrorMessage': errorMessage,
      'ErrorCode': errorCode,
      'PaymentToken': paymentToken,
    };
  }
}
