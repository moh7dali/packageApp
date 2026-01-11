import 'package:my_custom_widget/core/api/api_end_points.dart';

class AppConstants {
  static const String countryCode = "+966";
  static const String countryCodeStart = "5";
  static const String countryCodeStartWithZero = "05";
  static const String currencyCode = "sar";

  static const int merchantId = 79;
  static const int applicationId = 79;
  static const int brandId = 122;

  static const int visitorTypeLookupId = 60;
  static const int visitorTypeAttributeId = 2;

  static const int countryId = 1;
  static const int resourceGroup = 2;
  static const int pageSize = 1000;

  static const bool isSupportTier = true;

  static const String oneSignalID = "effc3b9e-73e9-467e-b8cb-369fe91a6288";
  static const String bundleIDAndroid = 'com.mozaicis.arabica';
  static const String bundleIDIOS = 'com.mozaicis.arabica';
  static const int iOSAppID = 6752688822;

  static const String payMobPrivateKey = "sau_pk_test_LMISy13b9sKmN13bCt4XzKN3wlX5XuPk";

  static const String termsAndCondition = '${ApiEndPoints.staging}TermsAndConditions/$merchantId';
  static const String privacyPolicy = '${ApiEndPoints.staging}Privacy/$merchantId';
  static const String websiteLink = 'https://alameedcoffee.com/';

  static final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static const bool isProxyEnable = true;
}

class HttpMethodRequest {
  static const String postMethode = 'POST';
  static const String getMethode = 'GET';
  static const String deleteMethode = 'DELETE';
  static const String putMethode = 'PUT';
}

class RouteConstant {
  static const String splashPage = '/my_custom_widget/splash';
  static const String appWebViewPage = '/AppWebViewScreen';
  static const String authPage = '/AuthPage';
  static const String mainPage = '/MainScreen';
  static const String verifyPage = '/VerifyScreen';
  static const String completeProfile = '/CompleteProfileScreen';
  static const String referralPage = '/ReferralScreen';
  static const String profilePage = '/ProfilePage';
  static const String invitePage = '/InvitePage';
  static const String branchDetailsPage = '/BranchDetailsScreen';
  static const String rewardsScreen = '/RewardsTabScreen';
  static const String pointsHistoryScreen = '/PointsHistoryScreen';
  static const String pointSchemaPage = '/PointSchemaPage';
  static const String barCodeScreen = '/BarcodeScreen';
  static const String pointsScreen = '/PointsScreen';
  static const String rewardsGalleryPage = '/RewardsGalleryPage';
  static const String topUpListScreen = '/TopUpListPage';
  static const String topUpPage = '/TopUpPage';
}

class SelectWidgetConstant {
  static const String gender = 'gender';
  static const String dateOfBirth = 'dateOfBirth';
  static const String city = 'city';
  static const String area = 'area';
  static const String maritalStatus = 'maritalStatus';
  static const String anniversaryDate = 'anniversaryDate';
  static const String lookup = 'lookUp';
}

class NotificationTriggerType {
  static const int addedPoints = 1; // Add Point
  static const int redeemedPoints = 2; // Redeem Point
  static const int reward = 3; // Reward
  static const int share = 4; // Share
  static const int invitation = 5; // Invitation
  static const int newRegistration = 6; // NewRegistration
  static const int addReferral = 7; // AddReferral
  static const int balanceTransferAddition = 8; // BalanceTransferAddition
  static const int balanceTransferSubtraction = 9; // BalanceTransferSubtraction
  static const int system = 10; // 	System
  static const int pointExpiry = 11; // 	Point Expiry
  static const int migration = 12; // 	Migration
  static const int transferTransaction = 13; // 	Transfer Transaction
  static const int redeemReward = 14; // 	Redeem Reward
  static const int orderRedeemPoint = 15; // 	OrderRedeemPoint
  static const int orderAddPoint = 16; // 	OrderAddPoint
  static const int returnCheckout = 17; // 	ReturnCheckout
  static const int updatePaymentStatus = 18; // 	UpdatePaymentStatus
  static const int promotion = 19; // 	Promotion
  static const int newOrder = 20; // 	NewOrder
  static const int addedByAdmin = 21; // 	Added By Admin
  static const int detectedByAdmin = 22; // 	Detected By Admin
  static const int tierUpgrade = 24; // 	Tier Upgrade
}

class SliderAssignType {
  static const int noAssign = 1;
  static const int assignedToBrand = 3;
  static const int assignedToProduct = 4;
  static const int assignedToCategory = 5;
}

class SharedPreferencesKeyConstants {
  static const String appLang = 'appLang';

  static const String appTheme = "appTheme";

  static const String notificationToken = "notificationToken";

  static const String tempToken = "tempToken";

  static const String accessToken = "accessToken";

  static const String sessionToken = "sessionToken";

  static const String isCompleted = "isCompleted";

  static const String hasReferral = "hasReferral";

  static const String showQr = "showQr";

  static const String isLogin = "isLogin";

  static const String userCode = "userCode";

  static const String fullName = "fullName";

  static const String mobile = "mobile";

  static const String gender = "gender";

  static const String userCountry = "userCountry";
}
