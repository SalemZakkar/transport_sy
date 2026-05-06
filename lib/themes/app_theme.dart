import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import 'app_colors_shema.dart';

class AppTheme {
  final AppColorsSchema _schema;

  AppTheme(this._schema);

  ThemeData getThemeData({String? fontFamily}) => ThemeData(
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) =>
          Icon(Icons.arrow_back_ios_new, color: Colors.white),
    ),
    primaryColor: _schema.primary,
    fontFamily: fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _schema.primary,
      primary: _schema.primary,
      surface: _schema.lightGrey,
    ),
    appBarTheme: AppBarThemeData(
      backgroundColor: _schema.primary,
      centerTitle: true,
      toolbarHeight: 80,
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      titleTextStyle: TextStyle(
        color: _schema.white,
        fontSize: 24,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
      ),
    ),
    scaffoldBackgroundColor: _schema.lightGrey,
    cardColor: _schema.white,
    dividerColor: _schema.darkGrey,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.0, // up from 57
        fontWeight: FontWeight.w400,
        letterSpacing: -0.5,
        color: _schema.primary,
      ),
      displayMedium: TextStyle(
        fontSize: 45.0, // up from 45
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: _schema.primary,
      ),
      displaySmall: TextStyle(
        fontSize: 36.0, // up from 36
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        color: _schema.primary,
      ),
      headlineLarge: TextStyle(
        fontSize: 32.0, // up from 32
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        color: _schema.primary,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0, // up from 28
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        color: _schema.primary,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0, // up from 24
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        color: _schema.primary,
      ),
      titleLarge: TextStyle(
        fontSize: 22.0, // up from 22
        fontWeight: FontWeight.w500,
        letterSpacing: 0.0,
        color: _schema.primary,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0, // up from 16
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0, // up from 14
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0, // up from 16
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0, // up from 14
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0, // up from 12
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 14.0, // up from 14
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontSize: 12.0, // up from 12
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: Colors.black,
      ),
      labelSmall: TextStyle(
        fontSize: 11.0, // up from 11
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _schema.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelStyle: TextStyle(
        // color: _schema.textColors.secondary,
        // fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        // color: _schema.textColors.secondary,
        // fontSize: 13,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _schema.darkGrey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: BorderSide(color: _schema.primary, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: BorderSide(color: _schema.red, width: 1),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: BorderSide(color: _schema.red, width: 1),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),

        borderSide: BorderSide(color: _schema.darkGrey, width: 2),
      ),
      errorStyle: TextStyle(color: _schema.red),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _schema.white,
      selectedItemColor: _schema.secondary,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: _schema.primary),
        backgroundColor: _schema.white,
        // overlayColor: _schema.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        // surfaceTintColor: _schema.blue,
        padding: EdgeInsets.all(8),
        disabledBackgroundColor: Colors.grey,
        textStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),

        foregroundColor: _schema.primary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _schema.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        padding: EdgeInsets.all(8),
        disabledBackgroundColor: Colors.grey,
        textStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        foregroundColor: _schema.white,
      ),
    ),
  );
}

// extension AppThemeExtension on ThemeData {
//   AppTheme get appTheme => AppTheme(LightAppColorSchema());
// }

// extension ContextAppThemeExtension on BuildContext {
//   AppColorsSchema get appColorSchema {
//     // AppColorsSchema schema =
//     //     MediaQuery.of(this).platformBrightness == Brightness.dark
//     //     ? DarkAppColorSchema()
//     //     : LightAppColorSchema();
//     return LightAppColorSchema();
//   }
//
//   ThemeData get theme => AppTheme(appColorSchema).getThemeData();
// }
//
// // extension GetAppColorTheme on ThemeData {
// //   AppColorsSchema get appColors {
// //     return LightAppColorSchema();
// //   }
// // }
