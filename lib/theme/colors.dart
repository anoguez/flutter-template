import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/logic/common/color_utils.dart';

@immutable
class AppColors {
  /// Common
  final Color midnightGreen = const Color(0xFF00555E);
  final Color silverPink = const Color(0xFFBEABA1);
  final Color offWhite = const Color(0xFFF8ECE5);
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
    onPrimary: Colors.black,
    secondary: Colors.pink,
    onSecondary: Colors.grey,
    background: Colors.white,
    onBackground: Colors.white,
    surface: Colors.white,
    onSurface: Colors.white,
    error: Colors.red,
    onError: Colors.white,
  );

  final ColorScheme darkTheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.purple,
    onPrimary: Colors.grey,
    secondary: Colors.purple,
    onSecondary: Colors.grey,
    background: Colors.black,
    onBackground: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
    error: Colors.red,
    onError: Colors.white,
  );
}
