import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/utils/theme.dart';

class DataLoadingWidget extends StatelessWidget {
  const DataLoadingWidget({super.key, this.height});

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [LoadingAnimationWidget.inkDrop(color: AppTheme.primaryColor, size: Get.height * .12)],
      ),
    );
  }
}
