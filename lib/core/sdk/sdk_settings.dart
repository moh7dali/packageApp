import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MozaicLoyaltySDKSettings {
  final Widget logoWidget;
  final bool appUseGetx;
  final EnvironmentType environmentType;
  final bool? redeemPointsQRCode;
  final String? accessToken;
  final String? sessionToken;
  final Color? primaryColor;
  final Color? secondaryColor;
  final ThemeMode? sdkTheme;
  final String? sdkLanguage;
  final Currency currencyCode;

  const MozaicLoyaltySDKSettings({
    required this.logoWidget,
    required this.appUseGetx,
    required this.environmentType,
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
      logoWidget: logoWidget,
      environmentType: environmentType,
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

enum EnvironmentType { live, test }

enum Currency {
  sar,
  jd,
  usd,
  kwd;

  String get tr => name.tr;
}
