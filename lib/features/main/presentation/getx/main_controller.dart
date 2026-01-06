import "package:my_custom_widget/core/constants/constants.dart";
import "package:my_custom_widget/features/branch/domain/usecases/get_closest_branches.dart";
import "package:my_custom_widget/features/branch/presentaion/pages/branch_list_screen.dart";
import "package:my_custom_widget/features/home/presentation/pages/home_tab.dart";
import "package:my_custom_widget/features/menu/presentation/pages/menu_tab.dart";
import "package:my_custom_widget/injection_container.dart";
import "package:my_custom_widget/shared/helper/shared_helper.dart";
import "package:curved_navigation_bar/curved_navigation_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_advanced_drawer/flutter_advanced_drawer.dart";
import "package:get/get.dart";

import "../../../../core/utils/app_log.dart";
import "../../../../shared/helper/device_info.dart";
import "../../../../shared/helper/location_helper.dart";
import "../../../../shared/widgets/loading_widget.dart";
import "../../../branch/domain/entities/branch_details.dart";
import "../../../branch/domain/usecases/check_in_customer.dart";
import "../../../loyalty/presentation/pages/points_tab.dart";
import "../../../rewards/presentation/screens/rewards_tab.dart";
import "../widgets/check_in_branch.dart";
import "../widgets/select_with_in_the_range_branches.dart";

class MainController extends GetxController with GetSingleTickerProviderStateMixin {
  final GetClosestBranches getClosestBranches;
  final CheckInCustomer checkInCustomer;
  final Map<String, int>? pageIndex;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final navBarKey = GlobalKey<CurvedNavigationBarState>();

  MainController(this.pageIndex) : getClosestBranches = sl(), checkInCustomer = sl();
  BranchDetails? selectedBranch;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 300), () {
      appLog(pageIndex, tag: "pageIndex");
      if (pageIndex != null) {
        onTapChanged(pageIndex!['index']!);
      }
    });
  }

  final AdvancedDrawerController advancedDrawerController = AdvancedDrawerController();

  void toggleDrawer() {
    advancedDrawerController.showDrawer();
  }

  Widget currentWidget = const HomeScreen();
  int currentIndex = 0;

  void onTapChanged(int index) {
    switch (index) {
      case 0:
        currentWidget = const HomeScreen();
        currentIndex = 0;
        update();
        break;
      case 1:
        currentWidget = const BranchListScreen(brandId: AppConstants.brandId);
        currentIndex = 1;
        update();
        break;
      case 2:
        SharedHelper().needLogin(() {
          currentWidget = const PointsScreen();
          currentIndex = 2;
          update();
        });
        break;
      case 3:
        SharedHelper().needLogin(() {
          currentWidget = const RewardsTabScreen();
          currentIndex = 3;
          update();
        });
        break;
      case 4:
        currentWidget = const MenuTab();
        currentIndex = 4;
        update();
        break;
      default:
        break;
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
}
