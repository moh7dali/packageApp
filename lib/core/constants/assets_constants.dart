class AssetsConsts {
  static String get svgPath => "packages/mozaic_loyalty_sdk/assets/svgs/";

  static String get imagesPath => "packages/mozaic_loyalty_sdk/assets/images/";

  static String get gifPath => "packages/mozaic_loyalty_sdk/assets/gif/";

  ///*************************///
  ///SVG
  ///*************************///

  static String get sarLogo => '${svgPath}sar_logo.svg';

  ///Profile Screen
  static String get person => "${svgPath}profile_name.svg";

  static String get callProfile => "${svgPath}profile_phone.svg";

  static String get bodIcon => '${svgPath}profile_data.svg';

  static String get genderIcon => '${svgPath}profile_gender.svg';

  static String get referral => "${svgPath}profile_referral.svg";

  static String get points => '${svgPath}tab_points.svg';

  static String get rewards => '${svgPath}tab_rewards.svg';

  ///*************************///
  ///Images
  ///*************************///

  /// Image Error
  static String get imageError => '${imagesPath}imageError.png';

  static String get imageErrorLong => '${imagesPath}imageErrorLong.png';

  /// Mozaic Logo
  static String get mozaicLogo => '${imagesPath}mozaicLogo.png';

  static String get shareIcon => '${imagesPath}referral.png';

  ///*************************///
  ///GIF
  ///*************************///

  ///SERVER ERROR
  static String get serverError => "${gifPath}serverError.json";

  static String get noInternet => "${gifPath}noInternet.json";

  ///LOADING
  static String get loading => '${gifPath}loading.gif';

  static String get qrCodeLoading => '${gifPath}qr_code_loading.json';

  static String get noItems => '${gifPath}empty_box.json';

  static String get noAccount => '${gifPath}no_account.json';
}
