import 'dart:convert';

import 'package:my_custom_widget/features/address/data/models/address_model.dart';
import 'package:my_custom_widget/features/branch/domain/entities/branch_details.dart';
import 'package:my_custom_widget/my_custom_widget.dart';
import 'package:my_custom_widget/shared/model/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/constants.dart';
import '../../features/address/domain/entity/address.dart';
import '../../features/auth/data/models/country_model.dart';
import '../../features/auth/domain/entities/country.dart';
import '../../features/branch/data/models/branch_details_model.dart';

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
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    return _preferences!.getBool(SharedPreferencesKeyConstants.appTheme) ?? (brightness == Brightness.dark);
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

  Future setSelectedBranch(BranchDetails selectedBranch) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.selectedBranch, jsonEncode((selectedBranch as BranchDetailsModel).toJson()));
  }

  Future<BranchDetails?> getSelectedBranch() async {
    String? branchString = _preferences!.getString(SharedPreferencesKeyConstants.selectedBranch);
    if (branchString == null || branchString.isEmpty) {
      return null;
    }
    return BranchDetailsModel.fromJson(json.decode(branchString));
  }

  Future setSelectedAddress(Address selectedAddress) async {
    await _preferences!.setString(SharedPreferencesKeyConstants.selectedAddress, jsonEncode((selectedAddress as AddressModel).toJson()));
  }

  Future<Address?> getSelectedAddress() async {
    String? addressString = _preferences!.getString(SharedPreferencesKeyConstants.selectedAddress);
    if (addressString == null || addressString.isEmpty) {
      return null;
    }
    return AddressModel.fromJson(json.decode(addressString));
  }

  Future setCartItems(CartItems item) async {
    final model = CartItemsModel.fromEntity(item);
    await _preferences!.setString(SharedPreferencesKeyConstants.cartItems, jsonEncode(model.toJson()));
    cartItems.value = item;
  }

  Future<CartItems> getCartItems() async {
    String? cartItemsString = _preferences!.getString(SharedPreferencesKeyConstants.cartItems);
    if (cartItemsString == null || cartItemsString.isEmpty) {
      return CartItems(products: []);
    }
    return CartItemsModel.fromJson(json.decode(cartItemsString));
  }

  Future setIsPickUp(bool isPickUp) async {
    await _preferences!.setBool(SharedPreferencesKeyConstants.isPickUp, isPickUp);
  }

  Future<bool> getIsPickUp() async {
    return _preferences!.getBool(SharedPreferencesKeyConstants.isPickUp) ?? true;
  }

  Future setIsBranchSelected(bool isBranchSelected) async {
    await _preferences!.setBool(SharedPreferencesKeyConstants.isBranchSelected, isBranchSelected);
  }

  Future<bool> getIsBranchSelected() async {
    return _preferences!.getBool(SharedPreferencesKeyConstants.isBranchSelected) ?? false;
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
    cartItems.value = CartItems(products: []);
  }
}
