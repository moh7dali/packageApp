import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:my_custom_widget/features/home/domain/usecases/get_home_details.dart";

import "../../../../core/constants/constants.dart";
import "../../../../core/sdk/sdk_rouutes.dart";
import "../../../../core/utils/theme.dart";
import "../../../../injection_container.dart";
import "../../../../my_custom_widget.dart";
import "../../../../shared/helper/shared_helper.dart";
import "../../../main/presentation/getx/main_controller.dart";
import "../../../rewards/domain/entity/campaign_details.dart";
import "../../../rewards/domain/entity/user_rewards.dart";
import "../../../rewards/domain/usecase/get_campaign_list.dart";
import "../../../rewards/domain/usecase/get_user_rewards.dart";
import "../../../rewards/presentation/getx/rewards_controller.dart";
import "../../domain/entities/customer_data.dart";
import "../../domain/entities/home_details.dart";
import "../../domain/entities/tier.dart";
import "../../domain/usecases/get_customer_home_contents.dart";

class HomeController extends GetxController {
  final GetHomeDetails getHomeDetails;
  final GetCustomerHomeContents getCustomerHomeContents;
  final GetCampaignList getCampaignList;
  HomeDetails? homeDetails;
  String homeWelcomeTitle = "";
  bool isHomeLoading = true;
  bool isLogin = false;

  ScrollController scrollController = ScrollController();

