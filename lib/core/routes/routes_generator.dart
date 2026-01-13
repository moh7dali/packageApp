import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/pages/complete_profile.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/referral_screen.dart';
import '../../features/auth/presentation/pages/verify_screen.dart';
import '../../features/branch/presentaion/pages/branch_details_screen.dart';
import '../../features/home/presentation/pages/home_tab.dart';
import '../../features/loyalty/presentation/pages/points_tab.dart';
import '../../features/menu/presentation/pages/invite_page.dart';
import '../../features/rewards/presentation/screens/campign_rewards_screen.dart';
import '../../features/rewards/presentation/screens/rewards_tab.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../constants/constants.dart';

class RouteGeneratorList {
  final List<GetPage> appRoutes = [
    GetPage(name: RouteConstant.splashPage, page: () => SplashScreen()),
    GetPage(name: RouteConstant.authPage, page: () => const LoginScreen()),
    GetPage(name: RouteConstant.verifyPage, page: () => const VerifyScreen()),
    GetPage(name: RouteConstant.completeProfile, page: () => const CompleteProfileScreen()),
    GetPage(name: RouteConstant.referralPage, page: () => const ReferralScreen()),
    GetPage(name: RouteConstant.homeScreen, page: () => const HomeScreen()),
    GetPage(name: RouteConstant.rewardsScreen, page: () => const RewardsTabScreen()),
    GetPage(name: RouteConstant.pointsScreen, page: () => const PointsScreen()),
    GetPage(name: RouteConstant.invitePage, page: () => const InvitePage()),
    GetPage(
      name: RouteConstant.branchDetailsPage,
      page: () {
        final int branchId = Get.arguments;
        return BranchDetailsScreen(branchID: branchId);
      },
    ),
    GetPage(
      name: RouteConstant.campaignRewards,
      page: () {
        final args = Get.arguments;
        return CampaignRewardsScreen(selectedCampaignDetails: args);
      },
    ),
  ];

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final GetPage? route = appRoutes.firstWhereOrNull((element) => element.name == settings.name);

    if (route != null) {
      return GetPageRoute(
        settings: settings,
        routeName: route.name,
        page: route.page,
        transition: route.transition ?? Transition.fadeIn,
        binding: route.binding,
        bindings: route.bindings,
        popGesture: route.popGesture,
      );
    }
    return null;
  }
}
