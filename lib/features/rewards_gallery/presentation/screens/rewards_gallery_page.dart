import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/entity/reward_gallery.dart';
import 'package:my_custom_widget/shared/widgets/card_loading.dart';
import 'package:my_custom_widget/shared/widgets/no_item_widget.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../getx/rewards_gallery_controller.dart';
import '../widgets/reward_gallery_widget.dart';

class RewardsGalleryPage extends StatelessWidget {
  const RewardsGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardsGalleryController>(
      init: RewardsGalleryController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("rewardsGallery".tr),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Text(
                      "myPoints".tr,
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
                    ),
                    Text(
                      " (${controller.userLoyaltyData?.loyaltyData?.pointsBalance ?? ""})",
                      style: AppTheme.textStyle(color: AppTheme.textColor, size: AppTheme.size12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: PaginationListView<RewardsGallery>(
            loadFirstList: () => controller.getGalleryRewardsApi(page: 1),
            loadMoreList: (page) => controller.getGalleryRewardsApi(page: page),
            itemBuilder: (context, value) => RewardsGalleryWidget(rewardsGallery: value),
            emptyWidget: NoItemWidget(),
            emptyText: "",
            loadingWidget: const CardLoading(),
            refreshFunction: () {
              controller.getUserLoyaltyDataApi();
            },
          ),
        );
      },
    );
  }
}
