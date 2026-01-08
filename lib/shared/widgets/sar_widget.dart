import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/constants/constants.dart';
import '../../core/utils/theme.dart';
import '../helper/shared_helper.dart';

class SarWidget extends StatelessWidget {
  const SarWidget({super.key, this.size = 18, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AssetsConsts.sarLogo, width: size, height: size, color: color ?? AppTheme.primaryColor);
  }
}

class CurrencyAmountText extends StatelessWidget {
  const CurrencyAmountText({
    super.key,
    required this.amountText,
    required this.amountStyle,
    this.currencyStyle,
    this.useIcon = true,
    this.iconSize,
    this.iconColor,
    this.space = 4,
  });

  final String amountText;
  final TextStyle amountStyle;
  final TextStyle? currencyStyle;
  final bool useIcon;
  final double? iconSize;
  final Color? iconColor;
  final double space;

  @override
  Widget build(BuildContext context) {
    final TextStyle effectiveCurrencyStyle = currencyStyle ?? amountStyle;

    if (!useIcon) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(amountText, style: amountStyle),
          SizedBox(width: space),
          Text(AppConstants.currencyCode.tr, style: effectiveCurrencyStyle),
        ],
      );
    }
    final color = iconColor ?? effectiveCurrencyStyle.color ?? amountStyle.color ?? AppTheme.textColor;
    final size = iconSize ?? effectiveCurrencyStyle.fontSize ?? amountStyle.fontSize ?? 14;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(amountText, style: amountStyle),
        SizedBox(width: space),
        SarWidget(size: size, color: color),
      ],
    );
  }
}

String formatAmountWithCurrency(num value) {
  return "${SharedHelper.getNumberFormat(value, isCurrency: true)} ${AppConstants.currencyCode.tr}";
}
