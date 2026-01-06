import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/theme.dart';

class ColorInfoWidget extends StatelessWidget {
  const ColorInfoWidget({super.key, required this.title, required this.color});

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Icon(
          Icons.circle,
          size: 10,
          color: color,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          title.tr,
          style: AppTheme.textStyle(color: AppTheme.primaryColor, size: AppTheme.size10),
        )
      ]),
    );
  }
}
