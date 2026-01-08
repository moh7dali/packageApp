import 'dart:ui';

class MozaicLoyaltySDKSettings {
  final bool hostAppUseGetx;
  final Color? primaryColor;
  final Color? secondaryColor;
  final String? appTitleEn;
  final String? appTitleAr;
  final String? sdkLanguage;

  const MozaicLoyaltySDKSettings({
    this.hostAppUseGetx = false,
    this.primaryColor,
    this.secondaryColor,
    this.appTitleEn,
    this.appTitleAr,
    this.sdkLanguage,
  });
}
