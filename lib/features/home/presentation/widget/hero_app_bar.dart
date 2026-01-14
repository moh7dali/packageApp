import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mozaic_loyalty_sdk/shared/widgets/hero_logo.dart';

AppBar heroAppBar() {
  return AppBar(
    titleSpacing: 10,
    title: GestureDetector(
      child: Row(
        children: [SizedBox(height: Get.height * .06, child: HeroLogo())],
      ),
    ),
  );
}
