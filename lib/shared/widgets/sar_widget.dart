import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/constants/assets_constants.dart';
import '../../core/constants/constants.dart';
import '../../core/sdk/sdk_settings.dart';
import '../../core/utils/theme.dart';

class CurrencyWidget extends StatelessWidget {
  const CurrencyWidget({super.key, this.size = 18, this.color, this.textStyle, this.currencyCode});

  final double size;
  final Color? color;
  final TextStyle? textStyle;
  final Currency? currencyCode;

  @override
  Widget build(BuildContext context) {
    final Currency code = currencyCode ?? AppConstants.currencyCode;

    if (code == Currency.sar) {
      final Color effectiveColor = color ?? textStyle?.color ?? AppTheme.primaryColor;
      return SvgPicture.asset(AssetsConsts.sarLogo, width: size, height: size, color: effectiveColor);
    }

    if (code == Currency.aed) {
      final Color effectiveColor = color ?? textStyle?.color ?? AppTheme.primaryColor;
      return SvgPicture.asset(AssetsConsts.aedLogo, width: size, height: size, color: effectiveColor);
    }

    final TextStyle effectiveStyle = (textStyle ?? AppTheme.textStyle(size: size, color: color ?? AppTheme.primaryColor));

    return Text(code.tr, style: effectiveStyle);
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
    final Currency code = AppConstants.currencyCode;

    if (!useIcon || code != Currency.sar) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(amountText, style: amountStyle),
          SizedBox(width: space),
          Text(code.tr, style: effectiveCurrencyStyle),
        ],
      );
    }

    final Color color = iconColor ?? effectiveCurrencyStyle.color ?? amountStyle.color ?? AppTheme.textColor;
    final double size = iconSize ?? effectiveCurrencyStyle.fontSize ?? amountStyle.fontSize ?? 14;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(amountText, style: amountStyle),
        SizedBox(width: space),
        CurrencyWidget(size: size, color: color, textStyle: effectiveCurrencyStyle, currencyCode: code),
      ],
    );
  }
}
