import 'package:my_custom_widget/features/ordering/presentation/getx/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/cart_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text("cart".tr)),
          bottomNavigationBar: bottomNavBarWidget(controller: controller),
          body: controller.isLoading
              ? loadingCart()
              : controller.products.isEmpty
              ? noCart()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (!(controller.orderingStatus?.isOrderingEnabled ?? false)) cantOrderCard(controller: controller),
                        cartListWidget(cartItems: controller.products, controller: controller),
                        orderMethod(controller: controller),
                        specialInstructions(controller: controller),
                        orderDiscounts(controller: controller),
                        paymentType(controller: controller),
                        walletAndTopUp(controller: controller),
                        orderSummary(controller: controller),
                        SizedBox(height: Get.height * .1),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
