import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/theme.dart';
import '../widgets/hero_logo.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeroLogo(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('noInternet'.tr, style: AppTheme.textStyle(color: AppTheme.blackColor, size: AppTheme.size16, isBold: true)),
            ],
          )
        ],
      ),
    );
  }
}
