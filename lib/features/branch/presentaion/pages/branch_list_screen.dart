import 'package:my_custom_widget/features/branch/domain/entities/branch_details.dart';
import 'package:my_custom_widget/features/branch/presentaion/getx/branch_list_controller.dart';
import 'package:my_custom_widget/shared/widgets/no_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';
import '../../../../shared/widgets/pagination_list/pagination_list_view.dart';
import '../../../rewards/presentation/widgets/user_rewards_loading_widget.dart';
import '../widgets/branch_widget.dart';

class BranchListScreen extends StatelessWidget {
  const BranchListScreen({super.key, required this.brandId});

  final int brandId;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BranchListController>(
      init: BranchListController(brandId),
      builder: (controller) => Column(
        children: [
          Container(
            decoration: BoxDecoration(gradient: AppTheme.gradient1),
            height: 20,
          ),
          Expanded(
            child: PaginationListView<BranchDetails>(
              loadFirstList: () async => await controller.getAllBranchesList(page: 1),
              loadMoreList: (page) async => controller.getAllBranchesList(page: page),
              itemBuilder: (context, value) => BranchWidget(value: value),
              emptyWidget: NoItemWidget(),
              loadingWidget: const UserRewardsLoadingWidget(),
              emptyText: 'emptyBranches'.tr,
            ),
          ),
        ],
      ),
    );
  }
}
