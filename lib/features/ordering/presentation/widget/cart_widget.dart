import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/core/constants/assets_constants.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/features/ordering/presentation/getx/cart_controller.dart';
import 'package:my_custom_widget/shared/widgets/bottom_widget.dart';
import 'package:my_custom_widget/shared/widgets/button_widget.dart';

import '../../../../core/constants/constants.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/cart_items.dart';
import '../../../../shared/widgets/no_item_widget.dart';
import '../../../../shared/widgets/profile_text_field.dart';
import '../../../../shared/widgets/sar_widget.dart';
import '../../../../shared/widgets/shake_widget.dart';
import '../../../category/domain/entities/product_details.dart';
import '../../../order_method/presentation/widgets/background_image.dart';
import '../../domain/entity/order_checkout_data.dart';

Widget cartListWidget({required List<CartProduct> cartItems, required CartController controller}) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: cartItems.length,
    itemBuilder: (context, index) {
      final product = cartItems[index];
      return CartItemCard(
        cartProduct: product,
        index: index,
        controller: controller,
        onIncrease: () => controller.increaseQuantity(product),
        onDecrease: () => controller.decreaseQuantity(product),
        onRemove: () => controller.removeItem(product),
      );
    },
  );
}

class CartItemCard extends StatelessWidget {
  final CartProduct cartProduct;
  final int index;
  final CartController controller;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemCard({
    super.key,
    required this.cartProduct,
    required this.index,
    required this.controller,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = cartProduct.productDetails.productItemImages?.firstOrNull?.imageUrl ?? '';
    final name = cartProduct.productDetails.name ?? '';
    final note = cartProduct.notes ?? '';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppTheme.bigBorderRadius,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.06), blurRadius: 12, offset: const Offset(0, 6))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductImage(imageUrl),
                const SizedBox(width: 12),

                /// INFO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.trim(),
                        style: AppTheme.textStyle(size: AppTheme.size14, color: AppTheme.textColor, isBold: true),
                      ),
                      const SizedBox(height: 6),

                      CurrencyAmountText(
                        amountText: SharedHelper.getNumberFormat(controller.calculateOneItemPrice(cartProduct)),
                        amountStyle: AppTheme.textStyle(size: AppTheme.size16, color: AppTheme.primaryColor, isBold: true),
                      ),

                      const SizedBox(height: 10),

                      _buildQuantityControls(),
                    ],
                  ),
                ),

                /// REMOVE
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.redColor.withOpacity(.08)),
                    child: Icon(Icons.close, size: 18, color: AppTheme.redColor),
                  ),
                ),
              ],
            ),

            if (cartProduct.selectedOptions.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: cartProduct.selectedOptions.map((opt) {
                  if (opt.selectedOption is ModifierOption) {
                    final option = opt.selectedOption as ModifierOption;
                    return _optionChip('${opt.modifier.displayName}: ${option.name}');
                  } else if (opt.selectedOption is List<ModifierOption>) {
                    final options = opt.selectedOption as List<ModifierOption>;
                    return _optionChip('${opt.modifier.displayName}: ${options.map((e) => e.name).join(', ')}');
                  }
                  return const SizedBox.shrink();
                }).toList(),
              ),
            ],

            if (note.isNotEmpty) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(.05), borderRadius: AppTheme.borderRadius),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.edit_note, size: 18, color: AppTheme.primaryColor),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        note,
                        style: AppTheme.textStyle(size: AppTheme.size12, color: AppTheme.textColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return ClipRRect(
      borderRadius: AppTheme.borderRadius,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 80,
        height: 80,
        fit: BoxFit.cover,
        placeholder: (_, __) => Image.asset(AssetsConsts.loading, fit: BoxFit.cover),
        errorWidget: (_, __, ___) => Image.asset(AssetsConsts.imageError, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildQuantityControls() {
    return Container(
      decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(.06), borderRadius: BorderRadius.circular(100)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _qtyBtn(cartProduct.quantity > 1 ? Icons.remove : Icons.delete, onDecrease),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              cartProduct.quantity.toString(),
              style: AppTheme.textStyle(size: AppTheme.size14, isBold: true, color: AppTheme.primaryColor),
            ),
          ),
          _qtyBtn(Icons.add, onIncrease),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(icon, size: 16, color: AppTheme.primaryColor),
      ),
    );
  }

  Widget _optionChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(.08), borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: AppTheme.textStyle(size: AppTheme.size12, color: AppTheme.primaryColor),
      ),
    );
  }
}

