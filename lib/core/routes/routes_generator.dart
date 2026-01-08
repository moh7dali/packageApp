import 'package:my_custom_widget/features/address/presentation/pages/address_details_page.dart';
import 'package:my_custom_widget/features/address/presentation/pages/map_page.dart';
import 'package:my_custom_widget/features/address/presentation/pages/my_address_page.dart';
import 'package:my_custom_widget/features/auth/presentation/pages/on_boarding_page.dart';
import 'package:my_custom_widget/features/brand/presentaion/pages/brand_details_screen.dart';
import 'package:my_custom_widget/features/category/presentaion/pages/filters_page.dart';
import 'package:my_custom_widget/features/category/presentaion/pages/product_details_page.dart';
import 'package:my_custom_widget/features/category/presentaion/pages/sub_or_product_page.dart';
import 'package:my_custom_widget/features/loyalty/presentation/pages/point_schema_page.dart';
import 'package:my_custom_widget/features/menu/presentation/pages/contact_us_page.dart';
import 'package:my_custom_widget/features/ordering/domain/entity/order_history.dart';
import 'package:my_custom_widget/features/ordering/presentation/pages/cart_page.dart';
import 'package:my_custom_widget/features/ordering/presentation/pages/order_details_page.dart';
import 'package:my_custom_widget/features/rewards_gallery/presentation/screens/rewards_gallery_page.dart';
import 'package:my_custom_widget/features/topup/presentation/pages/top_up_list_page.dart';
import 'package:my_custom_widget/features/topup/presentation/pages/top_up_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/auth/presentation/pages/complete_profile.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/referral_screen.dart';
import '../../features/auth/presentation/pages/verify_screen.dart';
import '../../features/branch/presentaion/pages/branch_details_screen.dart';
import '../../features/category/domain/entities/category.dart';
import '../../features/category/presentaion/pages/brand_category_page.dart';
import '../../features/loyalty/presentation/pages/points_tab.dart';
import '../../features/main/presentation/pages/main_screen.dart';
import '../../features/menu/presentation/pages/invite_page.dart';
import '../../features/menu/presentation/pages/language_page.dart';
import '../../features/menu/presentation/pages/merchant_info_page.dart';
import '../../features/menu/presentation/pages/profile_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/offers/presentation/pages/offers_page.dart';
import '../../features/ordering/presentation/pages/order_history_page.dart';
import '../../features/rewards/presentation/screens/rewards_tab.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../shared/screens/app_web_view_Screen.dart';
import '../constants/constants.dart';

class RouteGeneratorList {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // We extract arguments from settings, NOT from Get.arguments
    final args = settings.arguments;

