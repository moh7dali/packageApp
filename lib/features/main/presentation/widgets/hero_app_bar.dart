import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_custom_widget/shared/widgets/hero_logo.dart';

AppBar heroAppBar() {
  return AppBar(
    titleSpacing: 10,
    title: Row(
      children: [SizedBox(height: Get.height * .06, child: HeroLogo())],
    ),
  );
}
