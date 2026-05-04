
import 'package:flutter/material.dart';

part 'styles.dart';

// ThemeData getThemeData() => ThemeData(
//   primaryColor: Color(0xff00352A),
//   appBarTheme: AppBarThemeData(
//     backgroundColor: Color(0xff00352A),
//     titleTextStyle: TextStyle(color: Colors.white),
//   ),
//   scaffoldBackgroundColor: Color(0xffFCFCFC),
//   cardColor: Color(0xffffffff),
//   dividerColor: Color(0xffE5E5E5),
// );
// }

abstract class AppColorsSchema {
  Color primary = Color(0xff00352A);
  Color secondary = Color(0xffAC956E);
  Color white = Colors.white;
  Color lightGrey = Color(0xffFCFCFC);
  Color darkGrey = Color(0xffE5E5E5);
  Color red = Colors.red;

}

class LightAppColorSchema extends AppColorsSchema {}
