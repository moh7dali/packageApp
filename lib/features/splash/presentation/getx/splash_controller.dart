import "package:get/get.dart";
import "package:my_custom_widget/shared/helper/device_info.dart";

import "../../../../core/constants/constants.dart";
import "../../../../core/sdk/sdk_rouutes.dart";
import "../../../../core/utils/app_log.dart";
import "../../../../injection_container.dart";
import "../../../../shared/helper/shared_helper.dart";
import "../../../../shared/helper/shared_preferences_storage.dart";

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), () {
      DeviceInfo.getDeviceData();
      finishAdvertising();
    });
  }

  Future finishAdvertising() async {
    appLog(await SharedHelper().isUserLoggedIn(), tag: "isUserLoggedIn");
    appLog(await sl<SharedPreferencesStorage>().getIsCompleted(), tag: "getIsCompleted");
    sl<SharedPreferencesStorage>().setShowQr(true);
    if (await SharedHelper().isUserLoggedIn()) {
      if (await sl<SharedPreferencesStorage>().getIsCompleted()) {
        SDKNav.offAllNamed(RouteConstant.mainPage);
      } else {
        Get.deleteAll();
        SDKNav.offAllNamed(RouteConstant.completeProfile);
      }
    } else {
      SDKNav.offAllNamed(RouteConstant.authPage);
    }
  }
}
