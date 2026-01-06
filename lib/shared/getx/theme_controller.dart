import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../injection_container.dart';
import '../helper/shared_preferences_storage.dart';

class ThemeController<T> extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  Rx<bool> isDark = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  init() async {
    // isDark.value = await sl<SharedPreferencesStorage>().getTheme();
    // if (isDark.value) {
    themeMode.value = ThemeMode.light;
    // }
  }

  void toggleTheme({GetxController? controller}) {
    themeMode.value = themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    isDark.value = themeMode.value == ThemeMode.dark;
    Get.changeThemeMode(themeMode.value);
    sl<SharedPreferencesStorage>().setTheme(isDark.value);
    Get.forceAppUpdate();
    // if (Get.isRegistered<MainController>() && Get.isRegistered<HomeController>()) {
    //   print("Yes");
    //   MainController mainController = Get.find<MainController>();
    //   mainController.update();
    //   HomeController homeController = Get.find<HomeController>();
    //   homeController.update();
    // } else {
    //   print("No");
    // }
  }
}
