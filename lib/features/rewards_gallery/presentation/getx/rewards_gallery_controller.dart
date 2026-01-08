import 'package:my_custom_widget/core/constants/assets_constants.dart';
import 'package:my_custom_widget/features/loyalty/presentation/getx/points_controller.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/entity/reward_gallery.dart';
import 'package:my_custom_widget/features/rewards_gallery/domain/usecase/redeem_reward.dart';
import 'package:get/get.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/sdk/sdk_rouutes.dart';
import '../../../../injection_container.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/pagination_list_model.dart';
import '../../../loyalty/domain/entity/user_loyalty_data.dart';
import '../../domain/usecase/get_rewards_gallery.dart';

class RewardsGalleryController extends GetxController {
  final GetGalleryRewards getGalleryRewards;
  final RedeemReward redeemReward;

  RewardsGalleryController()
      : getGalleryRewards = sl(),
        redeemReward = sl();

  List<RewardsGallery> rewards = [];
  UserLoyaltyData? userLoyaltyData;

  @override
  void onInit() {
    getUserLoyaltyDataApi();
    super.onInit();
  }

  Future<PaginationListModel> getGalleryRewardsApi({int page = 1}) async {
    rewards = [];
    int totalNumberOfResult = 0;
    await getGalleryRewards.repository.getGalleryRewards(queryParameters: {
      "pageNumber": "$page",
    }).then((value) => value.fold((failure) {
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        }, (list) {
          List<RewardsGallery> catForSize = list.rewardsList ?? [];
          rewards = catForSize;
          totalNumberOfResult = list.totalNumberofResult ?? 0;
          update();
        }));
    return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: rewards);
  }

  getUserLoyaltyDataApi() async {
    final userBalanceHistoryController =
        Get.isRegistered<UserBalanceHistoryController>() ? Get.find<UserBalanceHistoryController>() : Get.put(UserBalanceHistoryController());
    await userBalanceHistoryController.getUserLoyaltyDataApi();
    userLoyaltyData = userBalanceHistoryController.userLoyaltyData;
    update();
  }

  Future<void> redeemRewardsApi({required rewardId}) async {
    await redeemReward.repository.redeemReward(body: {"RewardId": "$rewardId", "Quantity": "$quantity"}).then(
      (value) => value.fold(
        (failure) {
          SharedHelper().closeAllDialogs();
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
        },
        (done) {
          SharedHelper().closeAllDialogs();
          SharedHelper().actionDialog(
            "congratulations",
            "enjoyGifting",
            height: Get.height * .2,
            hasImage: true,
            image: AssetsConsts.done,
            isCenter: true,
            isRowStyle: false,
            isLocalImage: true,
            confirmText: "rewards",
            confirm: () {
              SharedHelper().closeAllDialogs();
              SDKNav.toNamed(RouteConstant.rewardsScreen);
            },
            cancel: () {
              SharedHelper().closeAllDialogs();
            },
          );
        },
      ),
    );
  }

  bool startPositionAdd = false;
  bool startPositionSub = false;
  int quantity = 1;

  quantityAdd() {
    startPositionAdd = true;
    update();
    Future.delayed(const Duration(milliseconds: 50), () {
      quantity++;
      startPositionAdd = false;
      update();
    });
  }

  quantitySub() {
    startPositionSub = true;
    update();
    Future.delayed(const Duration(milliseconds: 50), () {
      if (quantity > 1) {
        quantity--;
      }
      startPositionSub = false;
      update();
    });
  }
}
