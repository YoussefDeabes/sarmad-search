import 'dart:math';

import 'package:flutter/material.dart';

class ConstColors {

  static final MaterialColor primarySwatch = generateMaterialColors(app);
  static const Color appBackgroundColor = Color(0xFF0E46A3);
  static const Color selectedTabBackgroundColor = Color(0xFF0E46A3);
  static const Color appBarBackgroundColor = Color(0xFF0E46A3);
  static const Color app = Color(0xFF0E46A3);
  static const Color card = Color(0xFFE1F7F5);
  static const Color appBarTextColor = Color(0xFFFFFFFF);
  static const Color lightPrimaryColor = Color(0xFF0E46A3);
  static const Color shadowColor = Color(0x290f4c9d);
  static const Color textFieldtitleColor = Color(0xFF808080);
  static const Color textFieldColor = Color(0xFFd7dee7);
  static const Color unSelectedTabBackgroundColor = secondaryText;
  static const Color appGreen = Color(0xFF43bb9a);
  static const Color appRed = Color(0xFFbb4343);
  static const Color subTitleTextColor = Color(0xFF505050);
  static const Color coolGrey = Color(0xFFaab0bb);

  static const Color text = Color(0xFF1E0342);
  static const Color secondaryText = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFE0E0E0);
  static const Color secondary = Color(0xFF43BB9A);
  static const Color accent = Color(0xFF7FCED6);
  static const accentColor = Color(0xffF0E9D8);
  static const Color lightShade = Color(0xFFF8FCFF);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color error = Color(0xFFC54127);
  static const Color loginColor = Color(0xFF3120E0);
  static const Color red = Color(0xFFC54127);
  static const Color toastColors = Color(0xFFFFCF96);
  static const Color white = Colors.white;
}

MaterialColor generateMaterialColors(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);

/**
    Hexadecimal opacity values
    100% — FF
    95% — F2
    90% — E6
    85% — D9
    80% — CC
    75% — BF
    70% — B3
    65% — A6
    60% — 99
    55% — 8C
    50% — 80
    45% — 73
    40% — 66
    35% — 59
    30% — 4D
    25% — 40
    20% — 33
    15% — 26
    10% — 1A
    5% — 0D
    0% — 00
 */
