import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/rewards/presentation/widgets/user_rewards_loading_widget.dart';
import 'package:my_custom_widget/features/topup/domain/entities/top_up_list.dart';
import 'package:my_custom_widget/features/topup/presentation/getx/top_up_list_controller.dart';
import 'package:my_custom_widget/features/topup/presentation/widgets/top_up_card_widget.dart';

import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/widgets/no_item_widget.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../widgets/top_up_details_widget.dart';

class TopUpListPage extends StatelessWidget {
  const TopUpListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopUpListController>(
      init: TopUpListController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: Text('topUp'.tr)),
          body: PaginationListView<TopUp>(
            loadFirstList: () async => await controller.getTopUpApi(page: 1),
            loadMoreList: (page) async => controller.getTopUpApi(page: page),
            itemBuilder: (context, value) => GestureDetector(
              onTap: () => SharedHelper().bottomSheet(TopUpDetailsSheet(topUp: value), isScrollControlled: true),
              child: TopUpCardWidget(topUp: value),
            ),
            emptyWidget: NoItemWidget(),
            emptyText: "emptyList".tr,
            loadingWidget: UserRewardsLoadingWidget(),
          ),
        );
      },
    );
  }
}
