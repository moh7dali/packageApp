import 'dart:convert';

import 'package:my_custom_widget/features/address/domain/entity/address.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/create_order.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_checkout_data.dart';
import 'package:my_custom_widget/features/ordering/domain/usecases/create_order_usecase.dart';
import 'package:my_custom_widget/shared/helper/payment_helper.dart';
import 'package:my_custom_widget/shared/model/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/api/api_response.dart';
import '../../../../core/constants/assets_constants.dart';
import '../../../../core/constants/constants.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/helper/shared_preferences_storage.dart';
import '../../../../shared/widgets/bottom_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../../../../shared/widgets/shake_widget.dart';
import '../../../branch/domain/entities/branch_details.dart';
import '../../../category/domain/entities/product_details.dart';
import '../../domain/usecases/cancel_order_payment.dart';
import '../../domain/usecases/check_order_payment_statuts.dart';
import '../../domain/usecases/check_ordering_status.dart';
import '../../domain/usecases/get_order_checkout_data.dart';
import '../../domain/usecases/log_payment_failure.dart';

class CartController extends GetxController {
  final GetOrderCheckoutData getOrderCheckoutData;
  final CreateOrderUsecase createOrderUsecase;
  final CheckOrderingStatus checkOrderingStatus;
  final CheckOrderPaymentStatus checkOrderPaymentStatus;
  final CancelOrderPayment cancelOrderPayment;
  final LogPaymentFailure logPaymentFailure;

