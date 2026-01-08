import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/ordering/presentation/getx/order_detail_controller.dart';
import 'package:my_custom_widget/features/ordering/presentation/widget/order_history_card_widget.dart';

import '../../domain/entity/order_history.dart';
import '../widget/loading_history_widget.dart';
import '../widget/order_details_widget.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.orderHistory});

  final OrderHistory orderHistory;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(orderHistory: orderHistory),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text("orderStatus".tr)),
          body: controller.isLoading
              ? LoadingHistoryCard()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        OrderHistoryCardWidget(orderHistory: orderHistory, isDetails: true),
                        listOfProduct(controller),
                        orderWidget(controller),
                        orderSummary(controller.orderDetails),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
