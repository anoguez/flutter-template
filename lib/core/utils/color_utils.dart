import 'package:flutter_template/common_libs.dart';

class ColorUtils {
  static Color shiftHsl(Color c, [double amt = 0]) {
    var hslc = HSLColor.fromColor(c);
    return hslc.withLightness((hslc.lightness + amt).clamp(0.0, 1.0)).toColor();
  }

  static Color parseHex(String value) =>
      Color(int.parse(value.substring(1, 7), radix: 16) + 0xFF000000);

  static Color blend(Color dst, Color src, double opacity) {
    return Color.from(
      alpha: 1.0,
      red: dst.r * (1.0 - opacity) + src.r * opacity,
      green: dst.g * (1.0 - opacity) + src.g * opacity,
      blue: dst.b * (1.0 - opacity) + src.b * opacity,
    );
  }
}
