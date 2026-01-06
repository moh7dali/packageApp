import 'package:my_custom_widget/core/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchWidgetLoading extends StatelessWidget {
  const BranchWidgetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                AssetsConsts.loading,
                fit: BoxFit.cover,
                width: Get.width,
                height: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}