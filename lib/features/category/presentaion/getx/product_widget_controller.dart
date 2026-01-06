import 'package:get/get.dart';

import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/helper/shared_preferences_storage.dart';
import '../../../../shared/model/cart_items.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../../data/models/product_details_model.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_details.dart';

class ProductWidgetController extends GetxController {
  final Product product;
  final Category selectedCategory;

  int quantity = 0;
  late final ProductDetails productDetails;

  ProductWidgetController({required this.product, required this.selectedCategory});

  @override
  void onInit() {
    super.onInit();
    _initializeProductDetails();
    _loadCartQuantity();
  }

  void _initializeProductDetails() {
    productDetails = ProductDetailsModel(
      id: product.id,
      name: product.name,
      price: product.price,
      offerPrice: product.offerPrice,
      description: product.description,
      excludeFromDiscount: product.excludeFromDiscount,
      maximumPurchaseAmount: product.maximumPurchaseAmount,
      hasStock: product.hasStock,
      quantity: product.quantity,
      productItemImages: [ProductImageModel(id: 1, imageUrl: product.imageUrl)],
      productItemModifiers: [],
    );
  }

  Future<void> _loadCartQuantity() async {
    final cartItems = await sl<SharedPreferencesStorage>().getCartItems();
    final existing = cartItems.products.firstWhereOrNull((item) => item.productDetails.id == product.id);
    quantity = existing?.quantity ?? 0;
    update();
  }

  Future<void> increaseQuantity() async {
    quantity++;
    await _updateCart();
    update();
  }

  Future<void> decreaseQuantity() async {
    if (quantity > 0) {
      quantity--;
      await _updateCart();
      update();
    }
  }

  Future<void> _updateCart() async {
    final cart = await sl<SharedPreferencesStorage>().getCartItems();
    final updatedProducts = List<CartProduct>.from(cart.products);
    final existingIndex = updatedProducts.indexWhere((item) => item.productDetails.id == product.id);

    if (quantity == 0 && existingIndex != -1) {
      updatedProducts.removeAt(existingIndex);
    } else if (quantity > 0) {
      final newItem = CartProduct(
        productDetails: productDetails,
        selectedOptions: [],
        quantity: quantity,
        notes: '',
        selectedCategory: selectedCategory,
      );

      if (existingIndex != -1) {
        updatedProducts[existingIndex] = newItem;
      } else {
        updatedProducts.add(newItem);
      }
    }

    final updatedCart = CartItems(products: updatedProducts);
    await sl<SharedPreferencesStorage>().setCartItems(updatedCart);
  }

  double _effectiveUnitPrice(ProductDetails p) {
    final double? offer = p.offerPrice;
    final double? base = p.price;
    return (offer ?? base ?? 0).toDouble();
  }

  Future<bool> willExceedMaxAfterAdd({required ProductDetails productDetails, required int addQty}) async {
    final double? max = productDetails.maximumPurchaseAmount;
    if (max == null || max <= 0) return false;

    final existingCart = await sl<SharedPreferencesStorage>().getCartItems();

    final int productId = productDetails.id!;
    double existingSpend = 0;
    for (final item in existingCart.products.where((e) => e.productDetails.id == productId)) {
      existingSpend += _effectiveUnitPrice(item.productDetails) * (item.quantity ?? 0);
    }
    final double addedSpend = _effectiveUnitPrice(productDetails) * addQty;
    return (existingSpend + addedSpend) > max;
  }

  void showExceededMaximumPurchaseAmountPopUp() {
    SharedHelper().actionDialog(
      "title",
      "${'limitationTex'.tr} ${formatAmountWithCurrency(productDetails.maximumPurchaseAmount ?? 0)}",
      noCancel: true,
      confirm: () {
        Get.back();
      },
    );
  }
}
