import 'package:flutter/material.dart';
import 'package:sarmad/res/const_colors.dart';
import 'package:sarmad/util/lang/app_localization.dart';

class AppTheme {
  final Locale locale;

  const AppTheme(this.locale);

  ThemeData get themeDataLight {
    return ThemeData(
        primarySwatch: ConstColors.primarySwatch,
        fontFamily: 'Cairo',
        useMaterial3: false,
        scaffoldBackgroundColor: ConstColors.greyLight);
  }
}
