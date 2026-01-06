import 'package:my_custom_widget/features/rewards/presentation/getx/rewards_controller.dart';
import 'package:my_custom_widget/shared/widgets/no_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../domain/entity/user_rewards.dart';
import '../widgets/rewards_card_widget.dart';
import '../widgets/user_rewards_loading_widget.dart';

class MyRewardsPage extends StatelessWidget {
  const MyRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardsController>(
      init: RewardsController(),
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: PaginationListView<UserRewards>(
                loadFirstList: () async => controller.getUserRewardsApi(page: 1),
                loadMoreList: (page) async => controller.getUserRewardsApi(page: page),
                itemBuilder: (context, value) => RewardCardWidget(reward: value, isMyRewards: true),
                emptyWidget: NoItemWidget(),
                loadingWidget: UserRewardsLoadingWidget(hasImg: false),
                emptyText: 'emptyRewards'.tr,
              ),
            ),
          ],
        );
      },
    );
  }
}
