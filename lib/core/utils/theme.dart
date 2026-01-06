import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../my_custom_widget.dart';

class AppTheme {
  static const primaryColorString = "#711D20";
  static const primaryColor = Color(0xff711D20);
  static const secondaryColor = Color(0xffdadada);
  static const bgColor = Color(0xffF7F9F8);
  static const accentColor = whiteColor;
  static const blackColor = Colors.black;
  static const whiteColor = Colors.white;
  static const redColor = Colors.red;
  static const greyColor = Colors.grey;
  static const errorColor = redColor;
  static const optionsBGColor = Color(0xffBCBEC0);
  static const pickUp = Color(0xff454547);
  static const delivery = Color(0xffd0d0d0);
  static final gradient1 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryColor,
      Color(0xFFC9A89A),
    ],
  );

  static Color get textColor => themeController.isDark.value ? accentColor : blackColor;

  static Color get bgThemeColor => themeController.isDark.value ? blackColor : accentColor;

  static BorderRadius borderRadius = BorderRadius.circular(8.r);
  static BorderRadius bigBorderRadius = BorderRadius.circular(12.r);

  static const underLineBorder = UnderlineInputBorder(borderSide: BorderSide(color: primaryColor, width: 1));
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
    return TextStyle(
      color: color,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontSize: size.sp,
      fontFamily: "font",
    );
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

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColor, primary: accentColor),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor.withOpacity(.2),
      selectionHandleColor: primaryColor,
    ),
    cardTheme: CardThemeData(
      color: accentColor,
      elevation: 1,
      shadowColor: accentColor,
      surfaceTintColor: accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: greyColor.withOpacity(.35)),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      side: BorderSide(color: greyColor.withOpacity(.35), width: 2),
      checkColor: WidgetStateProperty.all(accentColor),
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
    dialogTheme: const DialogThemeData(surfaceTintColor: accentColor, backgroundColor: accentColor),
    scaffoldBackgroundColor: accentColor,
    indicatorColor: accentColor,
    canvasColor: accentColor,
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      foregroundColor: accentColor,
      backgroundColor: accentColor,
      elevation: 5,
      centerTitle: true,
      iconTheme: IconThemeData(color: primaryColor),
      actionsIconTheme: IconThemeData(color: primaryColor),
      titleTextStyle: textStyle(color: primaryColor, size: size16.sp),
    ),
    useMaterial3: true,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()}),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: accentColor, surfaceTintColor: accentColor),
  );

  // static ThemeData darkTheme = lightTheme.copyWith(
  //   brightness: Brightness.dark,
  //   scaffoldBackgroundColor: darkColor,
  //   canvasColor: darkColor,
  //   cardTheme: CardThemeData(
  //     color: darkColor,
  //     surfaceTintColor: darkColor,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: AppTheme.borderRadius,
  //       side: BorderSide(color: primaryColor.withOpacity(.4)),
  //     ),
  //   ),
  //   appBarTheme: lightTheme.appBarTheme.copyWith(
  //     backgroundColor: darkColor,
  //     foregroundColor: darkColor,
  //     iconTheme: IconThemeData(color: accentColor),
  //     actionsIconTheme: IconThemeData(color: accentColor),
  //     titleTextStyle: textStyle(color: accentColor, size: size14.sp),
  //   ),
  //   dialogTheme: lightTheme.dialogTheme.copyWith(backgroundColor: Colors.grey[850]),
  //   radioTheme: RadioThemeData(
  //     fillColor: WidgetStateProperty.resolveWith<Color>((states) {
  //       if (states.contains(WidgetState.selected)) {
  //         return primaryColor;
  //       }
  //       return accentColor;
  //     }),
  //   ),
  //   bottomSheetTheme: lightTheme.bottomSheetTheme.copyWith(backgroundColor: darkColor, surfaceTintColor: darkColor),
  // );
}
