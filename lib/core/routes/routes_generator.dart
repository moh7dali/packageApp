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
  final List<GetPage> appRoutes = [
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
    GetPage(
      name: RouteConstant.filtersPage,
      page: () => FiltersPage(selectedCategory: Get.arguments as Category),
    ),
    GetPage(
      name: RouteConstant.mainPage,
      page: () => MainScreen(pageIndex: Get.arguments as Map<String, int>?),
    ),
    GetPage(
      name: RouteConstant.branchDetailsPage,
      page: () => BranchDetailsScreen(branchID: Get.arguments as int),
    ),
    GetPage(name: RouteConstant.notificationsPage, page: () => const NotificationsPage()),
    GetPage(name: RouteConstant.rewardsScreen, page: () => const RewardsTabScreen()),
    GetPage(name: RouteConstant.pointSchemaPage, page: () => const PointSchemaPage()),
    GetPage(
      name: RouteConstant.brandScreen,
      page: () => BrandDetailsScreen(brandID: Get.arguments as int),
    ),
    // GetPage(
    //   name: RouteConstant.branchesPage,
    //   page: () => BranchListScreen(brandId: Get.arguments as int),
    // ),
    GetPage(name: RouteConstant.pointsScreen, page: () => const PointsScreen()),
    GetPage(name: RouteConstant.brandCategoryPage, page: () => const BrandCategoryPage()),
    GetPage(
      name: RouteConstant.productDetailsPage,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return ProductDetailsPage(product: args['product'], selectedCategory: args['selectedCategory']);
      },
    ),
    GetPage(name: RouteConstant.rewardsGalleryPage, page: () => RewardsGalleryPage()),
    GetPage(name: RouteConstant.myAddressPage, page: () => MyAddressPage()),
    GetPage(
      name: RouteConstant.mapPage,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return MapPage(initialCamera: args['initialCamera']);
      },
    ),
    GetPage(
      name: RouteConstant.orderDetailsPage,
      page: () {
        return OrderDetailsPage(orderHistory: Get.arguments as OrderHistory);
      },
    ),
    GetPage(
      name: RouteConstant.addressDetailsPage,
      page: () => AddressDetailsPage(isEdit: Get.arguments as bool? ?? false),
    ),
    GetPage(
      name: RouteConstant.subOrProductPage,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        return SubOrProductPage(
          selectedCategory: args['selectedCategory'],
          sliderCategoryId: args['sliderCategoryId'],
          parentCategoryList: args['parentCategoryList'],
        );
      },
    ),
    GetPage(name: RouteConstant.cartPage, page: () => CartPage()),
    GetPage(name: RouteConstant.orderHistoryPage, page: () => OrderHistoryPage()),
    GetPage(name: RouteConstant.offersScreen, page: () => OffersScreen()),
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

  static GetPage appPage({required String name, required Widget Function() page}) {
    // final ConnectivityService connectivityService = Get.put(ConnectivityService());
    return GetPage(
      name: name,
      page: () => Obx(() {
        // appLog("ConnectivityService.connectionStatus.value =${connectivityService.connectionStatus.value}");
        // if (connectivityService.connectionStatus.value.first == ConnectivityResult.mobile ||
        //     connectivityService.connectionStatus.value.first == ConnectivityResult.wifi) {
        return page();
        // } else {
        //   return FutureBuilder<bool>(
        //       future: InternetConnectionChecker.instance.hasConnection,
        //       builder: (context, snapshot) {
        //         if (snapshot.data ?? true) return page();
        //         return const NoInternetPage();
        //       });
        // }
      }),
      transition: Transition.fadeIn,
    );
  }
}
