import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/constants/assets_constants.dart';

class HeroLogo extends StatelessWidget {
  final double? height;
  final bool isWhite;
  final bool smallLogo;

  const HeroLogo({super.key, this.height, this.isWhite = false, this.smallLogo = false});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "HeroLogo",
      child: SvgPicture.asset(
        smallLogo
            ? AssetsConsts.iconLogo
            : isWhite
            ? AssetsConsts.logoWhite
            : AssetsConsts.logo,
        height: smallLogo ? height ?? Get.height * .1 : height ?? Get.height * .1,
      ),
    );
  }
}
