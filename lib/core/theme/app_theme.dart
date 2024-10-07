import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/core/theme/styles.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: $styles.colors.accent1,
    brightness: Brightness.light,
    scaffoldBackgroundColor: $styles.colors.lightBackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: $styles.colors.accent1,
        textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: $styles.colors.accent1,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: $styles.colors.darkBackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: $styles.colors.accent1,
        textStyle: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    ),
  );
}