  HomeController() : getHomeDetails = sl(), getCustomerHomeContents = sl(), getCampaignList = sl(), getUserRewards = sl();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    homeWelcomeTitle = await getHeaderTitle();
    isLogin = await SharedHelper().isUserLoggedIn();
    if (isLogin) {
      getHomeForAuthUser();
    } else {
      getHomeDetailsData();
    }
  }

  Future<void> getHomeDetailsData() async {
    isHomeLoading = true;
    update();
    await getHomeDetails.repository
        .getHomeDetails(
          body: {
            "HomeFeatures": [
              {"HomeFeatures": 1, "MaximumParentResult": 0, "MaximumChildResult": 0},
              {"HomeFeatures": 5, "MaximumParentResult": 10, "MaximumChildResult": 0},
              {"HomeFeatures": 11, "MaximumParentResult": 100, "MaximumChildResult": 100},
              {"HomeFeatures": 12, "MaximumParentResult": 100, "MaximumChildResult": 100},
            ],
          },
        )
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
              isHomeLoading = false;
              update();
            },
            (details) async {
              homeDetails = details;
              isHomeLoading = false;
              update();
            },
          ),
        );
  }

  Future<void> getHomeForAuthUser() async {
    isHomeLoading = true;
    update();
    await getCustomerHomeContents.repository
        .getCustomerHomeContents(
          body: {
            "HomeFeatures": [
              {"HomeFeatures": 1, "MaximumParentResult": 0, "MaximumChildResult": 0},
              {"HomeFeatures": 5, "MaximumParentResult": 10, "MaximumChildResult": 0},
              {"HomeFeatures": 9, "MaximumParentResult": 0, "MaximumChildResult": 0},
              {"HomeFeatures": 11, "MaximumParentResult": 100, "MaximumChildResult": 100},
              {"HomeFeatures": 12, "MaximumParentResult": 100, "MaximumChildResult": 100},
            ],
          },
        )
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
              isHomeLoading = false;
              update();
            },
            (details) async {
              homeDetails = details;
              await getUserData();
              await getMissionsApi(catId: "1,3,4");
              await checkIfShowReferral();
              await getUserRewardsApi();
              isHomeLoading = false;
              update();
            },
          ),
        );
  }

  CustomerData? customerData;
  String? currentTier;
  int? currentTierId;
  String? currentImageTier;
  String? customerNumber;
  double currentValue = 0.0;
  String? nextTier;
  String? nextImageTier;

  List<Map<String, dynamic>> tiersBoundaries = [];

  bool isProdLoading = true;

  Future getUserData() async {
    customerData = homeDetails?.customerData;
    currentTier =
        homeDetails?.tiers?.tiers
            ?.firstWhereOrNull((element) => element.id == customerData?.customerLoyaltyData?.customerTierData?.currentTier)
            ?.name ??
        "silver".tr;
    if ((customerData?.customerLoyaltyData?.customerTierData?.currentTier ?? 0) < (homeDetails?.tiers?.tiers?.length ?? 0)) {
      nextTier =
          homeDetails?.tiers?.tiers
              ?.firstWhereOrNull((element) => element.id == ((customerData?.customerLoyaltyData?.customerTierData?.currentTier ?? 0) + 1))
              ?.name ??
          "";

      nextImageTier =
          homeDetails?.tiers?.tiers
              ?.firstWhereOrNull((element) => element.id == ((customerData?.customerLoyaltyData?.customerTierData?.currentTier ?? 0) + 1))
              ?.imageUrl ??
          "";
    }
    currentTierId = customerData?.customerLoyaltyData?.customerTierData?.currentTier ?? 1;
    currentImageTier =
        homeDetails?.tiers?.tiers
            ?.firstWhereOrNull((element) => element.id == customerData?.customerLoyaltyData?.customerTierData?.currentTier)
            ?.imageUrl ??
        "";
    customerNumber = customerData?.customerInfo?.mobileNumber?.replaceFirst("+", "");
    for (int i = 0; i < (homeDetails?.tiers?.tiers?.length ?? 0); i++) {
      TiersData tier = homeDetails!.tiers!.tiers![i];
      double max = 1;
      if (i < (homeDetails?.tiers?.tiers?.length ?? 0) - 1) {
        max = (homeDetails?.tiers?.tiers?[i + 1].lowerLimit ?? 1).toDouble();
      }
      tiersBoundaries.add({
        "id": tier.id!.toInt(),
        "lower": tier.lowerLimit!.toDouble(),
        "max": max,
        "gradient": tier.tierColor,
        "maintainingAmount": tier.maintainingAmount,
      });
    }
    currentValue =
        (customerData?.customerLoyaltyData?.customerTierData?.tierAmount ?? 0).toDouble() +
        (tiersBoundaries.firstWhereOrNull((element) => element["id"] == customerData?.customerLoyaltyData?.customerTierData?.currentTier)?["lower"] ??
            0);
  }

  double? valueOfTheLine(int currentTier) {
    double minValue = tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["lower"] ?? 0;

    double maxValue = tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["max"] ?? 1;
    double maintainingAmount = tiersBoundaries.firstWhereOrNull((element) => element["id"] == currentTier)?["maintainingAmount"] ?? 1;
    if (maxValue == 1) {
      maxValue = minValue + (maintainingAmount * 2);
    }
    double normalizedValue = (currentValue - minValue) / (maxValue - minValue);

    print("normalizedValue $normalizedValue");
    print("minValue $minValue, maxValue $maxValue, currentValue $currentValue,currentTier $currentTier");

    normalizedValue = normalizedValue.clamp(0.0, 1.0);
    if (normalizedValue == 0.0) {
      normalizedValue = 0.02;
    }
    return normalizedValue;
  }

  Color getTierColor(int currentTier, {double withOpacity = 1}) {
    String color = homeDetails?.tiers?.tiers?.firstWhereOrNull((element) => element.id == currentTier)?.tierColor ?? AppTheme.primaryColorString;
    return AppTheme.fromHex(color, withOpacity: withOpacity);
  }

  List<CampaignDetails> missions = [];

  Future<void> getMissionsApi({required String catId}) async {
    await getCampaignList.repository
        .getCampaignList(body: {"pageNumber": "1", "CategoryTypeIds": catId})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (campList) {
              missions = campList.campaignList ?? [];
              update();
            },
          ),
        );
  }

  Future<String> getHeaderTitle() async {
    String timeTitle;
    final currentHour = DateTime.now().hour;
    if (currentHour >= 6 && currentHour < 12) {
      timeTitle = 'GoodMorning'.tr;
    } else if (currentHour >= 12 && currentHour < 18) {
      timeTitle = 'GoodAfternoon'.tr;
    } else if (currentHour >= 18 && currentHour < 24) {
      timeTitle = 'GoodEvening'.tr;
    } else {
      timeTitle = 'welcome'.tr;
    }
    return '$timeTitle,';
  }

  final GetUserRewards getUserRewards;

  List<UserRewards> userRewardsList = [];

  Future<void> getUserRewardsApi({int page = 1}) async {
    userRewardsList = [];
    await getUserRewards.repository
        .getUserRewards(body: {"pageNumber": "$page"})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (userRewardsListValue) {
              userRewardsList = userRewardsListValue.userRewardsList ?? [];
              update();
            },
          ),
        );
  }

  void gotoRewards({bool isDeals = false, bool isPoints = false}) {
    MainController mainController;
    if (Get.isRegistered<MainController>()) {
      mainController = Get.find<MainController>();
      if (isPoints) {
        mainController.onTapChanged(1);
      } else {
        mainController.onTapChanged(2);
        if (isDeals) {
          RewardsController rewardsController = Get.put(RewardsController());
          rewardsController.tabController!.animateTo(1);
        } else {
          RewardsController rewardsController = Get.put(RewardsController());
          rewardsController.tabController!.animateTo(0);
        }
      }
    } else {
      SDKNav.offAllNamed(RouteConstant.mainPage);
      if (isPoints) {
        Get.put(MainController({"index": 2}));
      } else {
        Get.put(MainController({"index": 3}));
        if (isDeals) {
          RewardsController rewardsController = Get.put(RewardsController());
          rewardsController.tabController!.animateTo(1);
        } else {
          RewardsController rewardsController = Get.put(RewardsController());
          rewardsController.tabController!.animateTo(0);
        }
      }
    }
  }

  bool isShowReferral = false;
  CampaignDetails? referralCampaign;

  Future<void> checkIfShowReferral() async {
    if (appLanguage == "en") {
      referralCampaign = missions.firstWhereOrNull((element) => element.name == "Referral");
    } else {
      referralCampaign = missions.firstWhereOrNull((element) => element.name == "دعوة");
    }
    if (referralCampaign != null) {
      isShowReferral = true;
      update();
    } else {
      isShowReferral = false;
    }
    if (appLanguage == "en") {
      missions.removeWhere((element) => element.name == "Referral");
      missions.removeWhere((element) => element.name == "Registration");
    } else {
      missions.removeWhere((element) => element.name == "دعوة");
      missions.removeWhere((element) => element.name == "تسجيل");
    }
  }
}
