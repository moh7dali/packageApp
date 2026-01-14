import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/loyalty/domain/entity/user_loyalty_data.dart';
import 'package:my_custom_widget/features/loyalty/domain/usecase/get_user_balance_history.dart';
import 'package:my_custom_widget/features/loyalty/domain/usecase/get_user_loyalty_data.dart';
import 'package:my_custom_widget/injection_container.dart';

import '../../../../core/utils/theme.dart';
import '../../../../shared/helper/shared_helper.dart';
import '../../../../shared/model/pagination_list_model.dart';
import '../../../home/domain/entities/tier.dart';
import '../../domain/entity/user_balance_history.dart';

class UserBalanceHistoryController extends GetxController with GetTickerProviderStateMixin {
  final GetUserBalanceHistory getUserBalanceHistory;
  final GetUserLoyaltyData getUserLoyaltyData;

  UserBalanceHistoryController({this.context}) : getUserBalanceHistory = sl(), getUserLoyaltyData = sl();

  List<UserBalanceHistory> userBalanceHistoryList = [];
  UserLoyaltyData? userLoyaltyData;
  bool isLoadingLoyalty = true;
  TiersData? userTierData;
  ScrollController scrollController = ScrollController();
  BuildContext? context;
  String? nextTier;
  bool isTutorialOpen = false;
  GlobalKey tierIcon = GlobalKey();
  List<Map<String, dynamic>> tiersBoundaries = [];

  @override
  onInit() {
    getUserLoyaltyDataApi();
    super.onInit();
  }

  getUserLoyaltyDataApi({bool isRefresh = false}) async {
    isLoadingLoyalty = true;
    update();
    await getUserLoyaltyData.repository.getUserLoyaltyData().then(
      (value) => value.fold(
        (failure) {
          SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
          isLoadingLoyalty = false;
          update();
        },
        (userData) {
          userLoyaltyData = userData;
          getUserTierInfo(userLoyaltyData?.loyaltyData?.currentTier ?? 1);
          isLoadingLoyalty = false;
          update();
          if (!isRefresh) {
            // createTutorial();
          }
        },
      ),
    );
  }

  Future getUserTierInfo(int currentTier) async {
    userTierData = userLoyaltyData?.tiers?.firstWhereOrNull((element) => element.id == currentTier);
    if ((userLoyaltyData?.loyaltyData?.currentTier ?? 0) < (userLoyaltyData?.tiers?.length ?? 0)) {
      nextTier =
          userLoyaltyData?.tiers?.firstWhereOrNull((element) => element.id == ((userLoyaltyData?.loyaltyData?.currentTier ?? 0) + 1))?.name ?? "";
    }
    for (int i = 0; i < userLoyaltyData!.tiers!.length; i++) {
      TiersData tier = userLoyaltyData!.tiers![i];
      double max = 0;
      if (i < userLoyaltyData!.tiers!.length - 1) {
        max = userLoyaltyData!.tiers![i + 1].lowerLimit!.toDouble();
      } else {
        max = tier.lowerLimit!.toDouble() + tiersBoundaries.last["max"] - tiersBoundaries.last["lower"];
      }
      var gradient =
          userLoyaltyData?.tiers?.firstWhereOrNull((element) => element.id == userLoyaltyData?.loyaltyData?.currentTier)?.tierColor ??
          AppTheme.primaryColorString;
      ;
      tiersBoundaries.add({
        "id": tier.id!.toInt(),
        "lower": tier.lowerLimit!.toDouble(),
        "max": max,
        "gradient": gradient,
        "maintainingAmount": tier.maintainingAmount,
      });
    }
  }

  Future<PaginationListModel> getUserBalanceHistoryApi({int page = 1}) async {
    bool isLogin = await SharedHelper().isUserLoggedIn();
    if (isLogin) {
      userBalanceHistoryList = [];
      int totalNumberOfResult = 0;
      await getUserBalanceHistory.repository
          .getUserBalanceHistory(body: {"pageNumber": "$page"})
          .then(
            (value) => value.fold(
              (failure) {
                SharedHelper().errorSnackBar(failure.errorsModel.errorMessage ?? "");
              },
              (userBalanceList) async {
                List<UserBalanceHistory> userBalanceHistoryListForSize = userBalanceList.userBalanceHistoryList ?? [];
                userBalanceHistoryList = userBalanceHistoryListForSize;
                totalNumberOfResult = userBalanceList.totalNumberOfResult ?? 0;
                update();
              },
            ),
          );
      return PaginationListModel(totalNumberOfResult: totalNumberOfResult, listOfObjects: userBalanceHistoryList);
    } else {
      return PaginationListModel(totalNumberOfResult: 0, listOfObjects: []);
    }
  }

  Color getTierColor() {
    String color = userTierData?.tierColor ?? AppTheme.primaryColorString;
    return AppTheme.fromHex(color);
  }
}
