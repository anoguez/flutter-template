import 'package:flutter/material.dart';
import 'package:flutter_template/ui/core/themes/styles.dart';

class AppTheme {

  static const _inputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(
      color: AppColors.grey3,
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: AppColors.lightColorScheme,
    inputDecorationTheme: _inputDecorationTheme,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: AppColors.darkColorScheme,
    inputDecorationTheme: _inputDecorationTheme,
  );
}
