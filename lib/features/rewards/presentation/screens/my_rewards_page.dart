import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/core/utils/translate/translation.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/presentation/getx/rewards_controller.dart';
import 'package:mozaic_loyalty_sdk/shared/widgets/no_item_widget.dart';

import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../domain/entity/user_rewards.dart';
import '../widgets/rewards_card_widget.dart';
import '../widgets/user_rewards_loading_widget.dart';

class MyRewardsPage extends StatelessWidget {
  const MyRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SDKRewardsController>(
      init: SDKRewardsController(),
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
                emptyText: 'emptyRewards'.sdkTr,
              ),
            ),
          ],
        );
      },
    );
  }
}
