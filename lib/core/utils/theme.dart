import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../mozaic_loyalty_sdk.dart';

class AppTheme {
  static const blackColor = Colors.black;
  static const whiteColor = Colors.white;
  static const redColor = Colors.red;
  static const greyColor = Colors.grey;
  static const errorColor = redColor;

  static const darkColor = Color(0xff464646);
  static const primaryColorString = "#000000";

  static Color get primaryColor => MozaicLoyaltySDK.settings.primaryColor ?? Color(0xff53bfed);

  static Color get secondaryColor => MozaicLoyaltySDK.settings.secondaryColor ?? Color(0xff8bc541);

  static final gradient1 = LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [primaryColor, secondaryColor]);

  static Color get textColor => themeController.isDark.value ? whiteColor : blackColor;

  static Color get bgThemeColor => themeController.isDark.value ? darkColor : whiteColor;

  static BorderRadius borderRadius = BorderRadius.circular(8.r);
  static BorderRadius bigBorderRadius = BorderRadius.circular(12.r);

  static final underLineBorder = UnderlineInputBorder(borderSide: BorderSide(color: primaryColor, width: 1));
  static final outLineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: secondaryColor, width: 1),
    borderRadius: bigBorderRadius,
  );
  static final outLineSmallBorder = OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: BorderSide(color: secondaryColor, width: 1),
  );

  static const double size50 = 50;
  static const double size30 = 30;
  static const double size20 = 20;
  static const double size18 = 18;
  static const double size16 = 16;
  static const double size14 = 14;
  static const double size12 = 12;
  static const double size11 = 11;
  static const double size10 = 10;
  static const double btnSize = 12;

  static TextStyle textStyle({required Color color, double size = size16, bool isBold = false}) {
    return TextStyle(color: color, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: size.sp, fontFamily: "font");
  }

  static Color fromHex(String hexString, {double withOpacity = 1}) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) {
      buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16)).withOpacity(withOpacity);
    } else {
      return AppTheme.primaryColor;
    }
  }

  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColor, primary: whiteColor),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor.withOpacity(.2),
      selectionHandleColor: primaryColor,
    ),
    cardTheme: CardThemeData(
      color: whiteColor,
      surfaceTintColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: primaryColor.withOpacity(.4)),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      side: BorderSide(color: textColor, width: 2),
      checkColor: WidgetStateProperty.all(whiteColor),
      fillColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected) ? primaryColor : null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor;
        }
        return blackColor;
      }),
    ),
    dialogTheme: const DialogThemeData(surfaceTintColor: whiteColor, backgroundColor: whiteColor),
    scaffoldBackgroundColor: whiteColor,
    indicatorColor: whiteColor,
    canvasColor: whiteColor,
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      foregroundColor: whiteColor,
      backgroundColor: whiteColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: darkColor),
      actionsIconTheme: IconThemeData(color: darkColor),
      titleTextStyle: textStyle(color: darkColor, size: size14.sp),
    ),
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()}),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: whiteColor, surfaceTintColor: whiteColor),
  );

  static ThemeData get darkTheme => lightTheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkColor,
    canvasColor: darkColor,
    cardTheme: CardThemeData(
      color: darkColor,
      surfaceTintColor: darkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: primaryColor.withOpacity(.4)),
      ),
    ),
    appBarTheme: lightTheme.appBarTheme.copyWith(
      backgroundColor: darkColor,
      foregroundColor: darkColor,
      iconTheme: IconThemeData(color: whiteColor),
      actionsIconTheme: IconThemeData(color: whiteColor),
      titleTextStyle: textStyle(color: whiteColor, size: size14.sp),
    ),
    dialogTheme: lightTheme.dialogTheme.copyWith(backgroundColor: Colors.grey[850]),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor;
        }
        return whiteColor;
      }),
    ),
    bottomSheetTheme: lightTheme.bottomSheetTheme.copyWith(backgroundColor: darkColor, surfaceTintColor: darkColor),
  );
}