  CartController()
    : getOrderCheckoutData = sl(),
      checkOrderingStatus = sl(),
      checkOrderPaymentStatus = sl(),
      cancelOrderPayment = sl(),
      logPaymentFailure = sl(),
      createOrderUsecase = sl();
  List<CartProduct> products = [];
  bool isLoading = true;
  bool isPickUp = false;
  OrderCheckoutData? orderCheckoutData;
  CreateOrder? createOrder;
  Address? customerAddress;
  BranchDetails? selectedBranch;
  PaymentType? selectedPaymentType;
  final noteShakeKey = GlobalKey<ShakeWidgetState>();
  final noteController = TextEditingController();
  final paymentShakeKey = GlobalKey<ShakeWidgetState>();
  bool callMeToConfirm = false;
  double subTotal = 0;
  double deductibleTotal = 0;
  double totalAmount = 0;
  double taxRate = 0;
  double taxAmount = 0;
  double deliveryFees = 0;
  double redeemAmount = 0;
  double redeemRate = 0;
  bool redeemPoints = false;
  bool useWallet = false;
  List<Discount> selectedOrderDiscounts = [];
  List<Discount> selectedDeliveryDiscounts = [];
  double orderDiscountAmount = 0;
  double deliveryDiscountAmount = 0;
  String? discountErrorMessage;
  OrderingStatus? orderingStatus;
  final errorShakeKey = GlobalKey<ShakeWidgetState>();
  final GlobalKey cantOrderCardKey = GlobalKey();
  bool hasWallet = false;
  double walletBalance = 0;
  double walletApplied = 0;
  double cashToPay = 0;

  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }

  Future<void> getCartItems() async {
    final items = await sl<SharedPreferencesStorage>().getCartItems();
    isPickUp = await sl<SharedPreferencesStorage>().getIsPickUp();
    if (!isPickUp) {
      customerAddress = await sl<SharedPreferencesStorage>().getSelectedAddress();
    } else {
      selectedBranch = await sl<SharedPreferencesStorage>().getSelectedBranch();
    }
    products = items.products;
    getOrderCheckoutDataApi();
  }

  Future<void> getOrderCheckoutDataApi() async {
    Map<String, dynamic> body = {
      "ApplicationId": "${AppConstants.applicationId}",
      "BrandId": "${AppConstants.brandId}",
      "CustomerAddressInfo": {
        if (!isPickUp) "Id": "${customerAddress!.id}",
        if (!isPickUp) "Longitude": "${customerAddress!.longitude}",
        if (!isPickUp) "Latitude": "${customerAddress!.latitude}",
      },
      if (isPickUp) "BranchId": "${selectedBranch!.id}",
    };
    await getOrderCheckoutData.repository
        .getOrderCheckoutData(body: body)
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
              isLoading = false;
              update();
            },
            (orderSetting) {
              orderCheckoutData = orderSetting;
              walletBalance = (orderCheckoutData?.customerInfo?.loyaltyData?.wallet ?? 0).toDouble();
              hasWallet = walletBalance > 0;
              if (orderCheckoutData?.availablePaymentTypes?.length == 1) {
                togglePaymentToken(orderCheckoutData!.availablePaymentTypes!.first);
              }
              calculateDeliveryAddress();
              orderingStatus = orderCheckoutData?.orderingStatus;
              applySingleDiscountsIfNeeded();
              updateCartTotal();
              isLoading = false;
              update();
            },
          ),
        );
  }

  void calculateDeliveryAddress() {
    if (!AppConstants.deliveryByPaymentMethod) {
      deliveryFees = orderCheckoutData?.deliveryDetails?.fees ?? 0;
    }
    updateCartTotal();
    update();
  }

  Future<void> increaseQuantity(CartProduct product) async {
    if (addQuantity(product)) {
      final updatedProducts = products.map((item) {
        if (_isSameItem(item, product)) {
          return CartProduct(
            productDetails: item.productDetails,
            selectedOptions: item.selectedOptions,
            quantity: item.quantity + 1,
            notes: item.notes,
            selectedCategory: item.selectedCategory,
          );
        }
        return item;
      }).toList();

      products = updatedProducts;
      await sl<SharedPreferencesStorage>().setCartItems(CartItems(products: products));
      updateCartTotal();
    }
  }

  Future<void> decreaseQuantity(CartProduct product) async {
    final updatedProducts = products
        .map((item) {
          if (_isSameItem(item, product)) {
            return CartProduct(
              productDetails: item.productDetails,
              selectedOptions: item.selectedOptions,
              quantity: item.quantity - 1,
              notes: item.notes,
              selectedCategory: item.selectedCategory,
            );
          }
          return item;
        })
        .where((item) => item.quantity > 0)
        .toList();

    products = updatedProducts;
    await sl<SharedPreferencesStorage>().setCartItems(CartItems(products: products));
    updateCartTotal();
  }

  Future<void> removeItem(CartProduct product) async {
    final itemName = product.productDetails.name ?? "";

    SharedHelper().bottomSheet(
      BottomWidget(
        title: "".tr,
        description: "confirmRemoveItemName".trParams({"item": itemName}),
        onCancel: () {
          Get.back();
        },
        onConfirm: () async {
          SharedHelper().closeAllDialogs();
          final updatedProducts = products.where((item) => !_isSameItem(item, product)).toList();
          products = updatedProducts;
          await sl<SharedPreferencesStorage>().setCartItems(CartItems(products: products));
          updateCartTotal();
        },
      ),
    );
  }

  Future<void> removeAllItems() async {
    products = [];
    await sl<SharedPreferencesStorage>().setCartItems(CartItems(products: []));
    update();
  }

  bool _isSameItem(CartProduct a, CartProduct b) {
    if (a.productDetails.id != b.productDetails.id) return false;
    if (a.selectedOptions.length != b.selectedOptions.length) return false;

    for (int i = 0; i < a.selectedOptions.length; i++) {
      final aOpt = a.selectedOptions[i];
      final bOpt = b.selectedOptions[i];

      if (aOpt.modifier.id != bOpt.modifier.id) return false;

      if (aOpt.selectedOption is ModifierOption && bOpt.selectedOption is ModifierOption) {
        if ((aOpt.selectedOption as ModifierOption).id != (bOpt.selectedOption as ModifierOption).id) {
          return false;
        }
      } else if (aOpt.selectedOption is List<ModifierOption> && bOpt.selectedOption is List<ModifierOption>) {
        final aList = aOpt.selectedOption as List<ModifierOption>;
        final bList = bOpt.selectedOption as List<ModifierOption>;

        if (aList.length != bList.length) return false;

        for (int j = 0; j < aList.length; j++) {
          if (aList[j].id != bList[j].id) return false;
        }
      } else {
        return false;
      }
    }
    final aNotes = (a.notes ?? '').trim();
    final bNotes = (b.notes ?? '').trim();
    return aNotes == bNotes;
  }

  double calculateCartTotal() {
    double total = 0.0;
    for (final item in products) {
      total += calculateOneItemPrice(item);
    }
    return total;
  }

  double calculateOneItemPrice(CartProduct product) {
    final productDetails = product.productDetails;
    final quantity = product.quantity;

    double? sizePrice;
    final sizeOption = product.selectedOptions.firstWhereOrNull((opt) => opt.modifier.type == 5)?.selectedOption;
    if (sizeOption is ModifierOption) {
      sizePrice = sizeOption.price;
    }

    final basePrice =
        sizePrice ?? (productDetails.offerPrice != null && productDetails.offerPrice! > 0 ? productDetails.offerPrice! : productDetails.price ?? 0);

    double optionPrice = 0.0;
    for (final opt in product.selectedOptions) {
      final selected = opt.selectedOption;
      if (opt.modifier.type == 5) continue;

      if (selected is ModifierOption) {
        optionPrice += selected.price ?? 0;
      } else if (selected is List<ModifierOption>) {
        optionPrice += selected.fold(0.0, (sum, o) => sum + (o.price ?? 0));
      }
    }

    return (basePrice + optionPrice) * quantity;
  }

  void updateCartTotal() {
    subTotal = calculateCartTotal();
    double deliveryFee = 0;
    if (selectedPaymentType == null || isPickUp) {
      deliveryFee = 0;
    } else {
      deliveryFee = AppConstants.deliveryByPaymentMethod
          ? (selectedPaymentType == null ? 0 : deliveryFees)
          : (customerAddress == null ? 0 : deliveryFees);
    }
    deductibleTotal = products.fold(0.0, (sum, item) {
      final isProductExcluded = item.productDetails.excludeFromDiscount ?? false;
      if (!isProductExcluded) {
        return sum + calculateOneItemPrice(item);
      }
      return sum;
    });

    orderDiscountAmount = _calculateTotalDiscountAmount(
      validationAmount: deductibleTotal,
      applyAmount: deductibleTotal,
      discounts: selectedOrderDiscounts,
    ).clamp(0, deductibleTotal);

    deliveryDiscountAmount = _calculateTotalDiscountAmount(
      validationAmount: deductibleTotal,
      applyAmount: deliveryFee,
      discounts: selectedDeliveryDiscounts,
    ).clamp(0, deliveryFee);

    double adjustedSubTotal = (subTotal - orderDiscountAmount).clamp(0, double.infinity);
    double adjustedDelivery = (deliveryFee - deliveryDiscountAmount).clamp(0, double.infinity);

    taxRate = orderCheckoutData?.tax ?? 0;
    taxAmount = adjustedSubTotal * taxRate;

    redeemRate = orderCheckoutData?.customerInfo?.loyaltyData?.cashBalance ?? 0;
    taxRate = orderCheckoutData?.tax ?? 0;
    if (AppConstants.includeTaxBeforeRedeemPoints) {
      taxAmount = adjustedSubTotal * taxRate;
      if (redeemPoints) {
        redeemAmount = adjustedSubTotal.clamp(0, redeemRate);
        adjustedSubTotal -= redeemAmount;
      } else {
        redeemAmount = 0;
      }
      totalAmount = adjustedSubTotal + taxAmount + adjustedDelivery;
    } else {
      if (redeemPoints) {
        redeemAmount = adjustedSubTotal.clamp(0, redeemRate);
        adjustedSubTotal -= redeemAmount;
      } else {
        redeemAmount = 0;
      }
      taxAmount = adjustedSubTotal * taxRate;
      totalAmount = adjustedSubTotal + taxAmount + adjustedDelivery;
    }
    walletApplied = 0;
    cashToPay = totalAmount;

    if (useWallet && walletBalance > 0) {
      double applied = totalAmount.clamp(0, walletBalance);
      walletApplied = applied;
      cashToPay = (totalAmount - walletApplied).clamp(0, double.infinity);
    }
    update();
  }

  void toggleOrderDiscount(Discount discount) {
    final error = getDiscountErrorMessage(discount: discount, validationAmount: deductibleTotal, isOrder: true);
    if (error != null) {
      discountErrorMessage = error;
      selectedOrderDiscounts = [];
      update();
    } else {
      discountErrorMessage = null;
      if (orderCheckoutData?.allowMultipleDiscount == true) {
        selectedOrderDiscounts.contains(discount) ? selectedOrderDiscounts.remove(discount) : selectedOrderDiscounts.add(discount);
      } else {
        selectedOrderDiscounts = [discount];
      }
      updateCartTotal();
    }
    update();
  }

  void toggleDeliveryDiscount(Discount discount) {
    final error = getDiscountErrorMessage(discount: discount, validationAmount: deductibleTotal, isOrder: false);
    if (error != null) {
      discountErrorMessage = error;
      selectedDeliveryDiscounts = [];
      update();
    } else {
      discountErrorMessage = null;
      if (orderCheckoutData?.allowMultipleDiscount == true) {
        selectedDeliveryDiscounts.contains(discount) ? selectedDeliveryDiscounts.remove(discount) : selectedDeliveryDiscounts.add(discount);
      } else {
        selectedDeliveryDiscounts = [discount];
      }
      updateCartTotal();
    }
    update();
  }

  void togglePaymentToken(PaymentType payment) {
    selectedPaymentType = payment;
    if (AppConstants.deliveryByPaymentMethod) {
      switch (payment.id) {
        case 1:
          deliveryFees = orderCheckoutData?.deliveryDetails?.fees ?? 0;
          break;
        case 2:
          deliveryFees = orderCheckoutData?.deliveryDetails?.creditCardFees ?? 0;
          break;
      }
    }
    updateCartTotal();
    update();
  }

  String? getDiscountErrorMessage({required Discount discount, required double validationAmount, bool isOrder = false}) {
    if (!isOrder && selectedPaymentType == null) {
      return "selectPaymentMethodFirst".tr;
    }

    if (discount.minimumOrderAmount != null && validationAmount < discount.minimumOrderAmount!) {
      return "${'minimumSubTotal'.tr} ${discount.minimumOrderAmount!.toStringAsFixed(2)}";
    }

    if (discount.method == 2) {
      final rules = discount.conditionalRules;
      if (rules == null || rules.isEmpty) {
        return "This discount has no valid rules configured";
      }

      final validRangeText = rules
          .map((r) {
            return "${r.fromValue?.toStringAsFixed(2)} - ${r.toValue?.toStringAsFixed(2)}";
          })
          .join(", ");

      final isValid = rules.any((rule) => validationAmount >= (rule.fromValue ?? 0) && validationAmount <= (rule.toValue ?? 0));

      if (!isValid) {
        return "${'subTotalFromTo'.tr} $validRangeText";
      }
    }

    return null;
  }

  double _calculateTotalDiscountAmount({required double validationAmount, required double applyAmount, required List<Discount> discounts}) {
    double totalDiscount = 0.0;

    for (final discount in discounts) {
      if (discount.minimumOrderAmount != null && validationAmount < discount.minimumOrderAmount!) {
        continue;
      }

      if (discount.method == 1) {
        if (discount.type == 1) {
          totalDiscount += applyAmount * (discount.value ?? 0);
        } else if (discount.type == 2) {
          totalDiscount += discount.value ?? 0;
        }
      } else if (discount.method == 2) {
        for (final rule in discount.conditionalRules ?? []) {
          if (validationAmount >= rule.fromValue && validationAmount <= rule.toValue) {
            if (rule.discountTypeId == 1) {
              totalDiscount += applyAmount * (rule.discountValue ?? 0);
            } else if (rule.discountTypeId == 2) {
              totalDiscount += rule.discountValue ?? 0;
            }
          }
        }
      }
    }

    return totalDiscount;
  }

  void applySingleDiscountsIfNeeded() {
    if (orderCheckoutData != null && orderCheckoutData!.allowMultipleDiscount == false) {
      final orderDiscounts = orderCheckoutData!.discounts;
      final deliveryDiscounts = orderCheckoutData!.deliveryDetails?.discounts;

      if (orderDiscounts != null && orderDiscounts.length == 1) {
        selectedOrderDiscounts = [orderDiscounts.first];
      }
      if (deliveryDiscounts != null && deliveryDiscounts.length == 1 && !isPickUp) {
        selectedDeliveryDiscounts = [deliveryDiscounts.first];
      }
    }
  }

  Future<void> createOrderAction() async {
    if (selectedPaymentType == null) {
      Scrollable.ensureVisible(paymentShakeKey.currentContext!);
      paymentShakeKey.currentState?.shake();
      SharedHelper().errorSnackBar("selectPaymentMethod".tr);
    } else {
      SharedHelper().scaleDialog(const LoadingWidget(), dismissible: false);
      Map<String, dynamic> body = {
        "BrandId": "${AppConstants.brandId}",
        "ApplicationId": "${AppConstants.applicationId}",
        "DeliveryMethodId": isPickUp ? 2 : 1,
        "PaymentMethodId": selectedPaymentType!.id,
        "DontCallToConfirm": callMeToConfirm,
        "IsScheduled": false,
        "OrderItems": buildOrderItemsFromCart(products),
      };
      body.putIfAbsent(isPickUp ? "BranchId" : "ShippingAddressId", () => isPickUp ? "${selectedBranch!.id}" : "${customerAddress!.id}");
      if (redeemPoints) {
        body.putIfAbsent("DeductFromBalance", () => true);
      }
      if (useWallet) {
        body.putIfAbsent("UseWallet", () => true);
      }
      if (noteController.text.isNotEmpty) {
        body.putIfAbsent("SpecialInstructions", () => noteController.text);
      }
      if (selectedOrderDiscounts.isNotEmpty) {
        final hasValidOrderDiscount = selectedOrderDiscounts.any(
          (discount) => getDiscountErrorMessage(discount: discount, validationAmount: deductibleTotal, isOrder: true) == null,
        );
        if (hasValidOrderDiscount) {
          body.putIfAbsent("CartDiscounts", () => selectedOrderDiscounts.map((e) => e.id).toList());
        }
      }
      if (selectedDeliveryDiscounts.isNotEmpty) {
        final hasValidDeliveryDiscount = selectedDeliveryDiscounts.any(
          (discount) => getDiscountErrorMessage(discount: discount, validationAmount: deductibleTotal, isOrder: false) == null,
        );
        if (hasValidDeliveryDiscount) {
          body.putIfAbsent("DeliveryFeesDiscounts", () => selectedDeliveryDiscounts.map((e) => e.id).toList());
        }
      }

      await createOrderUsecase.repository
          .createOrder(body: body)
          .then(
            (value) => value.fold(
              (failure) {
                SharedHelper().closeAllDialogs();
                SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
              },
              (createOrder) {
                if (createOrder.isSucceeded ?? false) {
                  if (selectedPaymentType!.id == 2 && createOrder.data?.paymentInfo?.paymentToken != null) {
                    SharedHelper().closeAllDialogs();
                    payWithPayMob(
                      paymentToken: createOrder.data!.paymentInfo!.paymentToken!,
                      onSuccessful: () => orderDone(),
                      onRejected: () => orderFail(),
                      onPending: () => orderPending(),
                    );
                    // _getPaymentResponse(createOrder.data!.paymentInfo!.paymentToken!, 'test');
                  } else {
                    orderDone();
                  }
                } else {
                  productUnavailable(createOrder);
                }
              },
            ),
          );
      print(jsonEncode(body));
    }
  }

  List<Map<String, dynamic>> buildOrderItemsFromCart(List<CartProduct> cartProducts) {
    return cartProducts.map((cartItem) {
      final product = cartItem.productDetails;

      final List<Map<String, dynamic>> modifierOptions = cartItem.selectedOptions
          .expand((opt) {
            final selected = opt.selectedOption;
            if (selected is ModifierOption) {
              return [selected];
            } else if (selected is List<ModifierOption>) {
              return selected;
            } else {
              return [];
            }
          })
          .map((modifier) => {"Id": modifier.id, "Quantity": "1"})
          .toList();

      return {
        "Id": product.id,
        "Quantity": cartItem.quantity,
        if (cartItem.selectedCategory != null) "CategoryId": cartItem.selectedCategory!.id,
        if (cartItem.notes != null && cartItem.notes != '') "SpecialInstructions": cartItem.notes ?? '',
        "ModifierOptions": modifierOptions,
      };
    }).toList();
  }

  bool exceedsMaximumAllowedPrice(double total, CartProduct product) {
    final max = product.productDetails.maximumPurchaseAmount ?? 0;
    if (max <= 0) return false;
    return total > max;
  }

  void showExceededMaximumPurchaseAmountPopUp(CartProduct product) {
    SharedHelper().actionDialog(
      "title",
      "${'limitationTex'.tr} ${formatAmountWithCurrency(product.productDetails.maximumPurchaseAmount ?? 0)}",
      noCancel: true,
      confirm: () {
        Get.back();
      },
    );
  }

  double basePriceTotal(CartProduct product) {
    final sizeOption = product.selectedOptions.firstWhereOrNull((opt) => opt.modifier.type == 5)?.selectedOption;
    if (sizeOption is ModifierOption) {
      return sizeOption.price ?? 0;
    }

    final productDetails = product.productDetails;
    return (productDetails.offerPrice != null && productDetails.offerPrice! > 0) ? productDetails.offerPrice! : productDetails.price ?? 0;
  }

  bool addQuantity(CartProduct product) {
    final sameProductList = products.where((element) => element.productDetails.id == product.productDetails.id);

    double currentTotal = 0;
    for (final item in sameProductList) {
      final itemBasePrice = basePriceTotal(item);
      currentTotal += itemBasePrice * item.quantity;
    }

    final newItemBasePrice = basePriceTotal(product);
    final total = currentTotal + newItemBasePrice;
    if (exceedsMaximumAllowedPrice(total, product)) {
      showExceededMaximumPurchaseAmountPopUp(product);
      return false;
    }

    return true;
  }

  void orderDone() {
    SharedHelper().closeAllDialogs();
    removeAllItems();
    Get.offAllNamed(RouteConstant.mainPage);
    SharedHelper().actionDialog(
      isRowStyle: false,
      "orderReceived",
      "orderText",
      height: Get.height * .2,
      hasImage: true,
      image: AssetsConsts.done,
      isCenter: true,
      isLocalImage: true,
      confirmText: "done",
      cancelText: "orderHistory",
      confirm: () {
        SharedHelper().closeAllDialogs();
      },
      cancel: () {
        SharedHelper().closeAllDialogs();
        Get.toNamed(RouteConstant.orderHistoryPage);
      },
    );
  }

  void orderPending() {
    SharedHelper().closeAllDialogs();
    removeAllItems();
    Get.offAllNamed(RouteConstant.mainPage);
    SharedHelper().actionDialog(
      "orderPending",
      "paymentPendingMessage",
      height: Get.height * .2,
      hasImage: true,
      image: AssetsConsts.pending,
      isCenter: true,
      isLocalImage: true,
      confirmText: "done",
      confirm: () {
        SharedHelper().closeAllDialogs();
      },
      cancel: () {
        SharedHelper().closeAllDialogs();
        Get.toNamed(RouteConstant.orderHistoryPage);
      },
    );
  }

  void orderFail() {
    SharedHelper().closeAllDialogs();
    SharedHelper().actionDialog(
      "orderFailed",
      "paymentFailedMessage",
      height: Get.height * .3,
      hasImage: true,
      image: AssetsConsts.paymentFailed,
      isCenter: true,
      isLocalImage: true,
      noCancel: true,
      confirmText: "done",
      confirm: () {
        SharedHelper().closeAllDialogs();
      },
    );
  }

  void orderCancel() {
    SharedHelper().closeAllDialogs();
    SharedHelper().actionDialog(
      "orderCanceled",
      "orderCanceledMessage",
      height: Get.height * .3,
      hasImage: true,
      image: AssetsConsts.paymentFailed,
      isCenter: true,
      isLocalImage: true,
      noCancel: true,
      confirmText: "done",
      confirm: () {
        SharedHelper().closeAllDialogs();
      },
    );
  }

  void productUnavailable(ApiResponse<CreateOrder> value) {
    String unavailableItemText = buildUnavailableItemsMessage(value.data?.unavailableItems ?? []);
    SharedHelper().closeAllDialogs();
    SharedHelper().actionDialog(
      "",
      "${value.errors?.first.errorMessage ?? ""} $unavailableItemText",
      height: Get.height * .25,
      hasImage: true,
      image: AssetsConsts.noItems,
      isCenter: true,
      isLottieImage: true,
      isLocalImage: true,
      confirmText: "done",
      noCancel: true,
      confirm: () {
        SharedHelper().closeAllDialogs();
      },
    );
  }

  String buildUnavailableItemsMessage(List<UnavailableItems> items) {
    final buffer = StringBuffer();
    for (final item in items) {
      final productName = item.name ?? '';
      final options = item.unavailableModifierOption ?? [];

      if (options.isEmpty) {
        buffer.writeln("- $productName ${'Unavailable'.tr}");
      } else {
        buffer.writeln("- $productName ${'Available'.tr}");
        for (final option in options) {
          buffer.writeln("  -- ${option.name ?? ''} ${'Unavailable'.tr}");
        }
      }
    }
    return buffer.toString();
  }

  Future<void> checkOrderStatus() async {
    Map<String, dynamic> body = {"ApplicationId": "${AppConstants.applicationId}", "BrandId": "${AppConstants.brandId}"};
    await checkOrderingStatus.repository
        .checkOrderingStatus(body: body)
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (orderStatus) {
              orderingStatus = orderStatus;
              update();
            },
          ),
        );
  }

  void toggleWalletPayment() {
    useWallet = !useWallet;
    updateCartTotal();
  }

  // static const platform = MethodChannel("com.mozaicis.arabica/getPaymentMethod");
  //
  // Future<void> _getPaymentResponse(String checkoutID, String mode) async {
  //   print("Start ONLINE ORDER");
  //   try {
  //     var result = await platform.invokeMethod('getPaymentMethod', checkoutID);
  //     log('getPaymentMethod: ${result.toString()}', name: 'Payment Mohd');
  //     handleResponse(checkoutID, result.toString());
  //   } on PlatformException catch (e) {
  //     print("Failed to get payment metohd: '${e.message}'.");
  //   }
  // }
  //
  // handleResponse(String checkoutID, String response) {
  //   List<String> list = response.split('#');
  //   print('handleResponse ${list}');
  //   print(list[0]);
  //   if (list[0] == 'SYNC') {
  //     checkPaymentStatusApi(paymentToken: checkoutID);
  //   } else if (list[0] == 'ASYNC') {
  //     checkPaymentStatusApi(paymentToken: checkoutID);
  //   } else if (list[0] == 'CANCEL') {
  //     cancelOrderPaymentApi(paymentToken: checkoutID);
  //   } else if (list[0] == 'FAIL') {
  //     logPaymentFailureApi(paymentToken: checkoutID, mobileSDKLog: list[1]);
  //   } else if (list[0] == 'ERROR') {
  //     logPaymentFailureApi(paymentToken: checkoutID, mobileSDKLog: list[1]);
  //   } else {
  //     logPaymentFailureApi(paymentToken: checkoutID, mobileSDKLog: list[1]);
  //   }
  // }
  //
  // Future<void> checkPaymentStatusApi({required String paymentToken}) async {
  //   Map<String, dynamic> body = {"PaymentToken": paymentToken};
  //   await checkOrderPaymentStatus.repository
  //       .checkOrderPaymentStatus(body: body)
  //       .then(
  //         (value) => value.fold(
  //           (failure) {
  //             SharedHelper().closeAllDialogs();
  //             SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
  //           },
  //           (paymentStatus) {
  //             SharedHelper().closeAllDialogs();
  //             switch (paymentStatus.paymentStatus) {
  //               case 1: //Pending
  //                 orderPending();
  //                 break;
  //               case 2: //Success
  //                 orderDone();
  //                 break;
  //               default: //Fail
  //                 orderFail();
  //                 break;
  //             }
  //           },
  //         ),
  //       );
  // }
  //
  // Future<void> cancelOrderPaymentApi({required String paymentToken}) async {
  //   Map<String, dynamic> body = {"PaymentToken": paymentToken};
  //   await cancelOrderPayment.repository
  //       .cancelOrderPayment(body: body)
  //       .then(
  //         (value) => value.fold(
  //           (failure) {
  //             SharedHelper().closeAllDialogs();
  //             SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
  //           },
  //           (cancel) {
  //             SharedHelper().closeAllDialogs();
  //             orderCancel();
  //           },
  //         ),
  //       );
  // }
  //
  // Future<void> logPaymentFailureApi({required String paymentToken, mobileSDKLog}) async {
  //   Map<String, dynamic> body = {"PaymentToken": paymentToken, "MobileSDKLog": mobileSDKLog};
  //   await logPaymentFailure.repository
  //       .logPaymentFailure(body: body)
  //       .then(
  //         (value) => value.fold(
  //           (failure) {
  //             SharedHelper().closeAllDialogs();
  //             SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
  //           },
  //           (paymentStatus) {
  //             SharedHelper().closeAllDialogs();
  //             orderFail();
  //           },
  //         ),
  //       );
  // }
}
