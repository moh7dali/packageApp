import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/shared/model/cart_items.dart';
import 'package:my_custom_widget/shared/widgets/add_to_cart_dialog.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/helper/shared_preferences_storage.dart';
import '../../../../shared/model/selected_Options.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../../../../shared/widgets/shake_widget.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_details.dart';
import '../../domain/usecases/get_product_details.dart';

class ProductDetailsController extends GetxController {
  final GetProductDetails getProductDetails;
  ProductDetails? productDetails;
  bool isLoading = true;
  final Product product;
  final Category selectedCategory;
  int quantity = 1;
  final noteController = TextEditingController();
  final noteShakeKey = GlobalKey<ShakeWidgetState>();
  ScrollController scrollController = ScrollController();
  List<GlobalKey> optionKeys = [];
  List<bool> expansionStates = [];
  List<SelectedModifierOption> selectedOptions = [];
  List<ProductModifier> productModifierWithoutSize = [];
  List<ProductModifier> sizeModifier = [];
  double selectedPrice = 0;
  double totalPrice = 0.0;
  final bool isSlider;

  void initializeExpansionStates(int length) {
    expansionStates = List.generate(length, (_) => false);
    update();
  }

  void updateExpansionState(int index) {
    for (int i = 0; i < expansionStates.length; i++) {
      expansionStates[i] = i == index;
    }
    update();
  }

  void closeExpansion(int index) {
    if (index >= 0 && index < expansionStates.length) {
      expansionStates[index] = false;
      update();
    }
  }

  void initializeKeys() {
    productModifierWithoutSize = productDetails?.productItemModifiers?.where((m) => m.type == 1 || m.type == 2).toList() ?? [];
    sizeModifier = productDetails?.productItemModifiers?.where((m) => m.type == 5).toList() ?? [];
    optionKeys = List.generate(productModifierWithoutSize.length, (_) => GlobalKey());
    initializeExpansionStates(productModifierWithoutSize.length);
    autoSelectDefaultModifiers(productDetails?.productItemModifiers ?? []);
  }

  void autoSelectDefaultModifiers(List<ProductModifier> modifiers) {
    for (final modifier in modifiers) {
      final defaultOptions = modifier.modifierOptions?.where((o) => o.isDefault == true).toList() ?? [];

      if (defaultOptions.isNotEmpty) {
        if (modifier.type == 1) {
          selectedOptions.add(SelectedModifierOption(modifier: modifier, selectedOption: defaultOptions));
        } else {
          selectedOptions.add(SelectedModifierOption(modifier: modifier, selectedOption: defaultOptions.first));
          if (modifier.type == 5) {
            selectedPrice = defaultOptions.first.price ?? 0;
          }
        }
      }
    }

    calculateTotal();
    update();
  }

  void calculateTotal() {
    if (productDetails == null) return;

    double basePrice;

    if (selectedPrice > 0) {
      basePrice = selectedPrice;
    } else {
      basePrice = (productDetails!.offerPrice != null && productDetails!.offerPrice! > 0) ? productDetails!.offerPrice! : productDetails!.price ?? 0;
    }

    double optionPrice = 0.0;

    for (final opt in selectedOptions) {
      final selected = opt.selectedOption;
      if (selected is ModifierOption) {
        if (opt.modifier.type != 5) {
          optionPrice += selected.price ?? 0;
        }
      } else if (selected is List<ModifierOption>) {
        optionPrice += selected.fold(0.0, (sum, o) => sum + (o.price ?? 0));
      }
    }

    totalPrice = (basePrice + optionPrice) * quantity;
    update();
  }

  ProductDetailsController({required this.product, required this.selectedCategory, required this.isSlider}) : getProductDetails = sl();

  @override
  void onInit() {
    getProductDetailsApi();
    super.onInit();
  }

