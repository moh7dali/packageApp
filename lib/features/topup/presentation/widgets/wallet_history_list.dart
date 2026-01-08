import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/topup/presentation/widgets/top_up_history_widget.dart';

import '../../../../shared/widgets/no_item_widget.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../../loyalty/presentation/getx/points_controller.dart';
import '../../../notifications/presentation/widgets/notification_card_loading.dart';
import '../../domain/entities/top_up_history.dart';

class WalletHistoryTab extends StatelessWidget {
  final UserBalanceHistoryController controller;

  const WalletHistoryTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<TopUpHistory>(
      refreshFunction: () {
        controller.getUserLoyaltyDataApi(isRefresh: true);
      },
      scrollController: controller.scrollController,
      loadFirstList: () async => controller.getTopUpHistoryApi(page: 1),
      loadMoreList: (page) async => controller.getTopUpHistoryApi(page: page),
      itemBuilder: (context, value) => TopUpHistoryWidget(value: value),
      emptyWidget: const NoItemWidget(),
      emptyText: "emptyList".tr,
      loadingWidget: const NotificationCardLoading(),
    );
  }
}
