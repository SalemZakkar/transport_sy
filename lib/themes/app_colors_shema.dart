
import 'package:flutter/material.dart';

part 'styles.dart';

abstract class AppColorsSchema {
  Color primary = Color(0xff00352A);
  Color secondary = Color(0xffAC956E);
  Color white = Colors.white;
  Color lightGrey = Color(0xffF2F2F2);
  Color darkGrey = Color(0xffE5E5E5);
  Color red = Colors.red;

}

class LightAppColorSchema extends AppColorsSchema {}
