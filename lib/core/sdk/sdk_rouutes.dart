import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../my_custom_widget.dart';

class SDKNav {
  static NavigatorState? get _state => MozaicLoyaltySDK.sdkNavKey.currentState;

  static void toNamed(String route, {dynamic arguments, bool preventDuplicates = true}) {
    _state?.pushNamed(route, arguments: arguments);
  }

  static void to(dynamic page) {
    _state?.push(page);
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
