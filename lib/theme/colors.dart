import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/logic/common/color_utils.dart';

@immutable
class AppColors {
  /// Common
  final Color accent1 = const Color(0xFF00555E);
  final Color accent2 = const Color(0xFFBEABA1);
  final Color offWhite = const Color(0xFFF8ECE5);
  final Color white = Colors.white;
  final Color black = Colors.black;
  final Color error = Colors.red;
  final Color disabled = Colors.grey.withOpacity(0.4);

  final bool isDark = false;

  Color shift(Color c, double d) =>
      ColorUtils.shiftHsl(c, d * (isDark ? -1 : 1));
}

@immutable
class AppThemes {
  final ColorScheme lightTheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.amber,
    secondary: Colors.pink,
    error: Colors.red,
    background: Colors.white,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onError: Colors.white,
    onBackground: Colors.white,
    onSurface: Colors.white,
  );

  final ColorScheme darkTheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.blue,
    secondary: Colors.green,
    error: Colors.red,
    background: Colors.white,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onError: Colors.white,
    onBackground: Colors.white,
    onSurface: Colors.white,
  );
}
