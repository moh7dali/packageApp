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

  setAppLanguage(String appLanguage) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.appLang, appLanguage);
  }

  Future<String> getAppLanguage() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.appLang) ?? Get.deviceLocale!.languageCode;
  }

  setTheme(bool isDark) async {
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

  setTempToken(String tempToken) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.tempToken, tempToken);
  }

  Future<String?> getTempToken() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.tempToken);
  }

  setAccessToken(String accessToken) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.accessToken, accessToken);
  }

  Future<String?> getAccessToken() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.accessToken);
  }

  setUserCode(String userCode) async {
    return _preferences!.setString(SharedPreferencesKeyConstants.userCode, userCode);
  }

  Future<String?> getUserCode() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.userCode);
  }

  setSessionToken(String sessionToken) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.sessionToken, sessionToken);
  }

  Future<String?> getSessionToken() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.sessionToken);
  }

  setIsCompleted(bool isComplete) async {
    await _preferences!.setBool(SharedPreferencesKeyConstants.isCompleted, isComplete);
  }

  Future<bool> getIsCompleted() async {
    return _preferences!.getBool(SharedPreferencesKeyConstants.isCompleted) ?? false;
  }

  Future setHasReferral(bool hasReferral) async {
    await _preferences!.setBool(SharedPreferencesKeyConstants.hasReferral, hasReferral);
  }

  Future<bool> getHasReferral() async {
    return _preferences!.getBool(SharedPreferencesKeyConstants.hasReferral) ?? false;
  }

  setFullName(String fullName) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.fullName, fullName);
  }

  Future<String> getFullName() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.fullName) ?? '';
  }

  setMobile(String mobile) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.mobile, mobile);
  }

  Future<String?> getMobile() async {
    return _preferences!.getString(SharedPreferencesKeyConstants.mobile);
  }

  setGender(int gender) async {
    await _preferences!.setInt(SharedPreferencesKeyConstants.gender, gender);
  }

  Future<int?> getGender() async {
    return _preferences!.getInt(SharedPreferencesKeyConstants.gender);
  }

  setIsUserLoggedIn(bool isLogin) async {
    await _preferences!.setBool(SharedPreferencesKeyConstants.isLogin, isLogin);
  }

  Future<bool> getIsUserLoggedIn() async {
    return _preferences!.getBool(SharedPreferencesKeyConstants.isLogin) ?? false;
  }

  Future setShowQr(bool show) async {
    await _preferences!.setBool(SharedPreferencesKeyConstants.showQr, show);
  }

  Future<bool> getShowQr() async {
    return _preferences!.getBool(SharedPreferencesKeyConstants.showQr) ?? false;
  }

  setUserCountry(Country country) async {
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

  Future deleteAllData() async {
    final keys = _preferences!.getKeys();
    for (String key in keys) {
      if (key != SharedPreferencesKeyConstants.appLang && key != SharedPreferencesKeyConstants.appTheme) {
        await _preferences!.remove(key);
      }
    }
  }
}