    switch (settings.name) {
      case RouteConstant.splashPage:
        return GetPageRoute(page: () => SplashScreen(), settings: settings);

      case RouteConstant.onBoarding:
        return GetPageRoute(page: () => OnboardingPage(), settings: settings);

      // case RouteConstant.filtersPage:
      //   return GetPageRoute(
      //     settings: settings,
      //     page: () => FiltersPage(
      //       selectedCategory: args is Category  args : Category,
      //     ),
      //   );

      case RouteConstant.mainPage:
        return GetPageRoute(
          settings: settings,
          page: () => MainScreen(
            pageIndex: args is Map<String, int>? ? args : null,
          ),
        );

      case RouteConstant.branchDetailsPage:
        return GetPageRoute(
          settings: settings,
          page: () => BranchDetailsScreen(
            branchID: args is int ? args : 0,
          ),
        );

      case RouteConstant.brandScreen:
        return GetPageRoute(
          settings: settings,
          page: () => BrandDetailsScreen(
            brandID: args is int ? args : 0,
          ),
        );

      case RouteConstant.productDetailsPage:
        return GetPageRoute(
          settings: settings,
          page: () {
            final data = args is Map<String, dynamic> ? args : {};
            return ProductDetailsPage(
              product: data['product'],
              selectedCategory: data['selectedCategory'],
            );
          },
        );

      case RouteConstant.mapPage:
        return GetPageRoute(
          settings: settings,
          page: () {
            final data = args is Map<String, dynamic> ? args : {};
            return MapPage(initialCamera: data['initialCamera']);
          },
        );

      case RouteConstant.orderDetailsPage:
        return GetPageRoute(
          settings: settings,
          page: () => OrderDetailsPage(
            orderHistory: args is OrderHistory ? args : null,
          ),
        );

      case RouteConstant.addressDetailsPage:
        return GetPageRoute(
          settings: settings,
          page: () => AddressDetailsPage(
            isEdit: args is bool ? args : false,
          ),
        );

      case RouteConstant.subOrProductPage:
        return GetPageRoute(
          settings: settings,
          page: () {
            final data = args is Map<String, dynamic> ? args : {};
            return SubOrProductPage(
              selectedCategory: data['selectedCategory'],
              sliderCategoryId: data['sliderCategoryId'],
              parentCategoryList: data['parentCategoryList'],
            );
          },
        );

      case RouteConstant.topUpPage:
        return GetPageRoute(
          settings: settings,
          page: () => TopUpPage(
            walletBalance: args is double ? args : 0.0,
          ),
        );

      case RouteConstant.appWebViewPage:
        return GetPageRoute(
          settings: settings,
          page: () {
            final data = args is Map ? args : {};
            return AppWebViewScreen(
              title: data["title"] ?? "",
              url: data["url"] ?? "",
            );
          },
        );

    // Default for pages with no arguments
      default:
        final pageBuilder = appRoutes.firstWhere(
              (e) => e.name == settings.name,
          orElse: () => GetPage(name: '/404', page: () => const SizedBox()),
        ).page;
        return GetPageRoute(settings: settings, page: pageBuilder);
    }
  }

  // Keep your list for the default pages without arguments
  static final List<GetPage> appRoutes = [
    GetPage(name: RouteConstant.splashPage, page: () => SplashScreen()),
    GetPage(name: RouteConstant.onBoarding, page: () => OnboardingPage()),
    GetPage(name: RouteConstant.authPage, page: () => const LoginScreen()),
    GetPage(name: RouteConstant.verifyPage, page: () => const VerifyScreen()),
    GetPage(name: RouteConstant.completeProfile, page: () => const CompleteProfileScreen()),
    GetPage(name: RouteConstant.referralPage, page: () => const ReferralScreen()),
    GetPage(name: RouteConstant.profilePage, page: () => const ProfilePage()),
    GetPage(name: RouteConstant.invitePage, page: () => const InvitePage()),
    GetPage(name: RouteConstant.contactUsPage, page: () => const ContactUsPage()),
    GetPage(name: RouteConstant.merchantInfoPage, page: () => const MerchantInfoPage()),
    GetPage(name: RouteConstant.languagePage, page: () => const LanguagePage()),
    GetPage(name: RouteConstant.notificationsPage, page: () => const NotificationsPage()),
    GetPage(name: RouteConstant.rewardsScreen, page: () => const RewardsTabScreen()),
    GetPage(name: RouteConstant.pointSchemaPage, page: () => const PointSchemaPage()),
    GetPage(name: RouteConstant.pointsScreen, page: () => const PointsScreen()),
    GetPage(name: RouteConstant.brandCategoryPage, page: () => const BrandCategoryPage()),
    GetPage(name: RouteConstant.rewardsGalleryPage, page: () => RewardsGalleryPage()),
    GetPage(name: RouteConstant.myAddressPage, page: () => MyAddressPage()),
    GetPage(name: RouteConstant.cartPage, page: () => CartPage()),
    GetPage(name: RouteConstant.orderHistoryPage, page: () => OrderHistoryPage()),
    GetPage(name: RouteConstant.offersScreen, page: () => OffersScreen()),
    GetPage(name: RouteConstant.topUpListScreen, page: () => TopUpListPage()),
  ];
}