  Future<void> getProductDetailsApi() async {
    await getProductDetails.repository
        .getProductDetails(queryParameters: {"productId": "${product.id}", "categoryId": "${selectedCategory.id}"})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
              isLoading = false;
              update();
            },
            (value) async {
              productDetails = value;
              if (productDetails?.id == 0) {
                await SharedHelper().closeAllDialogs();
                SharedHelper().notAvailableProductInBranch(branch: await sl<SharedPreferencesStorage>().getSelectedBranch());
              }
              initializeKeys();
              calculateTotal();
              isLoading = false;
              update();
            },
          ),
        );
  }

  quantityAdd() {
    quantity++;
    calculateTotal();
    update();
  }

  quantitySub() {
    if (quantity > 1) {
      quantity--;
      calculateTotal();
    }
    update();
  }

  void selectRadio(ProductModifier modifier, ModifierOption option) {
    int modifierIndex = selectedOptions.indexWhere((element) => element.modifier.id == modifier.id);
    if (modifierIndex != -1) {
      selectedOptions[modifierIndex] = SelectedModifierOption(modifier: modifier, selectedOption: option);
    } else {
      selectedOptions.add(SelectedModifierOption(modifier: modifier, selectedOption: option));
    }
    calculateTotal();
    update();
  }

  void toggleCheckbox(ProductModifier modifier, ModifierOption option) {
    int modifierIndex = selectedOptions.indexWhere((element) => element.modifier.id == modifier.id);

    if (modifierIndex != -1) {
      List<ModifierOption> currentSelected = selectedOptions[modifierIndex].selectedOption as List<ModifierOption>;

      if (currentSelected.any((e) => e.id == option.id)) {
        currentSelected.removeWhere((e) => e.id == option.id);
      } else {
        currentSelected.add(option);
      }

      if (currentSelected.isEmpty) {
        selectedOptions.removeAt(modifierIndex);
      } else {
        selectedOptions[modifierIndex] = SelectedModifierOption(modifier: modifier, selectedOption: currentSelected);
      }
    } else {
      selectedOptions.add(SelectedModifierOption(modifier: modifier, selectedOption: [option]));
    }
    calculateTotal();
    update();
  }

  bool isOptionSelected(ProductModifier modifier, ModifierOption option) {
    int modifierIndex = selectedOptions.indexWhere((element) => element.modifier.id == modifier.id);

    if (modifierIndex != -1) {
      List<ModifierOption> selectedList = selectedOptions[modifierIndex].selectedOption as List<ModifierOption>;
      return selectedList.any((e) => e.id == option.id);
    }
    return false;
  }

  bool isModifierSelected(ProductModifier modifier) {
    final selected = selectedOptions.firstWhereOrNull((element) => element.modifier.id == modifier.id)?.selectedOption;

    if (selected == null) return false;

    if (modifier.type == 1) {
      return (selected as List<ModifierOption>).isNotEmpty;
    } else {
      return selected != null;
    }
  }

  // Future<void> validateProduct() async {
  //   if (sizeModifier.isNotEmpty && selectedPrice == 0) {
  //     SharedHelper().errorSnackBar("pleaseSelectSize".tr, closeOne: true);
  //     return;
  //   }
  //
  //   final requiredModifiers = productModifierWithoutSize.where((modifier) => modifier.type == 2).toList();
  //   final missingRequired = requiredModifiers.firstWhereOrNull(
  //     (modifier) => !selectedOptions.any((sel) => sel.modifier.id == modifier.id),
  //   );
  //
  //   if (missingRequired != null) {
  //     final index = productDetails!.productItemModifiers!.indexWhere((e) => e.id == missingRequired.id);
  //     final key = optionKeys[index];
  //     final context = key.currentContext;
  //     if (context != null) {
  //       Scrollable.ensureVisible(context, duration: const Duration(milliseconds: 300));
  //       updateExpansionState(index);
  //     }
  //     SharedHelper().errorSnackBar("${'pleaseSelectFrom'.tr} ${missingRequired.displayName}", closeOne: true);
  //     return;
  //   }
  //
  //   await addOrUpdateCartItem(CartProduct(
  //     selectedOptions: selectedOptions,
  //     productDetails: productDetails!,
  //     quantity: quantity,
  //     notes: noteController.text,
  //     selectedCategory: selectedCategory,
  //   ));
  // }

  Future<void> validateProduct() async {
    if (sizeModifier.isNotEmpty && selectedPrice == 0) {
      SharedHelper().errorSnackBar("pleaseSelectSize".tr, closeOne: true,durationInSeconds: 1);
      return;
    }
    final requiredModifiers = productModifierWithoutSize.where((m) => m.type == 2).toList();

    final missingRequired = requiredModifiers.firstWhereOrNull((modifier) => !selectedOptions.any((sel) => sel.modifier.id == modifier.id));

    if (missingRequired != null) {
      final index = productModifierWithoutSize.indexWhere((e) => e.id == missingRequired.id);

      if (index != -1) {
        updateExpansionState(index);

        final keyContext = optionKeys[index].currentContext;
        if (keyContext != null) {
          Scrollable.ensureVisible(keyContext, duration: const Duration(milliseconds: 400), alignment: 0.05);
        }
      }

      SharedHelper().errorSnackBar("${'pleaseSelectFrom'.tr} ${missingRequired.displayName}", closeOne: true,durationInSeconds: 1);
      return;
    }

    await addOrUpdateCartItem(
      CartProduct(
        selectedOptions: selectedOptions,
        productDetails: productDetails!,
        quantity: quantity,
        notes: noteController.text,
        selectedCategory: selectedCategory,
      ),
    );
  }

  Future<void> addOrUpdateCartItem(CartProduct newItem) async {
    final existingCart = await sl<SharedPreferencesStorage>().getCartItems();
    final updatedProducts = List<CartProduct>.from(existingCart.products);
    final sameProductList = updatedProducts.where((item) => item.productDetails.id == newItem.productDetails.id);

    final basePrice = basePriceTotalForModifiers(newItem.selectedOptions);
    double total;

    if (sameProductList.isEmpty) {
      total = basePrice * newItem.quantity;
    } else {
      double existingTotal = sameProductList.fold(0.0, (sum, item) {
        final itemPrice = basePriceTotalForModifiers(item.selectedOptions);
        return sum + (itemPrice * item.quantity);
      });

      total = existingTotal + (basePrice * newItem.quantity);
    }

    if (exceedsMaximumAllowedPrice(total)) {
      showExceededMaximumPurchaseAmountPopUp();
      return;
    }

    final matchingIndex = updatedProducts.indexWhere((item) {
      final isSameProduct = item.productDetails.id == newItem.productDetails.id;
      final isSameModifiers = _areModifierOptionsEqual(item.selectedOptions, newItem.selectedOptions);
      final isSameNote = (item.notes ?? '').trim() == (newItem.notes ?? '').trim();
      return isSameProduct && isSameModifiers && isSameNote;
    });

    if (matchingIndex != -1) {
      final existingItem = updatedProducts[matchingIndex];
      final updatedItem = CartProduct(
        productDetails: existingItem.productDetails,
        selectedOptions: existingItem.selectedOptions,
        quantity: existingItem.quantity + newItem.quantity,
        notes: existingItem.notes,
        selectedCategory: selectedCategory,
      );
      updatedProducts[matchingIndex] = updatedItem;
    } else {
      updatedProducts.add(newItem);
    }

    final updatedCart = CartItems(products: updatedProducts);
    await sl<SharedPreferencesStorage>().setCartItems(updatedCart);
    await SharedHelper().closeAllDialogs();

    if (isSlider) {
      SDKNav.toNamed(RouteConstant.brandCategoryPage);
    }
    SharedHelper().scaleDialog(AddToCartDialog());
  }

  bool _areModifierOptionsEqual(List<SelectedModifierOption> a, List<SelectedModifierOption> b) {
    if (a.length != b.length) return false;

    for (int i = 0; i < a.length; i++) {
      final ao = a[i];
      final bo = b[i];

      if (ao.modifier.id != bo.modifier.id) return false;

      final aOption = ao.selectedOption;
      final bOption = bo.selectedOption;

      if (aOption is ModifierOption && bOption is ModifierOption) {
        if (aOption.id != bOption.id) return false;
      } else if (aOption is List<ModifierOption> && bOption is List<ModifierOption>) {
        if (aOption.length != bOption.length) return false;

        for (int j = 0; j < aOption.length; j++) {
          if (aOption[j].id != bOption[j].id) return false;
        }
      } else {
        return false;
      }
    }

    return true;
  }

  bool exceedsMaximumAllowedPrice(double total) {
    final max = productDetails?.maximumPurchaseAmount ?? 0;
    if (max <= 0) return false;
    return total > max;
  }

  void showExceededMaximumPurchaseAmountPopUp() {
    SharedHelper().actionDialog(
      "title",
      "${'limitationTex'.tr} ${formatAmountWithCurrency(productDetails?.maximumPurchaseAmount ?? 0)}",
      noCancel: true,
      confirm: () {
        SDKNav.back();
      },
    );
  }

  double basePriceTotalForModifiers(List<SelectedModifierOption> options) {
    final sizeOption = options.firstWhereOrNull((opt) => opt.modifier.type == 5)?.selectedOption;
    if (sizeOption is ModifierOption) {
      return sizeOption.price ?? 0;
    }

    return (productDetails?.offerPrice != null && productDetails!.offerPrice! > 0) ? productDetails!.offerPrice! : productDetails?.price ?? 0;
  }

  void setSelectedSize(ProductModifier modifier, ModifierOption option) {
    selectedPrice = option.price ?? 0;

    int index = selectedOptions.indexWhere((element) => element.modifier.id == modifier.id);
    if (index != -1) {
      selectedOptions[index] = SelectedModifierOption(modifier: modifier, selectedOption: option);
    } else {
      selectedOptions.add(SelectedModifierOption(modifier: modifier, selectedOption: option));
    }

    calculateTotal();
    update();
  }
}
