import 'package:my_custom_widget/features/address/data/models/address_model.dart';
import 'package:my_custom_widget/features/branch/data/models/branch_details_model.dart';

import '../../domain/entity/order_details.dart';

class OrderModifierOptionModel extends OrderModifierOption {
  const OrderModifierOptionModel({required super.quantity, required super.name, required super.unitPrice, required super.totalPrice});

  factory OrderModifierOptionModel.fromJson(Map<String, dynamic> json) {
    return OrderModifierOptionModel(
      quantity: (json['Quantity'] ?? 0) as int,
      name: (json['Name'] ?? '') as String,
      unitPrice: (json['UnitPrice'] ?? 0).toDouble(),
      totalPrice: (json['TotalPrice'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {'Quantity': quantity, 'Name': name, 'UnitPrice': unitPrice, 'TotalPrice': totalPrice};
}

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    super.quantity,
    super.itemName,
    super.imageUrl,
    super.categoryName,
    super.unitPrice,
    super.offerPrice,
    super.subTotalPrice,
    super.noneOfferTotalPrice,
    super.specialInstructions,
    super.modifierOptions,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      quantity: json['Quantity'] as int?,
      itemName: json['ItemName'] as String?,
      imageUrl: json['ImageUrl'] as String?,
      categoryName: json['CategoryName'] as String?,
      unitPrice: (json['UnitPrice'] ?? 0).toDouble(),
      offerPrice: (json['OfferPrice'] ?? 0).toDouble(),
      subTotalPrice: (json['SubTotalPrice'] ?? 0).toDouble(),
      noneOfferTotalPrice: (json['NoneOfferTotalPrice'] ?? 0).toDouble(),
      specialInstructions: json['SpecialInstructions'] as String?,
      modifierOptions: (json['ModifierOptions'] as List?)?.map((e) => OrderModifierOptionModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'Quantity': quantity,
    'ItemName': itemName,
    'ImageUrl': imageUrl,
    'CategoryName': categoryName,
    'UnitPrice': unitPrice,
    'OfferPrice': offerPrice,
    'SubTotalPrice': subTotalPrice,
    'NoneOfferTotalPrice': noneOfferTotalPrice,
    'SpecialInstructions': specialInstructions,
    'ModifierOptions': modifierOptions?.map((e) => (e as OrderModifierOptionModel).toJson()).toList(),
  };
}

class OrderDetailsModel extends OrderDetails {
  const OrderDetailsModel({
    super.totalAmount,
    super.subTotalAmount,
    super.tax,
    super.isRated,
    super.isScheduled,
    super.specialInstructions,
    super.creationDate,
    super.deliveryDate,
    super.netAmount,
    super.taxAmount,
    BranchDetailsModel? super.orderBranchDetails,
    AddressModel? super.customerAddress,
    super.orderItems,
    super.deliveryMethodId,
    super.deliveryMethod,
    super.expectedDeliveryDate,
    super.deliveryFees,
    super.deliveryFeesBeforeDiscount,
    super.deliveryFeesDiscount,
    super.discountAmount,
    super.orderDiscountAmount,
    super.redemptionAmount,
    super.numberOfPoints,
    super.paymentMethodName,
    super.usedWalletAmount,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      totalAmount: (json['TotalAmount'] ?? 0).toDouble(),
      subTotalAmount: (json['SubTotalAmount'] ?? 0).toDouble(),
      usedWalletAmount: (json['UsedWalletAmount'] ?? 0).toDouble(),
      tax: (json['Tax'] ?? 0).toDouble(),
      isRated: json['IsRated'] as bool?,
      isScheduled: json['IsScheduled'] as bool?,
      specialInstructions: json['SpecialInstructions'] as String?,
      paymentMethodName: json['PaymentMethodName'] as String?,
      creationDate: json['CreationDate'] != null ? DateTime.tryParse(json['CreationDate']) : null,
      deliveryDate: json['DeliveryDate'] != null ? DateTime.tryParse(json['DeliveryDate']) : null,
      netAmount: (json['NetAmount'] ?? 0).toDouble(),
      taxAmount: (json['TaxAmount'] ?? 0).toDouble(),
      orderBranchDetails: json['OrderBranchDetails'] != null ? BranchDetailsModel.fromJson(json['OrderBranchDetails'] as Map<String, dynamic>) : null,
      customerAddress: json['CustomerAddress'] != null ? AddressModel.fromJson(json['CustomerAddress'] as Map<String, dynamic>) : null,
      orderItems: (json['OrderItems'] as List?)?.map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>)).toList(),
      deliveryMethodId: json['DeliveryMethodId'] as int?,
      deliveryMethod: json['DeliveryMethod'] as String?,
      expectedDeliveryDate: json['ExpectedDeliveryDate'] != null ? DateTime.tryParse(json['ExpectedDeliveryDate']) : null,
      deliveryFees: (json['DeliveryFees'] ?? 0).toDouble(),
      deliveryFeesBeforeDiscount: (json['DeliveryFeesBeforeDiscount'] ?? 0).toDouble(),
      deliveryFeesDiscount: (json['DeliveryFeesDiscount'] ?? 0).toDouble(),
      discountAmount: (json['DiscountAmount'] ?? 0).toDouble(),
      orderDiscountAmount: (json['OrderDiscountAmount'] ?? 0).toDouble(),
      redemptionAmount: (json['RedemptionAmount'] ?? 0).toDouble(),
      numberOfPoints: (json['NumberOfPoints'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
    'TotalAmount': totalAmount,
    'SubTotalAmount': subTotalAmount,
    'UsedWalletAmount': usedWalletAmount,
    'PaymentMethodName': paymentMethodName,
    'Tax': tax,
    'IsRated': isRated,
    'IsScheduled': isScheduled,
    'SpecialInstructions': specialInstructions,
    'CreationDate': creationDate?.toIso8601String(),
    'DeliveryDate': deliveryDate?.toIso8601String(),
    'NetAmount': netAmount,
    'TaxAmount': taxAmount,
    'OrderBranchDetails': (orderBranchDetails as BranchDetailsModel?)?.toJson(),
    'CustomerAddress': (customerAddress as AddressModel?)?.toJson(),
    'OrderItems': orderItems?.map((e) => (e as OrderItemModel).toJson()).toList(),
    'DeliveryMethodId': deliveryMethodId,
    'DeliveryMethod': deliveryMethod,
    'ExpectedDeliveryDate': expectedDeliveryDate?.toIso8601String(),
    'DeliveryFees': deliveryFees,
    'DeliveryFeesBeforeDiscount': deliveryFeesBeforeDiscount,
    'DeliveryFeesDiscount': deliveryFeesDiscount,
    'DiscountAmount': discountAmount,
    'OrderDiscountAmount': orderDiscountAmount,
    'RedemptionAmount': redemptionAmount,
    'NumberOfPoints': numberOfPoints,
  };
}
