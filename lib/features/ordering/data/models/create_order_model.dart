import '../../domain/entity/create_order.dart';

class CreateOrderModel extends CreateOrder {
  const CreateOrderModel({super.paymentInfo, super.orderId, super.totalOrderAmount, super.unavailableItems});

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) {
    return CreateOrderModel(
      paymentInfo: json['PaymentInfo'] != null ? PaymentInfoModel.fromJson(json['PaymentInfo']) : null,
      orderId: json['OrderId'],
      totalOrderAmount: (json['TotalOrderAmount'] as num?)?.toDouble(),
      unavailableItems: json["UnavailableItems"] == null
          ? []
          : List<UnavailableItems>.from(json["UnavailableItems"]!.map((x) => UnavailableItemsModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'PaymentInfo': paymentInfo != null ? (paymentInfo as PaymentInfoModel).toJson() : null,
        'OrderId': orderId,
        'TotalOrderAmount': totalOrderAmount,
      };

  factory CreateOrderModel.fromEntity(CreateOrder entity) => CreateOrderModel(
        paymentInfo: entity.paymentInfo,
        orderId: entity.orderId,
        totalOrderAmount: entity.totalOrderAmount,
      );
}

class PaymentInfoModel extends PaymentInfo {
  const PaymentInfoModel({
    super.paymentToken,
    super.webPaymentUrl,
    super.customerEmail,
    super.customerPaymentCardsInfo,
  });

  factory PaymentInfoModel.fromJson(Map<String, dynamic> json) {
    return PaymentInfoModel(
      paymentToken: json['PaymentToken'],
      webPaymentUrl: json['WebPaymentUrl'],
      customerEmail: json['CustomerEmail'],
      customerPaymentCardsInfo:
          json['CustomerPaymentCardsInfo'] != null ? CustomerPaymentCardInfoModel.fromJson(json['CustomerPaymentCardsInfo']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'PaymentToken': paymentToken,
        'WebPaymentUrl': webPaymentUrl,
        'CustomerEmail': customerEmail,
        'CustomerPaymentCardsInfo': customerPaymentCardsInfo != null ? (customerPaymentCardsInfo as CustomerPaymentCardInfoModel).toJson() : null,
      };

  factory PaymentInfoModel.fromEntity(PaymentInfo entity) => PaymentInfoModel(
        paymentToken: entity.paymentToken,
        webPaymentUrl: entity.webPaymentUrl,
        customerEmail: entity.customerEmail,
        customerPaymentCardsInfo: entity.customerPaymentCardsInfo,
      );
}

class CustomerPaymentCardInfoModel extends CustomerPaymentCardInfo {
  const CustomerPaymentCardInfoModel({
    super.cardNumber,
    super.cardReferenceId,
    super.imageUrl,
  });

  factory CustomerPaymentCardInfoModel.fromJson(Map<String, dynamic> json) {
    return CustomerPaymentCardInfoModel(
      cardNumber: json['CardNumber'],
      cardReferenceId: json['CardReferenceId'],
      imageUrl: json['ImageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'CardNumber': cardNumber,
        'CardReferenceId': cardReferenceId,
        'ImageUrl': imageUrl,
      };

  factory CustomerPaymentCardInfoModel.fromEntity(CustomerPaymentCardInfo entity) => CustomerPaymentCardInfoModel(
        cardNumber: entity.cardNumber,
        cardReferenceId: entity.cardReferenceId,
        imageUrl: entity.imageUrl,
      );
}

class UnavailableItemsModel extends UnavailableItems {
  const UnavailableItemsModel({
    required super.id,
    required super.name,
    required super.unavailableModifierOption,
  });

  factory UnavailableItemsModel.fromJson(Map<String, dynamic> json) => UnavailableItemsModel(
        id: json["Id"],
        name: json["Name"],
        unavailableModifierOption: json["UnavailableModifierOptions"] == null
            ? []
            : List<UnavailableModifierOption>.from(json["UnavailableModifierOptions"].map((x) => UnavailableModifierOptionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "UnavailableModifierOptions": unavailableModifierOption?.map((x) => (x as UnavailableModifierOptionModel).toJson()).toList()
      };
}

class UnavailableModifierOptionModel extends UnavailableModifierOption {
  const UnavailableModifierOptionModel({
    super.name,
    super.id,
  });

  factory UnavailableModifierOptionModel.fromJson(Map<String, dynamic> json) => UnavailableModifierOptionModel(
        name: json["Name"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "Id": id,
      };

  factory UnavailableModifierOptionModel.fromEntity(UnavailableModifierOption e) => UnavailableModifierOptionModel(
        name: e.name,
        id: e.id,
      );
}
