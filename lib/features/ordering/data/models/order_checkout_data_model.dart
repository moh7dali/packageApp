import '../../domain/entity/order_checkout_data.dart';

class PaymentTypeModel extends PaymentType {
  const PaymentTypeModel({super.id, super.name});

  factory PaymentTypeModel.fromJson(Map<String, dynamic> json) => PaymentTypeModel(id: json['Id'], name: json['Name']);

  Map<String, dynamic> toJson() => {'Id': id, 'Name': name};

  factory PaymentTypeModel.fromEntity(PaymentType e) => PaymentTypeModel(id: e.id, name: e.name);
}

class ConditionalRuleModel extends ConditionalRule {
  const ConditionalRuleModel({super.id, super.fromValue, super.toValue, super.discountTypeId, super.discountValue});

  factory ConditionalRuleModel.fromJson(Map<String, dynamic> json) => ConditionalRuleModel(
    id: json['Id'],
    fromValue: json['FromValue'],
    toValue: json['ToValue'],
    discountTypeId: json['DiscountTypeId'],
    discountValue: json['DiscountValue'],
  );

  Map<String, dynamic> toJson() => {
    'Id': id,
    'FromValue': fromValue,
    'ToValue': toValue,
    'DiscountTypeId': discountTypeId,
    'DiscountValue': discountValue,
  };

  factory ConditionalRuleModel.fromEntity(ConditionalRule e) =>
      ConditionalRuleModel(id: e.id, fromValue: e.fromValue, toValue: e.toValue, discountTypeId: e.discountTypeId, discountValue: e.discountValue);
}

class DiscountModel extends Discount {
  const DiscountModel({super.id, super.description, super.minimumOrderAmount, super.method, super.type, super.value, super.conditionalRules});

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
    id: json['Id'],
    description: json['Description'],
    minimumOrderAmount: json['MinimumOrderAmount'],
    method: json['Method'],
    type: json['Type'],
    value: json['Value'],
    conditionalRules: json['ConditionalRules'] == null
        ? []
        : List<ConditionalRule>.from(json['ConditionalRules'].map((x) => ConditionalRuleModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'Id': id,
    'Description': description,
    'MinimumOrderAmount': minimumOrderAmount,
    'Method': method,
    'Type': type,
    'Value': value,
    'ConditionalRules': conditionalRules?.map((e) => ConditionalRuleModel.fromEntity(e).toJson()).toList(),
  };

  factory DiscountModel.fromEntity(Discount e) => DiscountModel(
    id: e.id,
    description: e.description,
    minimumOrderAmount: e.minimumOrderAmount,
    method: e.method,
    type: e.type,
    value: e.value,
    conditionalRules: e.conditionalRules,
  );
}

class DeliveryDetailsModel extends DeliveryDetails {
  const DeliveryDetailsModel({super.fees, super.creditCardFees, super.discounts});

