import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/getx/merchant_info_controller.dart';
import '../../../../shared/widgets/shake_widget.dart';

class ContactUsController extends GetxController {
  final contactUsFormKey = GlobalKey<FormState>();
  final emailShakeKey = GlobalKey<ShakeWidgetState>();
  final noteShakeKey = GlobalKey<ShakeWidgetState>();
  final emailController = TextEditingController();
  final noteController = TextEditingController();
  String contactUsPhone = '';

  @override
  void onInit() {
    getMerchantInfo();
    super.onInit();
  }

  getMerchantInfo() async {
    final merchantInfoController =
        Get.isRegistered<MerchantInfoController>() ? Get.find<MerchantInfoController>() : Get.put(MerchantInfoController());
    await merchantInfoController.getMerchantContactInfoApi();
    contactUsPhone = merchantInfoController.merchantInfo?.mobile ?? '';
    update();
  }
}
