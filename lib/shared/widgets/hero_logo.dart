import 'package:flutter/material.dart';
import 'package:mozaic_loyalty_sdk/mozaic_loyalty_sdk.dart';

class HeroLogo extends StatelessWidget {
  const HeroLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(tag: "HeroLogo", child: MozaicLoyaltySDK.settings.logoWidget);
  }
}
