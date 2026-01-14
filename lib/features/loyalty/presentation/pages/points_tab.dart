import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/presentation/widgets/loyalty_card_loading_widget.dart';
import 'package:mozaic_loyalty_sdk/features/loyalty/presentation/widgets/new_loyalty_card_widget.dart';
import 'package:mozaic_loyalty_sdk/shared/widgets/no_item_widget.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../domain/entity/user_balance_history.dart';
import '../getx/points_controller.dart';
import '../widgets/point_history_loading_widget.dart';
import '../widgets/point_history_widget.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserBalanceHistoryController>(
      init: UserBalanceHistoryController(context: context),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text("myPoints".tr.toUpperCase())),
          body: GetBuilder<UserBalanceHistoryController>(
            init: UserBalanceHistoryController(context: context),
            builder: (controller) {
              return RefreshIndicator(
                color: AppTheme.primaryColor,
                onRefresh: () async {
                  await Future.delayed(Duration(milliseconds: 500));
                  controller.getUserLoyaltyDataApi(isRefresh: true);
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: controller.scrollController,
                  child: Column(
                    children: [
                      controller.isLoadingLoyalty ? const LoyaltyCardLoading() : NewLoyaltyCardWidget(controller: controller),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: AppTheme.gradient1,
                                borderRadius: AppTheme.bigBorderRadius,
                                border: Border.all(color: AppTheme.whiteColor.withOpacity(0.16)),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 16, offset: const Offset(0, 8))],
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppTheme.whiteColor.withOpacity(0.10),
                                  borderRadius: AppTheme.bigBorderRadius,
                                  border: Border.all(color: AppTheme.whiteColor.withOpacity(0.16)),
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.10), blurRadius: 16, offset: const Offset(0, 8))],
                                ),
                                child: Text(
                                  'loyaltyTransactions'.tr,
                                  style: AppTheme.textStyle(color: AppTheme.bgThemeColor, size: AppTheme.size16, isBold: true),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      controller.isLoadingLoyalty
                          ? ListView.builder(
                              itemCount: 4,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return PointHistoryLoadingWidget();
                              },
                            )
                          : PaginationListView<UserBalanceHistory>(
                              scrollController: controller.scrollController,
                              loadFirstList: () async => await controller.getUserBalanceHistoryApi(page: 1),
                              loadMoreList: (page) async => await controller.getUserBalanceHistoryApi(page: page),
                              emptyText: 'emptyPoints'.tr,
                              itemBuilder: (context, value) => PointHistoryWidget(userBalanceHistory: value),
                              loadingWidget: const PointHistoryLoadingWidget(),
                              emptyWidget: NoItemWidget(),
                            ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
