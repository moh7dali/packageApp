import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MozaicLoyaltySDKSettings {
  final Widget logo;
  final bool appUseGetx;
  final String baseUrl;
  final int? customerIdentificationMethod;
  final String? accessToken;
  final String? sessionToken;
  final Color? primaryColor;
  final Color? secondaryColor;
  final ThemeMode? theme;
  final String? language;
  final Currency currencyCode;

  const MozaicLoyaltySDKSettings({
    required this.logo,
    required this.appUseGetx,
    required this.baseUrl,
    this.customerIdentificationMethod = 1,
    this.accessToken,
    this.sessionToken,
    this.primaryColor,
    this.secondaryColor,
    this.language,
    this.theme,
    this.currencyCode = Currency.sar,
  });

  MozaicLoyaltySDKSettings copyWith({String? sessionToken, String? accessToken}) {
    return MozaicLoyaltySDKSettings(
      logo: logo,
      baseUrl: baseUrl,
      appUseGetx: appUseGetx,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      language: language,
      theme: theme,
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