  factory DeliveryDetailsModel.fromJson(Map<String, dynamic> json) => DeliveryDetailsModel(
    creditCardFees: json['CreditCardFees'] != null ? (json['CreditCardFees'] as num).toDouble() : null,
    fees: json['Fees'] != null ? (json['Fees'] as num).toDouble() : null,
    discounts: json['Discounts'] == null ? [] : List<Discount>.from(json['Discounts'].map((x) => DiscountModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'Fees': fees,
    'CreditCardFees': creditCardFees,
    'Discounts': discounts?.map((e) => DiscountModel.fromEntity(e).toJson()).toList(),
  };

  factory DeliveryDetailsModel.fromEntity(DeliveryDetails e) =>
      DeliveryDetailsModel(fees: e.fees, creditCardFees: e.creditCardFees, discounts: e.discounts);
}

class OrderCheckoutDataModel extends OrderCheckoutData {
  const OrderCheckoutDataModel({
    super.tax,
    super.allowMultipleDiscount,
    super.discounts,
    super.deliveryDetails,
    super.availablePaymentTypes,
    super.orderingStatus,
    super.customerInfo,
  });

  factory OrderCheckoutDataModel.fromJson(Map<String, dynamic> json) => OrderCheckoutDataModel(
    tax: json['Tax'] != null ? (json['Tax'] as num).toDouble() : null,
    allowMultipleDiscount: json['AllowMultipleDiscount'],
    discounts: json['Discounts'] == null ? [] : List<Discount>.from(json['Discounts'].map((x) => DiscountModel.fromJson(x))),
    deliveryDetails: json['DeliveryDetails'] != null ? DeliveryDetailsModel.fromJson(json['DeliveryDetails']) : null,
    availablePaymentTypes: json['AvailablePaymentTypes'] == null
        ? []
        : List<PaymentType>.from(json['AvailablePaymentTypes'].map((x) => PaymentTypeModel.fromJson(x))),
    orderingStatus: json['OrderingStatus'] != null ? OrderingStatusModel.fromJson(json['OrderingStatus']) : null,
    customerInfo: json['CustomerInfo'] != null ? CustomerInfoModel.fromJson(json['CustomerInfo']) : null,
  );

  Map<String, dynamic> toJson() => {
    'Tax': tax,
    'AllowMultipleDiscount': allowMultipleDiscount,
    'Discounts': discounts?.map((e) => DiscountModel.fromEntity(e).toJson()).toList(),
    'DeliveryDetails': deliveryDetails != null ? DeliveryDetailsModel.fromEntity(deliveryDetails!).toJson() : null,
    'OrderingStatus': orderingStatus != null ? OrderingStatusModel.fromEntity(orderingStatus!).toJson() : null,
    'AvailablePaymentTypes': availablePaymentTypes?.map((e) => PaymentTypeModel.fromEntity(e).toJson()).toList(),
    'CustomerInfo': customerInfo != null ? CustomerInfoModel.fromEntity(customerInfo!).toJson() : null,
  };

  factory OrderCheckoutDataModel.fromEntity(OrderCheckoutData e) => OrderCheckoutDataModel(
    tax: e.tax,
    allowMultipleDiscount: e.allowMultipleDiscount,
    discounts: e.discounts,
    deliveryDetails: e.deliveryDetails,
    orderingStatus: e.orderingStatus,
    availablePaymentTypes: e.availablePaymentTypes,
  );
}

class OrderingStatusModel extends OrderingStatus {
  const OrderingStatusModel({super.disabledReason, super.isOrderingEnabled});

  factory OrderingStatusModel.fromJson(Map<String, dynamic> json) =>
      OrderingStatusModel(isOrderingEnabled: json['IsOrderingEnabled'], disabledReason: json['DisabledReason']);

  Map<String, dynamic> toJson() => {};

  factory OrderingStatusModel.fromEntity(OrderingStatus e) =>
      OrderingStatusModel(disabledReason: e.disabledReason, isOrderingEnabled: e.isOrderingEnabled);
}

class LoyaltyDataModel extends LoyaltyData {
  const LoyaltyDataModel({super.pointsBalance, super.cashBalance, super.currentTier, super.nextTier, super.wallet});

  factory LoyaltyDataModel.fromJson(Map<String, dynamic> json) => LoyaltyDataModel(
    pointsBalance: json['PointsBalance'],
    cashBalance: (json['CashBalance'] as num?)?.toDouble(),
    currentTier: json['CurrentTier'],
    nextTier: json['NextTier'],
    wallet: (json['Wallet'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'PointsBalance': pointsBalance,
    'CashBalance': cashBalance,
    'CurrentTier': currentTier,
    'Wallet': wallet,
    'NextTier': nextTier,
  };

  factory LoyaltyDataModel.fromEntity(LoyaltyData e) =>
      LoyaltyDataModel(pointsBalance: e.pointsBalance, cashBalance: e.cashBalance, currentTier: e.currentTier, nextTier: e.nextTier);
}

class CustomerInfoModel extends CustomerInfo {
  const CustomerInfoModel({super.loyaltyData});

  factory CustomerInfoModel.fromJson(Map<String, dynamic> json) =>
      CustomerInfoModel(loyaltyData: json['LoyaltyData'] != null ? LoyaltyDataModel.fromJson(json['LoyaltyData']) : null);

  Map<String, dynamic> toJson() => {'LoyaltyData': loyaltyData != null ? LoyaltyDataModel.fromEntity(loyaltyData!).toJson() : null};

  factory CustomerInfoModel.fromEntity(CustomerInfo e) => CustomerInfoModel(loyaltyData: e.loyaltyData);
}
