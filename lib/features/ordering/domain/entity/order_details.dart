import 'package:equatable/equatable.dart';
import 'package:my_custom_widget/features/address/domain/entity/address.dart';
import 'package:my_custom_widget/features/branch/domain/entities/branch_details.dart';

class OrderModifierOption extends Equatable {
  final int quantity;
  final String name;
  final double unitPrice;
  final double totalPrice;

  const OrderModifierOption({
    required this.quantity,
    required this.name,
    required this.unitPrice,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [quantity, name, unitPrice, totalPrice];
}

class OrderItem extends Equatable {
  final int? quantity;
  final String? itemName;
  final String? imageUrl;
  final String? categoryName;
  final double? unitPrice;
  final double? offerPrice;
  final double? subTotalPrice;
  final double? noneOfferTotalPrice;
  final String? specialInstructions;
  final List<OrderModifierOption>? modifierOptions;

  const OrderItem({
    this.quantity,
    this.itemName,
    this.imageUrl,
    this.categoryName,
    this.unitPrice,
    this.offerPrice,
    this.subTotalPrice,
    this.noneOfferTotalPrice,
    this.specialInstructions,
    this.modifierOptions,
  });

  @override
  List<Object?> get props => [
        quantity,
        itemName,
        imageUrl,
        categoryName,
        unitPrice,
        offerPrice,
        subTotalPrice,
        noneOfferTotalPrice,
        specialInstructions,
        modifierOptions,
      ];
}

class OrderDetails extends Equatable {
  final double? totalAmount;
  final double? subTotalAmount;
  final double? tax;
  final bool? isRated;
  final bool? isScheduled;
  final String? specialInstructions;
  final DateTime? creationDate;
  final DateTime? deliveryDate;
  final double? netAmount;
  final double? taxAmount;
  final BranchDetails? orderBranchDetails;
  final Address? customerAddress;
  final List<OrderItem>? orderItems;
  final int? deliveryMethodId;
  final String? deliveryMethod;
  final String? paymentMethodName;
  final DateTime? expectedDeliveryDate;
  final double? deliveryFees;
  final double? deliveryFeesBeforeDiscount;
  final double? deliveryFeesDiscount;
  final double? discountAmount;
  final double? orderDiscountAmount;
  final double? redemptionAmount;
  final double? usedWalletAmount;
  final int? numberOfPoints;

  const OrderDetails({
    this.totalAmount,
    this.subTotalAmount,
    this.tax,
    this.isRated,
    this.isScheduled,
    this.specialInstructions,
    this.creationDate,
    this.deliveryDate,
    this.netAmount,
    this.taxAmount,
    this.paymentMethodName,
    this.orderBranchDetails,
    this.customerAddress,
    this.orderItems,
    this.deliveryMethodId,
    this.deliveryMethod,
    this.expectedDeliveryDate,
    this.deliveryFees,
    this.deliveryFeesBeforeDiscount,
    this.deliveryFeesDiscount,
    this.discountAmount,
    this.orderDiscountAmount,
    this.redemptionAmount,
    this.numberOfPoints,
    this.usedWalletAmount,
  });

  @override
  List<Object?> get props => [
        totalAmount,
        subTotalAmount,
        tax,
        isRated,
        isScheduled,
        specialInstructions,
        creationDate,
        deliveryDate,
        netAmount,
        taxAmount,
        orderBranchDetails,
        customerAddress,
        orderItems,
        deliveryMethodId,
        deliveryMethod,
        expectedDeliveryDate,
        deliveryFees,
        deliveryFeesBeforeDiscount,
        deliveryFeesDiscount,
        discountAmount,
        orderDiscountAmount,
        redemptionAmount,
        numberOfPoints,
      ];
}
