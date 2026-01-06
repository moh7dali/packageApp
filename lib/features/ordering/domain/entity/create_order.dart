import 'package:equatable/equatable.dart';


class CreateOrder extends Equatable {
  final PaymentInfo? paymentInfo;
  final int? orderId;
  final double? totalOrderAmount;
  final List<UnavailableItems>? unavailableItems;

  const CreateOrder({this.paymentInfo, this.orderId, this.totalOrderAmount, this.unavailableItems});

  @override
  List<Object?> get props => [paymentInfo, orderId, totalOrderAmount,unavailableItems];
}

class PaymentInfo extends Equatable {
  final String? paymentToken;
  final String? webPaymentUrl;
  final String? customerEmail;
  final CustomerPaymentCardInfo? customerPaymentCardsInfo;

  const PaymentInfo({
    this.paymentToken,
    this.webPaymentUrl,
    this.customerEmail,
    this.customerPaymentCardsInfo,
  });

  @override
  List<Object?> get props => [paymentToken, webPaymentUrl, customerEmail, customerPaymentCardsInfo];
}

class CustomerPaymentCardInfo extends Equatable {
  final String? cardNumber;
  final String? cardReferenceId;
  final String? imageUrl;

  const CustomerPaymentCardInfo({
    this.cardNumber,
    this.cardReferenceId,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [cardNumber, cardReferenceId, imageUrl];
}

class UnavailableItems extends Equatable {
  final int? id;
  final String? name;
  final List<UnavailableModifierOption>? unavailableModifierOption;

  const UnavailableItems({this.id, this.name, this.unavailableModifierOption});

  @override
  List<Object?> get props => [id, name, unavailableModifierOption];
}

class UnavailableModifierOption extends Equatable {
  final String? name;
  final int? id;

  const UnavailableModifierOption({
    this.name,
    this.id,
  });

  @override
  List<Object?> get props => [name, id];
}
