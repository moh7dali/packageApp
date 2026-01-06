import 'package:equatable/equatable.dart';

class ProductImage extends Equatable {
  final int? id;
  final bool? isDefaultImage;
  final bool? isThumbnail;
  final String? imageUrl;

  const ProductImage({
    this.id,
    this.isDefaultImage,
    this.isThumbnail,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, isDefaultImage, isThumbnail, imageUrl];
}

class ModifierOption extends Equatable {
  final String? name;
  final double? price;
  final int? displayOrder;
  final int? id;
  final bool? isDefault;
  final bool? isActive;

  const ModifierOption({
    this.name,
    this.price,
    this.id,
    this.displayOrder,
    this.isDefault,
    this.isActive,
  });

  @override
  List<Object?> get props => [name, price, displayOrder, isDefault, isActive, id];
}

class ProductModifier extends Equatable {
  final String? displayName;
  final int? type;
  final int? id;
  final int? displayOrder;
  final bool? isActive;
  final List<ModifierOption>? modifierOptions;

  const ProductModifier({
    this.displayName,
    this.type,
    this.id,
    this.displayOrder,
    this.isActive,
    this.modifierOptions,
  });

  @override
  List<Object?> get props => [displayName, type, displayOrder, isActive, modifierOptions, id];
}

class ProductDetails extends Equatable {
  final int? id;
  final String? name;
  final String? description;
  final String? videoUrl;
  final bool? excludeFromDiscount;
  final double? price;
  final double? offerPrice;
  final double? maximumPurchaseAmount;
  final List<ProductImage>? productItemImages;
  final List<ProductModifier>? productItemModifiers;
  final bool? hasStock;
  final int? quantity;

  const ProductDetails({
    this.id,
    this.name,
    this.description,
    this.excludeFromDiscount,
    this.price,
    this.offerPrice,
    this.videoUrl,
    this.maximumPurchaseAmount,
    this.productItemImages,
    this.productItemModifiers,
    this.hasStock,
    this.quantity,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        excludeFromDiscount,
        offerPrice,
        videoUrl,
        maximumPurchaseAmount,
        productItemImages,
        hasStock,
        quantity,
        productItemModifiers,
      ];
}