Widget orderMethod({required CartController controller}) {
  return Column(
    children: [
      // Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      //   child: Row(
      //     children: [
      //       Text(
      //         "orderMethod".tr,
      //         style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
      //       ),
      //     ],
      //   ),
      // ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Card(
          elevation: 2,
          child: Column(
            children: [
              BackgroundImageWidget(title: "pickUpFrom", isBig: false),
              SizedBox(height: 10),
              Row(
                children: [
                  controller.isPickUp
                      ? Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${controller.selectedBranch?.name}",
                                style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size18),
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${controller.customerAddress?.name},${controller.customerAddress?.address}",
                                    style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size18),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget paymentType({required CartController controller}) {
  final paymentTypes = controller.orderCheckoutData?.availablePaymentTypes ?? [];

  if (paymentTypes.isEmpty) {
    return Container();
  }
  return ShakeWidget(
    key: controller.paymentShakeKey,
    shakeOffset: 10,
    shakeCount: 2,
    shakeDuration: const Duration(milliseconds: 800),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          child: Row(
            children: [
              Text(
                "paymentMethod".tr,
                style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
              ),
            ],
          ),
        ),
        Card(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: paymentTypes.length,
            itemBuilder: (context, index) {
              final payment = paymentTypes[index];
              final isCard = payment.name?.toLowerCase().contains("credit card") ?? false;
              final isCash = payment.name?.toLowerCase().contains("cash") ?? false;
              return RadioListTile<PaymentType>(
                value: payment,
                groupValue: controller.selectedPaymentType,
                onChanged: (value) {
                  controller.togglePaymentToken(value!);
                },
                title: Row(
                  children: [
                    if (isCash) ...[
                      Image.asset(AssetsConsts.cashIcon, height: Get.height * .05, color: AppTheme.textColor),
                      const SizedBox(width: 8),
                    ] else if (isCard) ...[
                      Image.asset(AssetsConsts.creditIcon, height: Get.height * .05, color: AppTheme.textColor),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Text(
                        payment.name ?? '',
                        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                      ),
                    ),
                  ],
                ),
                secondary: isCard
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AssetsConsts.masterIcon, width: 40, height: 30, fit: BoxFit.contain),
                          const SizedBox(width: 8),
                          Image.asset(AssetsConsts.visaIcon, width: 40, height: 30, fit: BoxFit.contain),
                        ],
                      )
                    : null,
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget specialInstructions({required CartController controller}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: Row(
          children: [
            Text(
              "note".tr,
              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
            ),
          ],
        ),
      ),
      ProfileTextField(
        label: 'note',
        showLabelAsHeader: false,
        textAlign: TextAlign.center,
        type: TextInputType.multiline,
        controller: controller.noteController,
        padding: EdgeInsets.symmetric(vertical: Get.height * .075, horizontal: 16),
        isBigRad: false,
        maxLength: 300,
        maxLine: 5,
        shakeKey: controller.noteShakeKey,
      ),
    ],
  );
}

Widget orderSummary({required CartController controller}) {
  bool isPaymentSelected = controller.selectedPaymentType != null;
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: Row(
          children: [
            Text(
              "orderSummary".tr,
              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
            ),
          ],
        ),
      ),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Subtotal
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'subTotal'.tr,
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                    ),
                  ),
                  CurrencyAmountText(
                    amountText: SharedHelper.getNumberFormat(controller.subTotal),
                    amountStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // Delivery fee (already using buildDeliveryFeesText)
              Visibility(
                visible: !controller.isPickUp,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'deliveryFee'.tr,
                            style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                          ),
                        ),
                        buildDeliveryFeesText(isPaymentSelected, controller),
                      ],
                    ),
                  ],
                ),
              ),

              // Tax row
              Visibility(
                visible: controller.taxRate > 0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${'tax'.tr} ( ${SharedHelper.getNumberFormat(controller.taxRate * 100)}% )',
                        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                      ),
                    ),
                    CurrencyAmountText(
                      amountText: SharedHelper.getNumberFormat(controller.taxAmount),
                      amountStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                    ),
                  ],
                ),
              ),

              // Order discount
              if (controller.orderDiscountAmount > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "orderDiscount".tr,
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                    ),
                    CurrencyAmountText(
                      amountText: '-${SharedHelper.getNumberFormat(min(controller.orderDiscountAmount, controller.subTotal))}',
                      amountStyle: AppTheme.textStyle(color: AppTheme.redColor),
                    ),
                  ],
                ),

              // Delivery discount
              if (controller.deliveryDiscountAmount > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "deliveryDiscount".tr,
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                    ),
                    CurrencyAmountText(
                      amountText:
                          '-${SharedHelper.getNumberFormat(min(controller.deliveryDiscountAmount, controller.orderCheckoutData?.deliveryDetails?.fees ?? 0))}',
                      amountStyle: AppTheme.textStyle(color: AppTheme.redColor),
                    ),
                  ],
                ),

              const SizedBox(height: 6),

              // Redeem points discount
              Visibility(
                visible: controller.redeemPoints && controller.redeemAmount > 0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "redeemPoints".tr,
                        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14),
                      ),
                    ),
                    CurrencyAmountText(
                      amountText: '-${SharedHelper.getNumberFormat(controller.redeemAmount)}',
                      amountStyle: AppTheme.textStyle(color: AppTheme.redColor, size: AppTheme.size14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6),
              Divider(height: 2, color: Colors.grey.shade400),
              const SizedBox(height: 6),

              // Tax description
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'taxDesc'.tr,
                      textAlign: TextAlign.center,
                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size12),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
              Divider(height: 2, color: Colors.grey.shade400),
              const SizedBox(height: 8),

              // Final amount
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'finalAmount'.tr,
                      style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
                    ),
                    CurrencyAmountText(
                      amountText: SharedHelper.getNumberFormat(controller.totalAmount),
                      amountStyle: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
                    ),
                  ],
                ),
              ),

              // Wallet usage
              if (controller.useWallet && controller.walletApplied > 0) ...[
                Divider(height: 2, color: Colors.grey.shade200),
                const SizedBox(height: 8),

                // Cash to pay (card or cash)
                Visibility(
                  visible: controller.cashToPay > 0 && controller.selectedPaymentType != null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (controller.selectedPaymentType?.id == 2) ? 'youWillPayByCard'.tr : 'youWillPayInCash'.tr,
                        style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
                      ),
                      CurrencyAmountText(
                        amountText: SharedHelper.getNumberFormat(controller.cashToPay),
                        amountStyle: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
                      ),
                    ],
                  ),
                ),

                // Wallet applied
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'youWillPayFromWallet'.tr,
                      style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
                    ),
                    CurrencyAmountText(
                      amountText: SharedHelper.getNumberFormat(controller.walletApplied),
                      amountStyle: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size14),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    ],
  );
}

