import 'package:flutter/material.dart';
import 'package:my_custom_widget/my_custom_widget.dart';

class HeroLogo extends StatelessWidget {
  const HeroLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(tag: "HeroLogo", child: MozaicLoyaltySDK.settings.logoWidget);
  }
}
