import 'package:flutter/material.dart';

class MozaicLoyaltySDKSettings {
  final Widget logoWidget;
  final bool appUseGetx;
  final EnvironmentType environmentType;
  final int merchantId;
  final bool? redeemPointsQRCode;
  final String? accessToken;
  final String? sessionToken;
  final Color? primaryColor;
  final Color? secondaryColor;
  final ThemeMode? sdkTheme;
  final String? sdkLanguage;

  const MozaicLoyaltySDKSettings({
    required this.logoWidget,
    required this.appUseGetx,
    required this.merchantId,
    required this.environmentType,
    this.redeemPointsQRCode = true,
    this.accessToken,
    this.sessionToken,
    this.primaryColor,
    this.secondaryColor,
    this.sdkLanguage,
    this.sdkTheme,
  });

  MozaicLoyaltySDKSettings copyWith({String? sessionToken, String? accessToken}) {
    return MozaicLoyaltySDKSettings(
      logoWidget: logoWidget,
      environmentType: environmentType,
      merchantId: merchantId,
      appUseGetx: appUseGetx,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      sdkLanguage: sdkLanguage,
      sdkTheme: sdkTheme,
      sessionToken: sessionToken ?? this.sessionToken,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}

enum EnvironmentType { live, test }
