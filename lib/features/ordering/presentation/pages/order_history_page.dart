import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_history.dart';
import 'package:my_custom_widget/features/ordering/presentation/getx/order_history_controller.dart';
import 'package:my_custom_widget/features/ordering/presentation/widget/loading_history_widget.dart';
import 'package:my_custom_widget/features/ordering/presentation/widget/order_history_card_widget.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/no_item_widget.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("orderHistory".tr,style: TextStyle(color: AppTheme.primaryColor), ),),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GetBuilder<OrderHistoryController>(
          init: OrderHistoryController(),
          builder: (controller) => PaginationListView<OrderHistory>(
            loadFirstList: () async => await controller.getAllCustomerOrders(page: 1),
            loadMoreList: (page) async => controller.getAllCustomerOrders(page: page),
            itemBuilder: (context, value) => OrderHistoryCardWidget(orderHistory: value),
            emptyWidget: NoItemWidget(isSmall: false),
            loadingWidget: LoadingHistoryCard(isDetails: false),
            emptyText: 'noOrders'.tr,
          ),
        ),
      ),
    );
  }
}
