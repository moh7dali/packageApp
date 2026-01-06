import 'package:flutter/material.dart';

import '../../core/utils/theme.dart';

class CardAppWidget extends StatelessWidget {
  const CardAppWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.accentColor,
        borderRadius: AppTheme.bigBorderRadius,
        border: Border.all(color: AppTheme.accentColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppTheme.accentColor,
            blurRadius: 15,
            blurStyle: BlurStyle.solid,
          )
        ],
      ),
      child: child,
    );
  }
}
