import 'package:flutter/material.dart';

import '../../../../core/utils/theme.dart';
import '../getx/rate_branch_visit_controller.dart';

class FaceIconWidget extends StatelessWidget {
  const FaceIconWidget({super.key, required this.controller, required this.imageName, required this.index});

  final String imageName;
  final int index;
  final RateController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          controller.selectedIndex = index;
          controller.rateValue = index.toDouble() + 1;
          controller.update();
        },
        child: Opacity(
          opacity: controller.selectedIndex >= index ? 1 : .5,
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.selectedIndex == index ? AppTheme.primaryColor : Colors.white,
                  border: Border.all(width: controller.selectedIndex == index ? 2 : 0, color: AppTheme.primaryColor)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  imageName,
                  width: controller.selectedIndex == index ? 50 : 30,
                ),
              )),
        ),
      ),
    );
  }
}
