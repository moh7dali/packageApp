import 'dart:io';

import 'package:my_custom_widget/shared/helper/shared_helper.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/utils/app_log.dart';

class LocationHelper {
  static Future<void> requestLocationPermission(Future<void> Function(Position position) onGranted) async {
    try {
      await Geolocator.requestPermission();
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        final position = await Geolocator.getCurrentPosition();
        await onGranted(position);
        return;
      }
      final permissionStatus = await Geolocator.requestPermission();
      if (permissionStatus != LocationPermission.always && permissionStatus != LocationPermission.whileInUse) {
        SharedHelper().actionDialog(
          'permissionNotAllowed'.tr,
          'locationPermissionShouldAllowed'.tr,
          cancelText: 'close'.tr,
          confirmText: 'openAppSettings'.tr,
          confirm: () async {
            SharedHelper().closeAllDialogs();
            if (Platform.isIOS) {
              if (await Geolocator.isLocationServiceEnabled()) {
                openAppSettings();
              } else {
                openLocationSetting();
              }
            } else {
              openAppSettings();
            }
          },
          cancel: () {
            SharedHelper().closeAllDialogs();
          },
        );
      }
    } catch (e, t) {
      appLog("E: $e", tag: "LocationHelper requestLocationPermission", isError: true, trace: t);
    }
  }
}

Future<void> openLocationSetting() async {
  if (Platform.isIOS) {
    const MethodChannel prefs = MethodChannel('com.mozaicis.jarwan/openLocationSetting');
    try {
      await prefs.invokeMethod('openLocationSetting');
    } on PlatformException {
      appLog('Failed to openLocationSetting.');
    }
  } else {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        await Geolocator.openLocationSettings();
      }
    } catch (_) {}
  }
}
