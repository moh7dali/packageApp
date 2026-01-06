import "dart:ui";

import "package:my_custom_widget/my_custom_widget.dart";
import "package:my_custom_widget/shared/helper/shared_helper.dart";
import "package:get/get.dart";
import "package:onesignal_flutter/onesignal_flutter.dart";

import "../../core/api/api_end_points.dart";
import "../../core/api/api_request.dart";
import "../../core/api/api_response.dart";
import "../../core/constants/constants.dart";
import "../../injection_container.dart";
import "../helper/shared_preferences_storage.dart";

class LanguageController extends GetxController {
  String appLang = "en";

  @override
  void onInit() {
    super.onInit();
    initLang();
  }

  Future initLang() async {
    appLang = await sl<SharedPreferencesStorage>().getAppLanguage();
    Get.updateLocale(Locale(appLang));
    OneSignal.User.setLanguage(appLang);
  }

  Future changeLanguage(String lang, String toPage) async {
    appLang = lang;
    Get.updateLocale(Locale(lang));
    appLanguage = lang;
    OneSignal.User.setLanguage(appLang);
    sl<SharedPreferencesStorage>().setAppLanguage(lang);
    update();
    SharedHelper().closeAllDialogs();
    SharedHelper().isUserLoggedIn().then((value) async {
      if (value) {
        await ApiRequest<dynamic>().request(
          method: HttpMethodRequest.postMethode,
          url: ApiEndPoints.changeDeviceLanguage,
          body: {},
          authorized: true,
          fromJson: getDynamic,
        );
      }
    });
    if (toPage != '') {
      Get.deleteAll();
      Get.offAllNamed(toPage);
    }
    update();
  }
}
