import "package:get/get.dart";

import "../../../../core/constants/constants.dart";
import "../../../../core/sdk/sdk_routes.dart";
import "../../../../injection_container.dart";
import "../../../../my_custom_widget.dart";
import "../../../../shared/helper/shared_helper.dart";
import "../../../../shared/helper/shared_preferences_storage.dart";

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), () {
      loginFlow();
    });
  }

  Future loginFlow() async {
    if (await SharedHelper().isUserLoggedIn()) {
      if (await sl<SharedPreferencesStorage>().getIsCompleted()) {
        SDKNav.offAllNamed(RouteConstant.homeScreen);
      } else {
        Get.deleteAll();
        SDKNav.offAllNamed(RouteConstant.completeProfile);
      }
    } else {
      SDKNav.offAllNamed(RouteConstant.authPage);
    }
  }
}
