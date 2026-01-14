import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../mozaic_loyalty_sdk.dart';

class SDKNav {
  static NavigatorState? get _state => MozaicLoyaltySDK.sdkNavKey.currentState;

  static void toNamed(String route, {Object? arguments}) {
    _state?.pushNamed(route, arguments: arguments);
  }

  static void offAllNamed(String route, {dynamic arguments}) {
    _state?.pushNamedAndRemoveUntil(route, (route) => false, arguments: arguments);
  }

  static void back() {
    if (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) {
      Get.back();
    } else {
      if (_state?.canPop() ?? false) {
        _state?.pop();
      }
    }
  }
}
