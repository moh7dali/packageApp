import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/features/rewards/domain/entity/campaign_details.dart';
import 'package:mozaic_loyalty_sdk/shared/widgets/no_item_widget.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_routes.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../getx/rewards_controller.dart';
import '../widgets/reward_widget.dart';
import '../widgets/user_rewards_loading_widget.dart';

class OccasionRewards extends StatelessWidget {
  const OccasionRewards({super.key, required this.categoriesId});

  final String categoriesId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardsController>(
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: PaginationListView<CampaignDetails>(
                loadFirstList: () async => controller.getCampaignListApi(page: 1, catId: categoriesId),
                loadMoreList: (page) async => controller.getCampaignListApi(page: page, catId: categoriesId),
                itemBuilder: (context, value) => OccasionCampaignCard(
                  campaignDetails: value,
                  onTap: () => SDKNav.toNamed(RouteConstant.campaignRewards, arguments: value),
                ),
                emptyWidget: NoItemWidget(),
                loadingWidget: UserRewardsLoadingWidget(hasImg: false),
                emptyText: 'emptyRewards'.tr,
              ),
            ),
            SizedBox(height: Get.height * .01),
          ],
        );
      },
    );
  }
}
