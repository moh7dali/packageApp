import 'package:flutter/material.dart';

class MozaicLoyaltySDKSettings {
  final bool appUseGetx;
  final String? accessToken;
  final String? sessionToken;
  final Widget logoWidget;
  final Color? primaryColor;
  final Color? secondaryColor;
  final String? appTitleEn;
  final String? appTitleAr;
  final String? sdkLanguage;
  final bool? redeemPointsQRCode;
  final ThemeMode? sdkTheme;

  const MozaicLoyaltySDKSettings({
    required this.logoWidget,
    this.appUseGetx = false,
    this.redeemPointsQRCode = true,
    this.accessToken,
    this.sessionToken,
    this.primaryColor,
    this.secondaryColor,
    this.appTitleEn,
    this.appTitleAr,
    this.sdkLanguage,
    this.sdkTheme,
  });

  MozaicLoyaltySDKSettings copyWith({String? sessionToken, String? accessToken}) {
    return MozaicLoyaltySDKSettings(
      logoWidget: logoWidget,
      appUseGetx: appUseGetx,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      sdkLanguage: sdkLanguage,
      appTitleAr: appTitleAr,
      appTitleEn: appTitleEn,
      sdkTheme: sdkTheme,
      sessionToken: sessionToken ?? this.sessionToken,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
