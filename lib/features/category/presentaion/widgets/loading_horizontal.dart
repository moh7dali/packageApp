import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/assets_constants.dart';
import '../../../../core/utils/theme.dart';

class LoadingInHorizontal extends StatelessWidget {
  const LoadingInHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * .3,
      decoration: BoxDecoration(
        borderRadius: AppTheme.bigBorderRadius,
        image: DecorationImage(image: AssetImage(AssetsConsts.loading), fit: BoxFit.cover),
      ),
    );
  }
}
