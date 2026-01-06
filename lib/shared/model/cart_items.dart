import 'package:my_custom_widget/features/category/domain/entities/product_details.dart';
import 'package:my_custom_widget/shared/model/selected_Options.dart';
import 'package:equatable/equatable.dart';

import '../../features/category/data/models/category_model.dart';
import '../../features/category/data/models/product_details_model.dart';
import '../../features/category/domain/entities/category.dart';

class CartItems extends Equatable {
  final List<CartProduct> products;

  const CartItems({required this.products});

  @override
  List<Object?> get props => [products];
}

class CartItemsModel extends CartItems {
  const CartItemsModel({required List<CartProduct> products}) : super(products: products);

  factory CartItemsModel.fromEntity(CartItems entity) {
    return CartItemsModel(
      products: entity.products.map((p) {
        return CartProductModel.fromEntity(p);
      }).toList(),
    );
  }

  factory CartItemsModel.fromJson(Map<String, dynamic> json) => CartItemsModel(
        products: json["Products"] == null ? [] : List<CartProduct>.from(json["Products"]!.map((x) => CartProductModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() {
    return {
      'Products': products.map((e) => (e as CartProductModel).toJson()).toList(),
    };
  }
}

class CartProduct extends Equatable {
  final ProductDetails productDetails;
  final List<SelectedModifierOption> selectedOptions;
  final int quantity;
  final Category? selectedCategory;
  final String? notes;

  const CartProduct(
      {required this.productDetails, required this.selectedOptions, required this.quantity, required this.notes, required this.selectedCategory});

  @override
  List<Object?> get props => [productDetails, selectedOptions, quantity];
}

class CartProductModel extends CartProduct {
  const CartProductModel({
    required super.productDetails,
    required super.selectedOptions,
    required super.quantity,
    required super.notes,
    required super.selectedCategory,
  });

  factory CartProductModel.fromJson(Map<String, dynamic> json) => CartProductModel(
        productDetails: ProductDetailsModel.fromJson(json["ProductDetails"]),
        selectedOptions: json["SelectedOptions"] == null
            ? []
            : List<SelectedModifierOption>.from(json["SelectedOptions"].map((x) => SelectedModifierOptionModel.fromJson(x))),
        quantity: json["Quantity"] ?? 1,
        notes: json["Notes"],
        selectedCategory: json["SelectedCategory"] != null ? CategoryModel.fromJson(json["SelectedCategory"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "ProductDetails": (productDetails as ProductDetailsModel).toJson(),
        "SelectedOptions": selectedOptions.map((e) => (e as SelectedModifierOptionModel).toJson()).toList(),
        "Quantity": quantity,
        "Notes": notes,
        "SelectedCategory": selectedCategory != null ? (selectedCategory as CategoryModel).toJson() : null,
      };

  factory CartProductModel.fromEntity(CartProduct entity) => CartProductModel(
        productDetails: entity.productDetails as ProductDetailsModel,
        selectedOptions: entity.selectedOptions.map((e) => SelectedModifierOptionModel.fromEntity(e)).toList(),
        quantity: entity.quantity,
        notes: entity.notes,
        selectedCategory: entity.selectedCategory != null
            ? CategoryModel(
                id: entity.selectedCategory!.id,
                name: entity.selectedCategory!.name,
                imageUrl: entity.selectedCategory!.imageUrl,
                hasProduct: entity.selectedCategory!.hasProduct,
                hasSubcategory: entity.selectedCategory!.hasSubcategory,
                hasFilters: entity.selectedCategory!.hasFilters,
              )
            : null,
      );
}
