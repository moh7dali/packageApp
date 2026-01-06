import 'package:my_custom_widget/core/constants/constants.dart';
import 'package:my_custom_widget/core/utils/theme.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

const methodChannel = MethodChannel('paymob_sdk_flutter');

Future<void> payWithPayMob({required String paymentToken, required VoidCallback onSuccessful, onRejected, onPending}) async {
  try {
    final String result = await methodChannel.invokeMethod('payWithPaymob', {
      "clientSecret": paymentToken,
      "publicKey": AppConstants.payMobPrivateKey,
      "appName": "title".tr,
      "buttonBackgroundColor": AppTheme.primaryColor.value,
      "buttonTextColor": AppTheme.whiteColor.value,
      "saveCardDefault": null,
      "showSaveCard": null,
    });
    switch (result) {
      case 'Successfull':
        onSuccessful.call();
        break;
      case 'Rejected':
        onRejected.call();
        break;
      case 'Pending':
        onPending.call();
        break;
      default:
        onRejected.call();
    }
  } on PlatformException catch (e) {
    print("Failed to call native SDK: '${e.message}'.");
    onRejected.call();
  }
}
