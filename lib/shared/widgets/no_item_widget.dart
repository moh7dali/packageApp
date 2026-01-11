import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_custom_widget/core/constants/assets_constants.dart';

class NoItemWidget extends StatelessWidget {
  const NoItemWidget({super.key, this.isSmall = false});

  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: Get.height * .02),
        Center(child: Lottie.asset(AssetsConsts.noItems, height: isSmall ? Get.width * .35 : Get.width * .5)),
        SizedBox(height: Get.height * .02),
      ],
    );
  }
}
