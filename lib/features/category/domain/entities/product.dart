import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String? name;
  final String? imageUrl;
  final String? description;
  final bool? isActiveForTheSelectedBranch;
  final double? price;
  final double? offerPrice;
  final bool? hasStock;
  final int? quantity;
  final bool? excludeFromDiscount;
  final bool? hasItemModifiers;
  final double? maximumPurchaseAmount;

  const Product({
    this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.isActiveForTheSelectedBranch,
    this.offerPrice,
    this.price,
    this.hasStock,
    this.quantity,
    this.excludeFromDiscount,
    this.hasItemModifiers,
    this.maximumPurchaseAmount,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    imageUrl,
    isActiveForTheSelectedBranch,
    description,
    price,
    offerPrice,
    hasStock,
    quantity,
    excludeFromDiscount,
    hasItemModifiers,
    maximumPurchaseAmount,
  ];
}

class ProductList extends Equatable {
  final int? totalNumberofResult;
  final List<Product>? product;

  const ProductList({this.product, this.totalNumberofResult});

  @override
  List<Object?> get props => [product, totalNumberofResult];
}
