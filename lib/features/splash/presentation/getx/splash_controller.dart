import "package:get/get.dart";

import "../../../../core/constants/constants.dart";
import "../../../../core/sdk/sdk_routes.dart";
import "../../../../injection_container.dart";
import "../../../../shared/helper/shared_helper.dart";
import "../../../../shared/helper/shared_preferences_storage.dart";

class SDKSplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), () {
      loginFlow();
    });
  }

  Future loginFlow() async {
    if (await SharedHelper().isUserLoggedIn()) {
      SDKNav.offAllNamed(RouteConstant.homeScreen);
    } else {
      SharedHelper().showUnRegisterPopUp();
    }
  }
}
