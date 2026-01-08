import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/topup/presentation/getx/get_customer_wallet_history_controller.dart';
import 'package:my_custom_widget/features/topup/presentation/widgets/wallet_balance_widget.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/no_item_widget.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../../notifications/presentation/widgets/notification_card_loading.dart';
import '../../domain/entities/top_up_history.dart';
import '../widgets/top_up_history_widget.dart';

class TopUpPage extends StatelessWidget {
  const TopUpPage({super.key, required this.walletBalance});

  final double? walletBalance;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetCustomerWalletHistoryController>(
      init: GetCustomerWalletHistoryController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.primaryColor,
            iconTheme: IconThemeData(color: AppTheme.accentColor),
          ),
          body: SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                WalletBalanceWidget(walletBalance: walletBalance),
                SizedBox(height: Get.height * .02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: Row(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(color: AppTheme.primaryColor.withOpacity(0.10), borderRadius: BorderRadius.circular(12)),
                        child: Icon(Icons.receipt_long_rounded, color: AppTheme.primaryColor, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'walletHistory'.tr,
                          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size16, isBold: true),
                        ),
                      ),
                    ],
                  ),
                ),
                PaginationListView<TopUpHistory>(
                  scrollController: controller.scrollController,
                  loadFirstList: () async => await controller.getTopUpHistoryApi(page: 1),
                  loadMoreList: (page) async => controller.getTopUpHistoryApi(page: page),
                  itemBuilder: (context, value) => TopUpHistoryWidget(value: value),
                  emptyWidget: NoItemWidget(),
                  emptyText: "emptyList".tr,
                  loadingWidget: const NotificationCardLoading(),
                ),
                SizedBox(height: Get.height * .02),
              ],
            ),
          ),
        );
      },
    );
  }
}
