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
  static const String splashPage = '/mozaic_loyalty_sdk/splash';
  static const String homeScreen = '/HomeScreen';
  static const String pointsScreen = '/PointsScreen';
  static const String rewardsScreen = '/RewardsTabScreen';
  static const String campaignRewards = '/CampaignRewards';
  static const String branchDetailsPage = '/BranchDetailsScreen';
}

class SharedPreferencesKeyConstants {
  static const String appLang = 'appLang';

  static const String appTheme = "appTheme";

  static const String accessToken = "accessToken";

  static const String sessionToken = "sessionToken";

  static const String isLogin = "isLogin";
}
