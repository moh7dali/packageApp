import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../injection_container.dart';
import '../helper/shared_preferences_storage.dart';

class ThemeController extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  Rx<bool> isDark = false.obs;

  Future<void> initTheme() async {
    bool darkPreference = await sl<SharedPreferencesStorage>().getTheme();
    isDark.value = darkPreference;
    themeMode.value = darkPreference ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
  }

  void toggleTheme() {
    isDark.value = !isDark.value;
    themeMode.value = isDark.value ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
    sl<SharedPreferencesStorage>().setTheme(isDark.value);
  }
}
