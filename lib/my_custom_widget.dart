import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http_proxy_override/http_proxy_override.dart';

import 'core/constants/constants.dart';
import 'core/routes/routes_generator.dart';
import 'core/utils/network_info.dart';
import 'core/utils/theme.dart';
import 'core/utils/translate/translation.dart';
import 'injection_container.dart' as di;
import 'shared/getx/theme_controller.dart';
import 'shared/helper/shared_preferences_storage.dart';
import 'shared/model/cart_items.dart';
import 'shared/model/push_notification_model.dart';

ValueNotifier<bool> isSkipped = ValueNotifier(false);
String appLanguage = 'en';
ValueNotifier<int> numOfUnReadNotifications = ValueNotifier(0);
ValueNotifier<CartItems> cartItems = ValueNotifier(CartItems(products: []));
bool isSystem = false;
bool fromPush = false;
PushNotificationModel? systemNotificationModel;
bool isZoomed = false;
final ThemeController themeController = ThemeController();
NetworkInfo? networkInfo;

class MozaicLoyaltySDKConfig {
  static final translations = Translation();
  static final theme = AppTheme.lightTheme;
  static final getPages = RouteGeneratorList().appRoutes;
  static const initialRoute = RouteConstant.splashPage;
  static const fallbackLocale = Locale('en');
}

class MozaicLoyaltySDK {
  static bool _initialized = false;
  static late MozaicLoyaltySDKSettings settings;

  static Future<void> init({required MozaicLoyaltySDKSettings sdkSettings}) async {
    if (_initialized) return;
    _initialized = true;

    settings = sdkSettings;

    await di.init();

    if (!Get.isRegistered<ThemeController>()) {
      Get.put(themeController, permanent: true);
    }

    final defaultLanguage = await di.sl<SharedPreferencesStorage>().getAppLanguage();
    await di.sl<SharedPreferencesStorage>().setAppLanguage(defaultLanguage);
    appLanguage = defaultLanguage;

    networkInfo = NetworkInfoImpl(di.sl());

    if (AppConstants.isProxyEnable) {
      final proxy = await HttpProxyOverride.createHttpProxy();
      HttpOverrides.global = proxy;
    }
  }
}

class MozaicLoyaltySDKSettings {
  final bool hostUsesScreenUtil;
  final Size designSize;

  const MozaicLoyaltySDKSettings({required this.hostUsesScreenUtil, this.designSize = const Size(360, 690)});
}

class MozaicScreenUtil {
  static Widget ensure({required Widget child}) {
    if (MozaicLoyaltySDK.settings.hostUsesScreenUtil) {
      return child;
    }
    return ScreenUtilInit(designSize: MozaicLoyaltySDK.settings.designSize, minTextAdapt: true, splitScreenMode: true, builder: (_, __) => child);
  }
}
