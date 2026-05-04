import 'package:flutter/material.dart';

import 'app_colors_shema.dart';

class AppTheme {
  // final AppColorsSchema _schema;

  // AppTheme(this._schema);

  ThemeData getThemeData() => ThemeData(
    primaryColor: Colors.blue,
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
