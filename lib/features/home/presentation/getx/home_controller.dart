import "package:flutter/material.dart";
import "package:get/get.dart";

import "../../../../core/constants/constants.dart";
import "../../../../core/sdk/sdk_routes.dart";
import "../../../../core/utils/theme.dart";
import "../../../../injection_container.dart";
import "../../../../mozaic_loyalty_sdk.dart";
import "../../../../shared/helper/device_info.dart";
import "../../../../shared/helper/location_helper.dart";
import "../../../../shared/helper/shared_helper.dart";
import "../../../../shared/widgets/loading_widget.dart";
import "../../../barcode/presentation/getx/user_barcode_controller.dart";
import "../../../barcode/presentation/pages/barcode_screen.dart";
import "../../../branch/domain/entities/branch_details.dart";
import "../../../branch/domain/usecases/check_in_customer.dart";
import "../../../branch/domain/usecases/get_closest_branches.dart";
import "../../../rewards/domain/entity/campaign_details.dart";
import "../../../rewards/domain/entity/user_rewards.dart";
import "../../../rewards/domain/usecase/get_campaign_list.dart";
import "../../../rewards/domain/usecase/get_user_rewards.dart";
import "../../../rewards/presentation/getx/rewards_controller.dart";
import "../../domain/entities/customer_data.dart";
import "../../domain/entities/home_details.dart";
import "../../domain/entities/tier.dart";
import "../../domain/usecases/get_customer_home_contents.dart";
import "../widget/check_in_branch.dart";
import "../widget/select_with_in_the_range_branches.dart";

class HomeController extends GetxController {
  final GetCustomerHomeContents getCustomerHomeContents;
  final GetCampaignList getCampaignList;
  final GetClosestBranches getClosestBranches;
  final CheckInCustomer checkInCustomer;

  HomeDetails? homeDetails;
  bool isHomeLoading = true;
  BranchDetails? selectedBranch;
  CustomerData? customerData;
  String? currentTier;
  int? currentTierId;
  String? currentImageTier;
  String? customerNumber;
  double currentValue = 0.0;
  String? nextTier;
  String? nextImageTier;
  List<Map<String, dynamic>> tiersBoundaries = [];
  ScrollController scrollController = ScrollController();

  HomeController() : getCustomerHomeContents = sl(), getCampaignList = sl(), getUserRewards = sl(), getClosestBranches = sl(), checkInCustomer = sl();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    getHomeForAuthUser();
  }

  Future<void> getHomeForAuthUser() async {
    isHomeLoading = true;
    update();
    await getCustomerHomeContents.repository
        .getCustomerHomeContents(
          body: {
            "HomeFeatures": [
              {"HomeFeatures": 5, "MaximumParentResult": 10, "MaximumChildResult": 0},
              {"HomeFeatures": 9, "MaximumParentResult": 0, "MaximumChildResult": 0},
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
    if (isPoints) {
      SDKNav.toNamed(RouteConstant.pointsScreen);
    } else {
      SDKNav.toNamed(RouteConstant.rewardsScreen);
      if (isDeals) {
        RewardsController rewardsController = Get.put(RewardsController());
        rewardsController.tabController!.animateTo(1);
      } else {
        RewardsController rewardsController = Get.put(RewardsController());
        rewardsController.tabController!.animateTo(0);
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

  Future getUserLocation() async {
    SharedHelper().bottomSheet(BottomLoadingWidget());
    DeviceInfo.getDeviceData();
    await LocationHelper.requestLocationPermission((pos) async {
      await getClosestBranchesApi(pos.latitude, pos.longitude);
    });
  }

  Future getClosestBranchesApi(double latitude, double longitude) async {
    await getClosestBranches.repository
        .getClosestBranches(body: {"CustomerLatitude": latitude, "CustomerLongitude": longitude})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().closeAllDialogs();
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (closestBranches) async {
              if (closestBranches != null) {
                SharedHelper().closeAllDialogs();
                if ((closestBranches.withinTheRangeBranches ?? []).isNotEmpty) {
                  selectedBranch = closestBranches.withinTheRangeBranches?.firstOrNull;
                  if ((closestBranches.totalNumberOfResult ?? 0) > 1) {
                    SharedHelper().bottomSheet(
                      SelectWithInTheRangeBranches(withinTheRangeBranches: closestBranches.withinTheRangeBranches!, mainController: this),
                      isScrollControlled: true,
                    );
                  } else {
                    if ((closestBranches.totalNumberOfResult ?? 0) == 1) {
                      await checkInUser(selectedBranch!);
                    }
                  }
                } else if (closestBranches.outSideTheRangeBranch != null) {
                  SharedHelper().bottomSheet(
                    CheckInBranches(selectedBranch: closestBranches.outSideTheRangeBranch!, isOutBranch: true),
                    isScrollControlled: true,
                  );
                }
              }
            },
          ),
        );
  }

  Future checkInUser(BranchDetails selectedBranch) async {
    await checkInCustomer.repository
        .checkInCustomer(queryParameters: {"branchId": "${selectedBranch.id}"})
        .then(
          (value) => value.fold(
            (failure) {
              SharedHelper().closeAllDialogs();
              SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
            },
            (r) {
              SharedHelper().closeAllDialogs();
              SharedHelper().bottomSheet(CheckInBranches(selectedBranch: selectedBranch, isOutBranch: false), isScrollControlled: true);
            },
          ),
        );
  }

  void redeemPoints() {
    if (MozaicLoyaltySDK.settings.redeemPointsQRCode == true) {
      Get.delete<UserBarcodeController>();
      SharedHelper().scaleDialog(BarcodeScreen());
    } else {
      getUserLocation();
    }
  }
}
