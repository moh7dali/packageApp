import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/constants.dart';
import '../../mozaic_loyalty_sdk.dart';

class SharedPreferencesStorage {
  static late SharedPreferences? _preferences;

  SharedPreferencesStorage() {
    try {
      _preferences!.getKeys();
    } catch (e) {
      init();
    }
  }

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setAppLanguage(String appLanguage) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.appLang, appLanguage);
  }

  Future<String> getAppLanguage() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.appLang) ?? Get.deviceLocale!.languageCode;
  }

  Future<void> setTheme(bool isDark) async {
    await _preferences!.setBool(SharedPreferencesKeyConstants.appTheme, isDark);
  }

  Future<bool> getTheme() async {
    if (MozaicLoyaltySDK.settings.theme != null) {
      print("Priority: SDK Settings Found - ${MozaicLoyaltySDK.settings.theme}");
      return MozaicLoyaltySDK.settings.theme == ThemeMode.dark;
    }
    bool? savedTheme = _preferences!.getBool(SharedPreferencesKeyConstants.appTheme);
    if (savedTheme != null) {
      print("Priority: Saved Pref Found - $savedTheme");
      return savedTheme;
    }

    return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }

  Future<void> setAccessToken(String accessToken) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.accessToken, accessToken);
  }

  Future<String?> getAccessToken() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.accessToken);
  }

  Future<void> setSessionToken(String sessionToken) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.sessionToken, sessionToken);
  }

  Future<String?> getSessionToken() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.sessionToken);
  }

  Future<void> setIsUserLoggedIn(bool isLogin) async {
    await _preferences!.setBool(SharedPreferencesKeyConstants.isLogin, isLogin);
  }

  Future<bool> getIsUserLoggedIn() async {
    return _preferences!.getBool(SharedPreferencesKeyConstants.isLogin) ?? false;
  }

  Future deleteAllData() async {
    final keys = _preferences!.getKeys();
    for (String key in keys) {
      if (key != SharedPreferencesKeyConstants.appLang && key != SharedPreferencesKeyConstants.appTheme) {
        await _preferences!.remove(key);
      }
    }
  }
}
