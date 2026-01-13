import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/constants.dart';
import '../../features/auth/data/models/country_model.dart';
import '../../features/auth/domain/entities/country.dart';
import '../../my_custom_widget.dart';

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
    if (MozaicLoyaltySDK.settings.sdkTheme != null) {
      print("Priority: SDK Settings Found - ${MozaicLoyaltySDK.settings.sdkTheme}");
      return MozaicLoyaltySDK.settings.sdkTheme == ThemeMode.dark;
    }
    bool? savedTheme = _preferences!.getBool(SharedPreferencesKeyConstants.appTheme);
    if (savedTheme != null) {
      print("Priority: Saved Pref Found - $savedTheme");
      return savedTheme;
    }

    return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }

  Future<void> setTempToken(String tempToken) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.tempToken, tempToken);
  }

  Future<String?> getTempToken() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.tempToken);
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

  Future<void> setIsCompleted(bool isComplete) async {
    await _preferences!.setBool(SharedPreferencesKeyConstants.isCompleted, isComplete);
  }

  Future<bool> getIsCompleted() async {
    return _preferences!.getBool(SharedPreferencesKeyConstants.isCompleted) ?? false;
  }

  Future<void> setIsUserLoggedIn(bool isLogin) async {
    await _preferences!.setBool(SharedPreferencesKeyConstants.isLogin, isLogin);
  }

  Future<bool> getIsUserLoggedIn() async {
    return _preferences!.getBool(SharedPreferencesKeyConstants.isLogin) ?? false;
  }

  Future<void> setUserCountry(Country country) async {
    final countryModel = CountryModel.fromCountry(country);
    final countryString = jsonEncode(countryModel.toJson());
    await _preferences!.setString(SharedPreferencesKeyConstants.userCountry, countryString);
  }

  Future<Country?> getUserCountry() async {
    String? countryString = _preferences!.getString(SharedPreferencesKeyConstants.userCountry);
    if (countryString == null || countryString.isEmpty) {
      return null;
    }
    return CountryModel.fromJson(json.decode(countryString));
  }

  Future<void> setMobile(String mobile) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.mobile, mobile);
  }

  Future<String?> getMobile() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.mobile);
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
