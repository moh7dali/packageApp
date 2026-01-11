import 'dart:ui';

import 'package:flutter/material.dart';

class MozaicLoyaltySDKSettings {
  final bool hostAppUseGetx;
  final Color? primaryColor;
  final Color? secondaryColor;
  final String? appTitleEn;
  final String? appTitleAr;
  final String? sdkLanguage;
  final ThemeMode? sdkTheme;

  const MozaicLoyaltySDKSettings({
    this.hostAppUseGetx = false,
    this.primaryColor,
    this.secondaryColor,
    this.appTitleEn,
    this.appTitleAr,
    this.sdkLanguage,
    this.sdkTheme,
  });
}
