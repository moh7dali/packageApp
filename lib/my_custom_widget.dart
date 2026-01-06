import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http_proxy_override/http_proxy_override.dart';

import 'core/constants/constants.dart';
import 'core/utils/network_info.dart';
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

class MyCustomWidget extends StatefulWidget {
  const MyCustomWidget({super.key, this.settings = const MyCustomWidgetSettings()});

  final MyCustomWidgetSettings settings;

  @override
  State<MyCustomWidget> createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  static bool _started = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    if (_started) {
      Get.offAllNamed(RouteConstant.splashPage);
      return;
    }
    _started = true;

    try {
      await di.init();

      if (!Get.isRegistered<ThemeController>()) {
        Get.put(themeController, permanent: true);
      }

      final defaultLanguage = await di.sl<SharedPreferencesStorage>().getAppLanguage();
      await di.sl<SharedPreferencesStorage>().setAppLanguage(defaultLanguage);
      appLanguage = await di.sl<SharedPreferencesStorage>().getAppLanguage();

      networkInfo = NetworkInfoImpl(di.sl());

      if (AppConstants.isProxyEnable) {
        final proxy = await HttpProxyOverride.createHttpProxy();
        HttpOverrides.global = proxy;
      }

      Get.offAllNamed(RouteConstant.splashPage);
    } catch (e) {
      _started = false;
      Get.snackbar('Package init failed', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = const Scaffold(body: Center(child: CircularProgressIndicator()));

    if (widget.settings.hostUsesScreenUtil) {
      return content;
    }
    return ScreenUtilInit(designSize: widget.settings.designSize, minTextAdapt: true, splitScreenMode: true, builder: (_, __) => content);
  }
}

class MyCustomWidgetSettings {
  final bool hostUsesScreenUtil;
  final Size designSize;

  const MyCustomWidgetSettings({this.hostUsesScreenUtil = false, this.designSize = const Size(360, 690)});
}