Widget? bottomNavBarWidget({required CartController controller}) {
  bool isEmpty = controller.products.isEmpty;
  if (isEmpty) return null;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                SharedHelper().bottomSheet(
                  BottomWidget(
                    title: 'cancelOrder'.tr,
                    description: 'cancelCartBody'.tr,
                    onCancel: () {
                      SharedHelper().closeAllDialogs();
                    },
                    onConfirm: () {
                      controller.removeAllItems();
                      SharedHelper().closeAllDialogs();
                    },
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(Icons.delete_outline, size: 30, color: AppTheme.textColor),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: Get.width * .75,
              child: AppButton(
                title: "orderNow".tr,
                isDoneBtn: controller.orderingStatus?.isOrderingEnabled ?? false,
                function: () {
                  if (controller.orderingStatus?.isOrderingEnabled ?? false) {
                    controller.createOrderAction();
                  } else {
                    controller.errorShakeKey.currentState!.shake();
                    Future.delayed(Duration(milliseconds: 100), () {
                      if (controller.cantOrderCardKey.currentContext != null) {
                        Scrollable.ensureVisible(
                          controller.cantOrderCardKey.currentContext!,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          alignment: 0.2, // optional: how far down the screen it should appear
                        );
                      }
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget loadingCart() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [CircularProgressIndicator(color: AppTheme.primaryColor)],
    ),
  );
}

Widget noCart() {
  return Column(
    children: [
      NoItemWidget(),
      SizedBox(height: Get.height * .02),
      Text(
        "noItems".tr,
        style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size18),
      ),
    ],
  );
}

Widget orderDiscounts({required CartController controller}) {
  return Column(
    children: [
      if ((controller.orderCheckoutData?.discounts ?? []).isNotEmpty)
        discountSection(
          title: "orderDiscount".tr,
          discounts: controller.orderCheckoutData?.discounts ?? [],
          selectedDiscounts: controller.selectedOrderDiscounts,
          onToggle: controller.toggleOrderDiscount,
          controller: controller,
        ),
      if (((controller.orderCheckoutData?.deliveryDetails?.discounts ?? []).length > 1) && !controller.isPickUp)
        discountSection(
          title: "deliveryDiscount".tr,
          discounts: controller.orderCheckoutData?.deliveryDetails?.discounts ?? [],
          selectedDiscounts: controller.selectedDeliveryDiscounts,
          onToggle: controller.toggleDeliveryDiscount,
          controller: controller,
        ),
    ],
  );
}

Widget discountSection({
  required List<Discount> discounts,
  required List<Discount> selectedDiscounts,
  required String title,
  required Function(Discount) onToggle,
  required CartController controller,
}) {
  if (discounts.isEmpty) return const SizedBox();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
        child: Text(
          title.tr,
          style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size16),
        ),
      ),
      SizedBox(
        height: Get.height * .12,
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: discounts.length,
                itemBuilder: (context, index) {
                  final discount = discounts[index];
                  final isSelected = selectedDiscounts.contains(discount);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () => onToggle(discount),
                      child: Material(
                        shape: const TicketShapeBorder(),
                        color: isSelected ? AppTheme.primaryColor.withOpacity(0.25) : AppTheme.primaryColor.withOpacity(0.1),
                        child: Container(
                          width: Get.width * 0.5,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      discount.description ?? "",
                                      style: AppTheme.textStyle(color: AppTheme.textColor, isBold: true, size: AppTheme.size12),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(color: Colors.grey.shade200, shape: BoxShape.circle),
                                    child: Icon(isSelected ? Icons.check : Icons.add, size: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              LayoutBuilder(
                                builder: (context, constraints) => Row(
                                  children: List.generate(
                                    (constraints.maxWidth / 6).floor(),
                                    (index) => Container(width: 3, height: 1, color: Colors.grey, margin: const EdgeInsets.symmetric(horizontal: 1)),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: discountDisplayWidget(discount, AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14)),
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(onTap: () => _showDiscountDetailsBottomSheet(discount), child: Icon(Icons.info_outline, size: 18)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      if (controller.discountErrorMessage != null)
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 6),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.discountErrorMessage!,
                  style: AppTheme.textStyle(color: Colors.red, size: AppTheme.size12),
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget walletAndTopUp({required CartController controller}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 2),
    child: Column(
      children: [
        if (controller.hasWallet)
          GestureDetector(
            onTap: () {
              controller.toggleWalletPayment();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: controller.useWallet ? AppTheme.primaryColor.withOpacity(0.16) : AppTheme.whiteColor,
                border: Border.all(color: controller.useWallet ? AppTheme.whiteColor : AppTheme.greyColor.withOpacity(.35)),
                borderRadius: AppTheme.bigBorderRadius,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.wallet_outlined, color: AppTheme.primaryColor, size: Get.height * .05),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "useWallet".tr,
                              style: AppTheme.textStyle(color: AppTheme.textColor.withOpacity(.75), size: AppTheme.size12),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${"balance".tr}: ",
                                  style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                                ),
                                CurrencyAmountText(
                                  amountText: SharedHelper.getNumberFormat(controller.orderCheckoutData?.customerInfo?.loyaltyData?.wallet ?? 0),
                                  amountStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Switch(
                      value: controller.useWallet,
                      onChanged: (value) {
                        controller.toggleWalletPayment();
                      },
                      activeColor: AppTheme.primaryColor,
                      inactiveThumbColor: AppTheme.primaryColor,
                      inactiveTrackColor: AppTheme.primaryColor.withOpacity(.2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        SizedBox(height: 10),
        if (controller.redeemRate > 0)
          GestureDetector(
            onTap: () {
              controller.redeemPoints = !controller.redeemPoints;
              controller.updateCartTotal();
              controller.update();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              decoration: BoxDecoration(
                color: controller.redeemPoints ? AppTheme.primaryColor.withOpacity(0.16) : AppTheme.whiteColor,
                border: Border.all(color: controller.redeemPoints ? AppTheme.whiteColor : AppTheme.greyColor.withOpacity(.35)),
                borderRadius: AppTheme.bigBorderRadius,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.loyalty_outlined, color: AppTheme.primaryColor, size: Get.height * .05),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "redeemPoints".tr,
                              style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${"balance".tr}: ",
                                  style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                                ),
                                CurrencyAmountText(
                                  amountText: SharedHelper.getNumberFormat(controller.orderCheckoutData?.customerInfo?.loyaltyData?.cashBalance ?? 0),
                                  amountStyle: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14, isBold: true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Switch(
                      value: controller.redeemPoints,
                      onChanged: (value) {
                        controller.redeemPoints = value;
                        controller.updateCartTotal();
                        controller.update();
                      },
                      activeColor: AppTheme.primaryColor,
                      inactiveThumbColor: AppTheme.primaryColor,
                      inactiveTrackColor: AppTheme.primaryColor.withOpacity(.2),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

Widget cantOrderCard({required CartController controller}) {
  return ShakeWidget(
    key: controller.errorShakeKey,
    child: Card(
      key: controller.cantOrderCardKey,
      color: AppTheme.redColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_outlined, color: Colors.yellow, size: AppTheme.size30),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                controller.orderingStatus?.disabledReason ?? "somethingWrong".tr,
                style: AppTheme.textStyle(color: AppTheme.accentColor, size: AppTheme.size14),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget discountDisplayWidget(Discount discount, TextStyle style) {
  if (discount.method == 1) {
    if (discount.type == 1) {
      return Text('${SharedHelper.getNumberFormat((discount.value ?? 0) * 100)} % ', style: style);
    } else if (discount.type == 2) {
      return CurrencyAmountText(amountText: SharedHelper.getNumberFormat(discount.value ?? 0), amountStyle: style);
    }
  } else if (discount.method == 2) {
    final rule = discount.conditionalRules?.firstOrNull;
    if (rule != null) {
      if (rule.discountTypeId == 1) {
        return Text('${SharedHelper.getNumberFormat((rule.discountValue ?? 0) * 100)} % ', style: style);
      } else if (rule.discountTypeId == 2) {
        return CurrencyAmountText(amountText: SharedHelper.getNumberFormat(rule.discountValue ?? 0), amountStyle: style);
      }
    }
  }
  return const SizedBox.shrink();
}

Widget buildDeliveryFeesText(bool isPaymentSelected, CartController controller) {
  final TextStyle normalStyle = AppTheme.textStyle(color: AppTheme.textColor, size: isPaymentSelected ? AppTheme.size14 : AppTheme.size12);

  if (AppConstants.deliveryByPaymentMethod) {
    if (!isPaymentSelected) {
      return Text('selectPaymentMethodFirst'.tr, style: normalStyle);
    }

    final double fees = controller.deliveryFees;
    return CurrencyAmountText(amountText: SharedHelper.getNumberFormat(fees > 0 ? fees : 0), amountStyle: normalStyle);
  } else {
    if (controller.customerAddress == null) {
      return Text('selectAddressFirst'.tr, style: normalStyle);
    }

    final double fees = controller.deliveryFees;
    return CurrencyAmountText(amountText: SharedHelper.getNumberFormat(fees > 0 ? fees : 0), amountStyle: normalStyle);
  }
}

void _showDiscountDetailsBottomSheet(Discount discount) {
  SharedHelper().bottomSheet(
    Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(1000)),
            height: 5,
            width: Get.width * .20,
          ),
          SizedBox(height: Get.height * .03),
          Text(
            discount.description ?? '',
            style: AppTheme.textStyle(size: AppTheme.size18, color: AppTheme.primaryColor, isBold: true),
          ),
          SizedBox(height: Get.height * .03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${'MinimumOrder'.tr} ',
                style: AppTheme.textStyle(size: AppTheme.size16, color: AppTheme.textColor),
              ),
              CurrencyAmountText(
                amountText: SharedHelper.getNumberFormat(discount.minimumOrderAmount ?? 0),
                amountStyle: AppTheme.textStyle(size: AppTheme.size16, color: AppTheme.textColor),
              ),
            ],
          ),
          SizedBox(height: Get.height * .01),
          if (discount.method == 1) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Type'.tr,
                  style: AppTheme.textStyle(size: AppTheme.size14, color: AppTheme.textColor),
                ),
                Text(
                  discount.type == 1 ? "Percentage".tr : "Amount".tr,
                  style: AppTheme.textStyle(size: AppTheme.size14, color: AppTheme.textColor),
                ),
              ],
            ),
            SizedBox(height: Get.height * .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Value'.tr,
                  style: AppTheme.textStyle(size: AppTheme.size14, color: AppTheme.textColor),
                ),
                discountDisplayWidget(discount, AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14)),
              ],
            ),
          ] else if (discount.method == 2 && (discount.conditionalRules?.isNotEmpty ?? false)) ...[
            ...discount.conditionalRules!.map(
              (rule) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'range'.tr,
                        style: AppTheme.textStyle(size: AppTheme.size14, color: AppTheme.textColor),
                      ),
                      Text(
                        '${rule.fromValue} - ${rule.toValue}',
                        style: AppTheme.textStyle(size: AppTheme.size14, color: AppTheme.textColor),
                      ),
                    ],
                  ),
                  SizedBox(height: Get.height * .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Value'.tr, style: AppTheme.textStyle(color: AppTheme.primaryColor)),
                      discountDisplayWidget(discount, AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
          SizedBox(height: Get.height * .03),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppButton(
              title: "done".tr,
              function: () {
                SharedHelper().closeAllDialogs();
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class TicketShapeBorder extends ShapeBorder {
  final double borderRadius;
  final double notchRadius;

  const TicketShapeBorder({this.borderRadius = 12.0, this.notchRadius = 8.0});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  ShapeBorder scale(double t) {
    return TicketShapeBorder(borderRadius: borderRadius * t, notchRadius: notchRadius * t);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();

    final r = borderRadius;
    final n = notchRadius;
    final w = rect.width;
    final h = rect.height;

    path.moveTo(rect.left + r, rect.top);
    path.arcToPoint(Offset(rect.left, rect.top + r), radius: Radius.circular(r), clockwise: false);
    path.lineTo(rect.left, rect.top + h / 2 - n);
    path.arcToPoint(Offset(rect.left, rect.top + h / 2 + n), radius: Radius.circular(n), clockwise: true);
    path.lineTo(rect.left, rect.bottom - r);
    path.arcToPoint(Offset(rect.left + r, rect.bottom), radius: Radius.circular(r), clockwise: false);
    path.lineTo(rect.right - r, rect.bottom);
    path.arcToPoint(Offset(rect.right, rect.bottom - r), radius: Radius.circular(r), clockwise: false);
    path.lineTo(rect.right, rect.top + h / 2 + n);
    path.arcToPoint(Offset(rect.right, rect.top + h / 2 - n), radius: Radius.circular(n), clockwise: true);
    path.lineTo(rect.right, rect.top + r);
    path.arcToPoint(Offset(rect.right - r, rect.top), radius: Radius.circular(r), clockwise: false);
    path.close();

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  bool get prefersPaintInterior => false;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }
}
