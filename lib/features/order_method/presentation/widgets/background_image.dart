import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/theme.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({super.key, required this.title, this.isBig = true});

  final String title;
  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: isBig ? const EdgeInsets.fromLTRB(16, 24, 16, 24) : const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: AppTheme.gradient1,
        borderRadius: isBig ? AppTheme.bigBorderRadius : AppTheme.borderRadius,
        border: Border.all(color: AppTheme.whiteColor.withOpacity(.16)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.14), blurRadius: 18, offset: const Offset(0, 10))],
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppTheme.whiteColor.withOpacity(.14),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppTheme.whiteColor.withOpacity(.20)),
            ),
            child: const Icon(Icons.store_mall_directory_outlined, color: Colors.white),
          ),
          Expanded(
            child: Text(
              title.tr,
              textAlign: TextAlign.center,
              style: AppTheme.textStyle(color: AppTheme.whiteColor, size: isBig ? AppTheme.size18 : AppTheme.size14, isBold: true),
            ),
          ),
        ],
      ),
    );
  }
}
