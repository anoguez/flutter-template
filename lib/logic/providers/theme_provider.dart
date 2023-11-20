import 'package:flutter_template/common_libs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class AppTheme extends _$AppTheme {
  bool isDarkMode = false;

  ColorScheme get colorScheme =>
      isDarkMode ? $styles.appTheme.darkTheme : $styles.appTheme.lightTheme;

  TextTheme get txtTheme =>
      (isDarkMode ? ThemeData.dark() : ThemeData.light()).textTheme;

  void enableDarkMode(bool enableDarkMode) {
    isDarkMode = enableDarkMode;
    state = appTheme;
  }

  ThemeData get appTheme {
    // ThemeData(fontFamily: $styles.text.body.fontFamily),
    return ThemeData.from(
      textTheme: txtTheme,
      colorScheme: colorScheme,
    ).copyWith(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorScheme.primary,
      ),
      highlightColor: colorScheme.primary,
    );
  }

  @override
  ThemeData build() => ThemeData.from(
        textTheme: txtTheme,
        colorScheme: colorScheme,
      ).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colorScheme.primary,
        ),
        highlightColor: colorScheme.primary,
      );
}
