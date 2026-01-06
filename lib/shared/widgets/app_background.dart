import 'package:flutter/material.dart';

import '../../core/constants/assets_constants.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(AssetsConsts.splashBg), fit: BoxFit.fill),
      ),
      child: child,
    );
  }
}
