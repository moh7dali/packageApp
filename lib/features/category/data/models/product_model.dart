import 'package:my_custom_widget/features/category/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.description,
    required super.price,
    required super.offerPrice,
    required super.isActiveForTheSelectedBranch,
    required super.hasStock,
    required super.quantity,
    required super.hasItemModifiers,
    required super.maximumPurchaseAmount,
    required super.excludeFromDiscount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["Id"],
    name: json["Name"],
    imageUrl: json["ImageUrl"],
    description: json["Description"],
    isActiveForTheSelectedBranch: json["IsActiveForTheSelectedBranch"],
    price: json["Price"],
    offerPrice: json["OfferPrice"],
    hasStock: json["HasStock"],
    quantity: json["Quantity"],
    hasItemModifiers: json["HasModifier"],
    maximumPurchaseAmount: json["MaximumPurchaseAmount"],
    excludeFromDiscount: json["ExcludeFromDiscount"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "ImageUrl": imageUrl,
    "Description": description,
    "IsActiveForTheSelectedBranch": isActiveForTheSelectedBranch,
    "Price": price,
    "OfferPrice": offerPrice,
    "HasStock": hasStock,
    "Quantity": quantity,
    "HasItemModifiers": hasItemModifiers,
    "MaximumPurchaseAmount": maximumPurchaseAmount,
    "ExcludeFromDiscount": excludeFromDiscount,
  };
}

class ProductListModel extends ProductList {
  const ProductListModel({required super.totalNumberofResult, required super.product});

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
    totalNumberofResult: json["TotalNumberOfResult"],
    product: json["List"] == null ? [] : List<Product>.from(json["List"]!.map((x) => ProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {"TotalNumberofResult": totalNumberofResult, "List": product};
}
