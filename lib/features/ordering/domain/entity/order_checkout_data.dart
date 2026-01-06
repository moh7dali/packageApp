import 'package:equatable/equatable.dart';

class PaymentType extends Equatable {
  final int? id;
  final String? name;

  const PaymentType({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}

class ConditionalRule extends Equatable {
  final int? id;
  final double? fromValue;
  final double? toValue;
  final int? discountTypeId;
  final double? discountValue;

  const ConditionalRule({
    this.id,
    this.fromValue,
    this.toValue,
    this.discountTypeId,
    this.discountValue,
  });

  @override
  List<Object?> get props => [id, fromValue, toValue, discountTypeId, discountValue];
}

class Discount extends Equatable {
  final int? id;
  final String? description;
  final double? minimumOrderAmount;
  final int? method;
  final int? type;
  final double? value;
  final List<ConditionalRule>? conditionalRules;

  const Discount({
    this.id,
    this.description,
    this.minimumOrderAmount,
    this.method,
    this.type,
    this.value,
    this.conditionalRules,
  });

  @override
  List<Object?> get props => [id, description, minimumOrderAmount, method, type, value, conditionalRules];
}

class DeliveryDetails extends Equatable {
  final double? fees;
  final double? creditCardFees;
  final List<Discount>? discounts;

  const DeliveryDetails({this.fees, this.discounts, this.creditCardFees});

  @override
  List<Object?> get props => [fees, discounts];
}

class OrderCheckoutData extends Equatable {
  final double? tax;
  final bool? allowMultipleDiscount;
  final List<Discount>? discounts;
  final DeliveryDetails? deliveryDetails;
  final List<PaymentType>? availablePaymentTypes;
  final OrderingStatus? orderingStatus;
  final CustomerInfo? customerInfo;

  const OrderCheckoutData(
      {this.tax,
      this.allowMultipleDiscount,
      this.discounts,
      this.deliveryDetails,
      this.availablePaymentTypes,
      this.orderingStatus,
      this.customerInfo});

  @override
  List<Object?> get props => [tax, allowMultipleDiscount, discounts, deliveryDetails, availablePaymentTypes, customerInfo];
}

class OrderingStatus extends Equatable {
  final bool? isOrderingEnabled;
  final String? disabledReason;

  const OrderingStatus({this.disabledReason, this.isOrderingEnabled});

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoyaltyData extends Equatable {
  final int? pointsBalance;
  final double? cashBalance;
  final int? currentTier;
  final int? nextTier;
  final double? wallet;

  const LoyaltyData({this.pointsBalance, this.cashBalance, this.currentTier, this.nextTier,this.wallet});

  @override
  List<Object?> get props => [pointsBalance, cashBalance, currentTier, nextTier];
}

class CustomerInfo extends Equatable {
  final LoyaltyData? loyaltyData;

  const CustomerInfo({this.loyaltyData});

  @override
  List<Object?> get props => [loyaltyData];
}
