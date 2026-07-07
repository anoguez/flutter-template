import 'package:flutter/material.dart';

/// Brand seed color — swap this to reskin the whole app. Every other
/// color in [AppColors.lightColorScheme]/[AppColors.darkColorScheme] is
/// derived from it via Material3's color algorithm.
const _seedColor = Color(0xFF4F46E5); // Indigo

abstract final class AppColors {
  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.light,
  );

  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.dark,
  );

  static const greyFade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF626161), Color(0xFF212121)],
  );
}
