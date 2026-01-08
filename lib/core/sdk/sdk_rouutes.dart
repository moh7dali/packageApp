import 'package:get/get.dart';

import '../../my_custom_widget.dart';

class SDKNav {
  static int? get currentId => MozaicLoyaltySDK.settings.hostAppUseGetx ? MozaicLoyaltySDK.sdkNavigatorId : null;

  static void toNamed(String route, {dynamic arguments, bool preventDuplicates = true}) {
    Get.toNamed(route, arguments: arguments, id: currentId, preventDuplicates: true);
  }

  static void offAllNamed(String route, {dynamic arguments}) {
    Get.offAllNamed(route, id: currentId, arguments: arguments);
  }

  static void back() {
    Get.back(id: currentId);
  }

  static void to(dynamic page, {dynamic arguments}) {
    Get.to(page, arguments: arguments, id: currentId);
  }
}
