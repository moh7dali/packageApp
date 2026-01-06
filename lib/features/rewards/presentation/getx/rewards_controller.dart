import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/rewards/domain/entity/campaign_details.dart';

import '../../../../core/utils/app_log.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/pagination_list_model.dart';
import '../../domain/entity/user_rewards.dart';
import '../../domain/usecase/get_campaign_list.dart';
import '../../domain/usecase/get_user_rewards.dart';

class RewardsController extends GetxController with GetTickerProviderStateMixin {
  final GetCampaignList getCampaignList;
  final GetUserRewards getUserRewards;

  RewardsController()
      : getCampaignList = sl(),
        getUserRewards = sl();

  TabController? tabController;
  TabController? moreRewardsTabController;

  List<String> pageTabs = ["myRewards", "moreRewards"];
  List<String> moreRewardsTabs = ["occasionRewards", "missions"];

  List<CampaignDetails> campaignList = [];
  List<UserRewards> userRewardsList = [];

  Future<PaginationListModel> getCampaignListApi({int page = 1, required String catId}) async {
    campaignList = [];
    int totalNumberOfResult = 0;
    await getCampaignList.repository.getCampaignList(body: {"pageNumber": "$page", "CategoryTypeIds": catId}).then(
          (value) => value.fold((failure) {
        SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
      }, (campList) {
        appLog(campList, tag: "campList");
        List<CampaignDetails> campListForSize = campList.campaignList ?? [];
        campaignList = campListForSize;
        totalNumberOfResult = campList.totalNumberOfResult ?? 0;
        update();
      }),
    );
    return PaginationListModel(listOfObjects: campaignList, totalNumberOfResult: totalNumberOfResult);
  }

  Future<PaginationListModel> getUserRewardsApi({int page = 1}) async {
    userRewardsList = [];
    int totalNumberOfResult = 0;
    await getUserRewards.repository.getUserRewards(body: {"pageNumber": "$page"}).then(
          (value) => value.fold((failure) {
        SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
      }, (userRewardsListValue) {
        appLog(userRewardsListValue, tag: "userRewardsListValue");
        List<UserRewards> userRewardsForSize = userRewardsListValue.userRewardsList ?? [];
        userRewardsList = userRewardsForSize;
        totalNumberOfResult = userRewardsListValue.totalNumberOfResult ?? 0;
        update();
      }),
    );

    return PaginationListModel(listOfObjects: userRewardsList, totalNumberOfResult: totalNumberOfResult);
  }

  @override
  void onInit() {
    tabController = TabController(length: pageTabs.length, vsync: this);
    moreRewardsTabController = TabController(length: moreRewardsTabs.length, vsync: this);
    super.onInit();
  }
}
