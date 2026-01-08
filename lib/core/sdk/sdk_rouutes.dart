import 'package:get/get.dart';

import '../../my_custom_widget.dart';

class SDKNav {
  static int? get currentId =>
      MozaicLoyaltySDK.settings.hostAppUseGetx ? MozaicLoyaltySDK.sdkNavigatorId : null;

  static void toNamed(String route, {dynamic arguments}) {
    Get.toNamed(route, arguments: arguments, id: currentId);
  }

  static void offAllNamed(String route) {
    Get.offAllNamed(route, id: currentId);
  }

  static void back() {
    Get.back(id: currentId);
  }
}