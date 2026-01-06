import '../../domain/entities/product_details.dart';

class ProductImageModel extends ProductImage {
  const ProductImageModel({super.id, super.isDefaultImage, super.isThumbnail, super.imageUrl});

  factory ProductImageModel.fromJson(Map<String, dynamic> json) =>
      ProductImageModel(id: json["Id"], isDefaultImage: json["IsDefaultImage"], isThumbnail: json["IsThumbnail"], imageUrl: json["ImageUrl"]);

  Map<String, dynamic> toJson() => {"Id": id, "IsDefaultImage": isDefaultImage, "IsThumbnail": isThumbnail, "ImageUrl": imageUrl};
}

class ModifierOptionModel extends ModifierOption {
  const ModifierOptionModel({super.name, super.price, super.id, super.displayOrder, super.isDefault, super.isActive});

  factory ModifierOptionModel.fromJson(Map<String, dynamic> json) => ModifierOptionModel(
    name: json["Name"],
    price: json["Price"],
    displayOrder: json["DisplayOrder"],
    id: json["Id"],
    isDefault: json["IsDefault"],
    isActive: json["IsActive"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Price": price,
    "Id": id,
    "DisplayOrder": displayOrder,
    "IsDefault": isDefault,
    "IsActive": isActive,
  };

  factory ModifierOptionModel.fromEntity(ModifierOption e) =>
      ModifierOptionModel(name: e.name, price: e.price, id: e.id, displayOrder: e.displayOrder, isDefault: e.isDefault, isActive: e.isActive);
}

class ProductModifierModel extends ProductModifier {
  const ProductModifierModel({super.displayName, super.type, super.id, super.displayOrder, super.isActive, super.modifierOptions});

  factory ProductModifierModel.fromJson(Map<String, dynamic> json) => ProductModifierModel(
    displayName: json["DisplayName"],
    type: json["Type"],
    id: json["Id"],
    displayOrder: json["DisplayOrder"],
    isActive: json["IsActive"],
    modifierOptions: json["ModifierOptions"] == null
        ? []
        : List<ModifierOption>.from(json["ModifierOptions"].map((x) => ModifierOptionModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "DisplayName": displayName,
    "Type": type,
    "DisplayOrder": displayOrder,
    "Id": id,
    "IsActive": isActive,
    "ModifierOptions": modifierOptions?.map((x) => (x as ModifierOptionModel).toJson()).toList(),
  };

  factory ProductModifierModel.fromEntity(ProductModifier e) => ProductModifierModel(
    displayName: e.displayName,
    type: e.type,
    id: e.id,
    displayOrder: e.displayOrder,
    isActive: e.isActive,
    modifierOptions: e.modifierOptions,
  );
}

class ProductDetailsModel extends ProductDetails {
  const ProductDetailsModel({
    super.id,
    super.name,
    super.description,
    super.excludeFromDiscount,
    super.videoUrl,
    super.price,
    super.offerPrice,
    super.maximumPurchaseAmount,
    super.productItemImages,
    super.productItemModifiers,
    super.quantity,
    super.hasStock,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
    id: json["Id"],
    name: json["Name"],
    excludeFromDiscount: json["ExcludeFromDiscount"],
    description: json["Description"],
    videoUrl: json["VideoUrl"],
    price: (json["Price"] as num?)?.toDouble(),
    offerPrice: (json["OfferPrice"] as num?)?.toDouble(),
    hasStock: json["HasStock"],
    quantity: json["Quantity"],
    maximumPurchaseAmount: json["MaximumPurchaseAmount"],
    productItemImages: json["ProductItemImages"] == null
        ? []
        : List<ProductImage>.from(json["ProductItemImages"].map((x) => ProductImageModel.fromJson(x))),
    productItemModifiers: json["ProductItemModifiers"] == null
        ? []
        : List<ProductModifier>.from(json["ProductItemModifiers"].map((x) => ProductModifierModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Description": description,
    "ExcludeFromDiscount": excludeFromDiscount,
    "videoUrl": videoUrl,
    "Price": price,
    "OfferPrice": offerPrice,
    "HasStock": hasStock,
    "Quantity": quantity,
    "MaximumPurchaseAmount": maximumPurchaseAmount,
    "ProductItemImages": productItemImages?.map((x) => (x as ProductImageModel).toJson()).toList(),
    "ProductItemModifiers": productItemModifiers?.map((x) => (x as ProductModifierModel).toJson()).toList(),
  };
}
