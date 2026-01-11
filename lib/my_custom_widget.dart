import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http_proxy_override/http_proxy_override.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:my_custom_widget/core/utils/translate/translation.dart';
import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:my_custom_widget/shared/helper/shared_preferences_storage.dart';

import 'core/constants/constants.dart';
import 'core/routes/routes_generator.dart';
import 'core/sdk/sdk_settings.dart';
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

  static final GlobalKey<NavigatorState> sdkNavKey = GlobalKey<NavigatorState>(debugLabel: 'MozaicSDKKey');
  static bool _initialized = false;
  static const int sdkNavigatorId = 1;
  static late MozaicLoyaltySDKSettings settings;

  static Future<void> init({required MozaicLoyaltySDKSettings sdkSettings}) async {
    if (_initialized) return;
    _initialized = true;

    settings = sdkSettings;

    await di.init();

    final sdkTranslations = Translation();
    Get.appendTranslations(sdkTranslations.keys);
    String defaultLanguage = settings.sdkLanguage ?? await di.sl<SharedPreferencesStorage>().getAppLanguage();
    await di.sl<SharedPreferencesStorage>().setAppLanguage(defaultLanguage);
    appLanguage = defaultLanguage;
    Get.updateLocale(Locale(appLanguage));
    networkInfo = NetworkInfoImpl(di.sl());
    if (AppConstants.isProxyEnable) {
      final proxy = await HttpProxyOverride.createHttpProxy();
      HttpOverrides.global = proxy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            if (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) {
              await SharedHelper().closeAllDialogs();
              return;
            }

            final state = MozaicLoyaltySDK.sdkNavKey.currentState;
            if (state != null && state.canPop()) {
              state.pop();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: MozaicLoyaltySDK.settings.hostAppUseGetx ? _buildNestedNavigator() : _buildStandaloneApp(),
        );
      },
    );
  }

  Widget _buildNestedNavigator() {
    return Theme(
      data: AppTheme.lightTheme,
      child: Localizations(
        locale: Locale(appLanguage),
        delegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
        child: Navigator(
          key: MozaicLoyaltySDK.sdkNavKey,
          initialRoute: RouteConstant.splashPage,
          onGenerateRoute: (settings) => RouteGeneratorList().onGenerateRoute(settings),
        ),
      ),
    );
  }

  Widget _buildStandaloneApp() {
    return GetMaterialApp(
      navigatorKey: MozaicLoyaltySDK.sdkNavKey,
      debugShowCheckedModeBanner: false,
      translations: Translation(),
      locale: Locale(appLanguage),
      fallbackLocale: const Locale('en'),
      theme: AppTheme.lightTheme,
      getPages: RouteGeneratorList().appRoutes,
      initialRoute: RouteConstant.splashPage,
    );
  }
}
