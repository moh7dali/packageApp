import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../core/utils/app_log.dart';

class DeviceInfo {
  static Future<Map<String, String>> getDeviceData() async {
    Map<String, String> deviceInfo = {};
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String? deviceID = "";
    String? deviceName = "";
    int devicePlatform = 1;

    var oneSignalToken = OneSignal.User.pushSubscription.id;
    appLog(oneSignalToken, tag: "userPushSubscription");
    String notificationToken = "$oneSignalToken";
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      deviceID = androidInfo.id;
      deviceName = '${androidInfo.brand} ${androidInfo.model}';
      devicePlatform = 2;
      deviceInfo = {"DeviceId": deviceID, "DevicePlatform": '$devicePlatform', "DeviceName": deviceName, "NotificationToken": notificationToken};
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      deviceID = iosInfo.identifierForVendor;
      deviceName = '${iosInfo.name} - ${iosInfo.utsname.nodename}';
      appLog('deviceName: $deviceName');
      devicePlatform = 1;
      deviceInfo = {"DeviceId": '$deviceID', "DevicePlatform": '$devicePlatform', "DeviceName": deviceName, "NotificationToken": notificationToken};
    }
    appLog('deviceName: $deviceInfo');
    return deviceInfo;
  }
}
