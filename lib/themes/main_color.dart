
import 'package:flutter/material.dart';

class MainColor extends ColorSwatch<ColorType> {
  const MainColor(super.primary, super.swatch);

  Color get tint5 => this[ColorType.tint5] ?? Colors.transparent;

  Color get tint10 => this[ColorType.tint10] ?? Colors.transparent;

  Color get tint15 => this[ColorType.tint15] ?? Colors.transparent;

  Color get tint20 => this[ColorType.tint20] ?? Colors.transparent;

  Color get tint25 => this[ColorType.tint25] ?? Colors.transparent;

  Color get tint30 => this[ColorType.tint30] ?? Colors.transparent;

  Color get tint35 => this[ColorType.tint35] ?? Colors.transparent;

  Color get tint40 => this[ColorType.tint40] ?? Colors.transparent;

  Color get tint45 => this[ColorType.tint45] ?? Colors.transparent;

  Color get tint50 => this[ColorType.tint50] ?? Colors.transparent;

  Color get tint55 => this[ColorType.tint55] ?? Colors.transparent;

  Color get tint60 => this[ColorType.tint60] ?? Colors.transparent;

  Color get tint65 => this[ColorType.tint65] ?? Colors.transparent;

  Color get tint70 => this[ColorType.tint70] ?? Colors.transparent;

  Color get tint75 => this[ColorType.tint75] ?? Colors.transparent;

  Color get tint80 => this[ColorType.tint80] ?? Colors.transparent;

  Color get tint85 => this[ColorType.tint85] ?? Colors.transparent;

  Color get tint90 => this[ColorType.tint90] ?? Colors.transparent;

  Color get tint95 => this[ColorType.tint95] ?? Colors.transparent;

  Color get tint100 => this[ColorType.tint100] ?? Colors.transparent;

  Color get shade5 => this[ColorType.shade5] ?? Colors.transparent;

  Color get shade10 => this[ColorType.shade10] ?? Colors.transparent;

  Color get shade15 => this[ColorType.shade15] ?? Colors.transparent;

  Color get shade20 => this[ColorType.shade20] ?? Colors.transparent;

  Color get shade25 => this[ColorType.shade25] ?? Colors.transparent;

  Color get shade30 => this[ColorType.shade30] ?? Colors.transparent;

  Color get shade35 => this[ColorType.shade35] ?? Colors.transparent;

  Color get shade40 => this[ColorType.shade40] ?? Colors.transparent;

  Color get shade45 => this[ColorType.shade45] ?? Colors.transparent;

  Color get shade50 => this[ColorType.shade50] ?? Colors.transparent;

  Color get shade55 => this[ColorType.shade55] ?? Colors.transparent;

  Color get shade60 => this[ColorType.shade60] ?? Colors.transparent;

  Color get shade65 => this[ColorType.shade65] ?? Colors.transparent;

  Color get shade70 => this[ColorType.shade70] ?? Colors.transparent;

  Color get shade75 => this[ColorType.shade75] ?? Colors.transparent;

  Color get shade80 => this[ColorType.shade80] ?? Colors.transparent;

  Color get shade85 => this[ColorType.shade85] ?? Colors.transparent;

  Color get shade90 => this[ColorType.shade90] ?? Colors.transparent;

  Color get shade95 => this[ColorType.shade95] ?? Colors.transparent;

  Color get shade100 => this[ColorType.shade100] ?? Colors.transparent;
}

class StatusColors {
  Color success, fail, pending;

  StatusColors({
    required this.fail,
    required this.success,
    required this.pending,
  });
}

class TextColors {
  Color primaryText, labelAndSecondaryText, hintAndDisable;

  TextColors({
    required this.hintAndDisable,
    required this.primaryText,
    required this.labelAndSecondaryText,
  });
}

class ShapeColors {
  MainColor backgroundColor, cardColor, appBar, navBar, iconColor;
  Color borderColor, dividerColor;

  ShapeColors({
    required this.backgroundColor,
    required this.dividerColor,
    required this.cardColor,
    required this.borderColor,
    required this.appBar,
    required this.navBar,
    required this.iconColor,
  });
}

class Shadows {
  BoxShadow cardShadow;

  Shadows({required this.cardShadow});
}

class ShadowColors {
  Color mainShadow;

  ShadowColors({required this.mainShadow});
}

enum ColorType {
  shade5,
  shade10,
  shade15,
  shade20,
  shade25,
  shade30,
  shade35,
  shade40,
  shade45,
  shade50,
  shade55,
  shade60,
  shade65,
  shade70,
  shade75,
  shade80,
  shade85,
  shade90,
  shade95,
  shade100,
  tint5,
  tint10,
  tint15,
  tint20,
  tint25,
  tint30,
  tint35,
  tint40,
  tint45,
  tint50,
  tint55,
  tint60,
  tint65,
  tint70,
  tint75,
  tint80,
  tint85,
  tint90,
  tint95,
  tint100,
}
