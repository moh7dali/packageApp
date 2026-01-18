import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MozaicLoyaltySDKSettings {
  final Widget widgetLogo;
  final bool appUseGetx;
  final String  baseUrl;
  final bool? redeemPointsQRCode;
  final String? accessToken;
  final String? sessionToken;
  final Color? primaryColor;
  final Color? secondaryColor;
  final ThemeMode? sdkTheme;
  final String? sdkLanguage;
  final Currency currencyCode;

  const MozaicLoyaltySDKSettings({
    required this.widgetLogo,
    required this.appUseGetx,
    required this.baseUrl,
    this.redeemPointsQRCode = true,
    this.accessToken,
    this.sessionToken,
    this.primaryColor,
    this.secondaryColor,
    this.sdkLanguage,
    this.sdkTheme,
    this.currencyCode = Currency.sar,
  });

  MozaicLoyaltySDKSettings copyWith({String? sessionToken, String? accessToken}) {
    return MozaicLoyaltySDKSettings(
      widgetLogo: widgetLogo,
      baseUrl: baseUrl,
      appUseGetx: appUseGetx,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      sdkLanguage: sdkLanguage,
      sdkTheme: sdkTheme,
      currencyCode: currencyCode,
      sessionToken: sessionToken ?? this.sessionToken,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

enum Currency {
  sar,
  jd,
  usd,
  aed,
  kwd;

  String get tr => name.tr;
}
