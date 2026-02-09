import 'package:mozaic_loyalty_sdk/core/sdk/sdk_settings.dart';

import '../../mozaic_loyalty_sdk.dart';

class AppConstants {
  static final Currency currencyCode = MozaicLoyaltySDK.settings.currencyCode;
  static const bool isProxyEnable = true;
}

class HttpMethodRequest {
  static const String postMethode = 'POST';
  static const String getMethode = 'GET';
  static const String deleteMethode = 'DELETE';
  static const String putMethode = 'PUT';
}

class RouteConstant {
  static const String splashPage = '/mozaic_loyalty_sdk/SDKSplash';
  static const String homeScreen = '/SDKHomeScreen';
  static const String pointsScreen = '/SDKPointsScreen';
  static const String rewardsScreen = '/SDKRewardsTabScreen';
  static const String campaignRewards = '/SDKCampaignRewards';
  static const String branchDetailsPage = '/SDKBranchDetailsScreen';
}

class SharedPreferencesKeyConstants {
  static const String appLang = 'SDKLang';

  static const String appTheme = "SDKTheme";

  static const String accessToken = "SDKAccessToken";

  static const String sessionToken = "SDKSessionToken";

  static const String isLogin = "SDKIsLogin";
}
