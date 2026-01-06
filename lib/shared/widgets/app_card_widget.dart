import 'package:flutter/material.dart';

import '../../core/utils/theme.dart';

class AppCard extends StatelessWidget {
  final EdgeInsets? margin;
  final RoundedRectangleBorder? shape;
  final Widget? child;
  final bool isWhite;
  final LinearGradient? gradient;

  const AppCard({super.key, this.margin, this.shape, this.child, this.isWhite = false, this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        gradient: isWhite ? null : gradient ?? AppTheme.gradient1,
        color: isWhite ? Colors.white : null,
        boxShadow: const [BoxShadow()],
        borderRadius: shape?.borderRadius,
        border: shape != null
            ? Border.fromBorderSide(
                shape!.side,
              )
            : null,
      ),
      child: child,
    );
  }
}
