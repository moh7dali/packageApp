import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/features/loyalty/presentation/pages/point_schema_page.dart';
import 'package:my_custom_widget/features/rewards_gallery/presentation/screens/rewards_gallery_page.dart';
import 'package:my_custom_widget/features/topup/presentation/pages/top_up_list_page.dart';
import 'package:my_custom_widget/features/topup/presentation/pages/top_up_page.dart';

import '../../features/auth/presentation/pages/complete_profile.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/referral_screen.dart';
import '../../features/auth/presentation/pages/verify_screen.dart';
import '../../features/loyalty/presentation/pages/points_tab.dart';
import '../../features/main/presentation/pages/main_screen.dart';
import '../../features/menu/presentation/pages/invite_page.dart';
import '../../features/menu/presentation/pages/profile_page.dart';
import '../../features/rewards/presentation/screens/rewards_tab.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../shared/screens/app_web_view_Screen.dart';
import '../constants/constants.dart';

class RouteGeneratorList {
  final List<GetPage> appRoutes = [
    GetPage(name: RouteConstant.splashPage, page: () => SplashScreen()),
    GetPage(name: RouteConstant.authPage, page: () => const LoginScreen()),
    GetPage(name: RouteConstant.verifyPage, page: () => const VerifyScreen()),
    GetPage(name: RouteConstant.completeProfile, page: () => const CompleteProfileScreen()),
    GetPage(name: RouteConstant.referralPage, page: () => const ReferralScreen()),
    GetPage(name: RouteConstant.profilePage, page: () => const ProfilePage()),
    GetPage(name: RouteConstant.invitePage, page: () => const InvitePage()),
    GetPage(
      name: RouteConstant.mainPage,
      page: () => MainScreen(pageIndex: Get.arguments as Map<String, int>?),
    ),
    GetPage(name: RouteConstant.rewardsScreen, page: () => const RewardsTabScreen()),
    GetPage(name: RouteConstant.pointSchemaPage, page: () => const PointSchemaPage()),
    GetPage(name: RouteConstant.pointsScreen, page: () => const PointsScreen()),
    GetPage(name: RouteConstant.rewardsGalleryPage, page: () => RewardsGalleryPage()),
    GetPage(name: RouteConstant.topUpListScreen, page: () => TopUpListPage()),
    GetPage(
      name: RouteConstant.topUpPage,
      page: () => TopUpPage(walletBalance: Get.arguments as double?),
    ),
    GetPage(
      name: RouteConstant.appWebViewPage,
      page: () => AppWebViewScreen(title: (Get.arguments as Map)["title"], url: (Get.arguments as Map)["url"]),
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
