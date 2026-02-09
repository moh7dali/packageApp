import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SDKWidgetController extends GetxController with GetSingleTickerProviderStateMixin {
  SDKWidgetController({required this.length});

  int length;
  TabController? tabController;

  @override
  void onInit() {
    tabController = TabController(length: length, vsync: this);
    super.onInit();
  }
}
