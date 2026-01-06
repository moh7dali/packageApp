import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetController extends GetxController with GetSingleTickerProviderStateMixin {
  WidgetController({required this.length});

  int length;
  TabController? tabController;

  @override
  void onInit() {
    tabController = TabController(length: length, vsync: this);
    super.onInit();
  }
}
