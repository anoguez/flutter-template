import 'dart:ui';

import 'package:flutter_template/common_libs.dart';

@immutable
class CustomTypography {
  final Map<String, TextStyle> _brandFonts = {
    'en': const TextStyle(fontFamily: 'Hurricane'),
  };

  final Map<String, TextStyle> _titleFonts = {
    'en': const TextStyle(fontFamily: 'Tenor'),
  };

  final Map<String, TextStyle> _contentFonts = {
    'en': const TextStyle(fontFamily: 'Raleway', fontFeatures: [
      FontFeature.enable('dlig'),
      FontFeature.enable('kern'),
    ]),
  };

  TextStyle _getFontForLocale(Map<String, TextStyle> fonts) {
    return localeLogic.isLoaded
        ? fonts.entries
            .firstWhere(
              (x) => x.key == $strings.localeName,
              orElse: () => fonts.entries.first,
            )
            .value
        : fonts.entries.first.value;
  }

  TextStyle get titleFont => _getFontForLocale(_titleFonts);
  TextStyle get brandFonts => _getFontForLocale(_brandFonts);
  TextStyle get contentFont => _getFontForLocale(_contentFonts);

  TextStyle copy(
    TextStyle style, {
    required double sizePx,
    double? heightPx,
    double? spacingPc,
    FontWeight? weight,
  }) {
    return style.copyWith(
      fontSize: sizePx,
      height: heightPx != null ? (heightPx / sizePx) : style.height,
      letterSpacing:
          spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
      fontWeight: weight,
    );
  }

  // FONT GUIDELINE
  late final TextStyle largeTitle = copy(
    titleFont,
    sizePx: 34,
    heightPx: 62,
  );
  late final TextStyle title1 = copy(
    titleFont,
    sizePx: 28,
    heightPx: 33,
  );
  late final TextStyle title2 = copy(
    titleFont,
    sizePx: 22,
    heightPx: 32,
  );
  late final TextStyle title3 = copy(
    titleFont,
    sizePx: 20,
    heightPx: 30,
  );
  late final TextStyle headline = copy(
    titleFont,
    sizePx: 17,
    heightPx: 27,
    weight: FontWeight.w500,
  );
  late final TextStyle body = copy(
    contentFont,
    sizePx: 17,
    heightPx: 26,
  );
  late final TextStyle callOut = copy(
    contentFont,
    sizePx: 16,
    heightPx: 24,
  );
  late final TextStyle subHead = copy(
    contentFont,
    sizePx: 15,
    heightPx: 23,
  );
  late final TextStyle footnote = copy(
    contentFont,
    sizePx: 13,
    heightPx: 21,
  );
}
