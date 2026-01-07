import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http_proxy_override/http_proxy_override.dart';
import 'package:my_custom_widget/core/utils/translate/translation.dart';
import 'package:my_custom_widget/shared/helper/shared_preferences_storage.dart';

import 'core/constants/constants.dart';
import 'core/routes/routes_generator.dart';
import 'core/utils/network_info.dart';
import 'injection_container.dart' as di;
import 'shared/getx/theme_controller.dart';
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

class MozaicLoyaltySDK extends StatelessWidget {
  const MozaicLoyaltySDK({super.key});

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

  @override
  Widget build(BuildContext context) {
    if (!settings.userUseScreenUtils) {
      return ScreenUtilInit(designSize: const Size(375, 812), minTextAdapt: true, builder: (_, __) => _buildApp());
    }

    return _buildApp();
  }

  Widget _buildApp() {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: Translation(),
      locale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      getPages: RouteGeneratorList().appRoutes,
      initialRoute: RouteConstant.splashPage,
    );
  }
}

class MozaicLoyaltySDKSettings {
  final bool userUseScreenUtils;

  const MozaicLoyaltySDKSettings({this.userUseScreenUtils = true});
}
