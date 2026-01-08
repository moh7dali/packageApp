import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/loyalty/presentation/widgets/point_history_loading_widget.dart';
import 'package:my_custom_widget/features/loyalty/presentation/widgets/point_history_widget.dart';

import '../../../../shared/widgets/no_item_widget.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../domain/entity/user_balance_history.dart';
import '../getx/points_controller.dart';

class PointsHistoryTab extends StatelessWidget {
  final UserBalanceHistoryController controller;

  const PointsHistoryTab({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<UserBalanceHistory>(
      scrollController: controller.scrollController,
      refreshFunction: () {
        controller.getUserLoyaltyDataApi(isRefresh: true);
      },
      loadFirstList: () async => controller.getUserBalanceHistoryApi(page: 1),
      loadMoreList: (page) async => controller.getUserBalanceHistoryApi(page: page),
      emptyText: 'emptyPoints'.tr,
      itemBuilder: (context, value) => PointHistoryWidget(userBalanceHistory: value),
      loadingWidget: const PointHistoryLoadingWidget(),
      emptyWidget: const NoItemWidget(),
    );
  }
}
