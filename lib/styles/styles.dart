// ignore_for_file: library_private_types_in_public_api
import 'dart:ui';

import 'package:flutter_template/common_libs.dart';

export 'colors.dart';

final $styles = AppStyle();

@immutable
class AppStyle {
  /// The current theme colors for the app
  final AppColors colors = AppColors();

  /// Rounded edge corner radii
  late final _Corners corners = _Corners();

  late final _Shadows shadows = _Shadows();

  /// Padding and margin values
  late final _Insets insets = _Insets();

  /// Text styles
  late final _Text text = _Text();

  /// Animation Durations
  final _Times times = _Times();
}

@immutable
class _Text {
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
    if (localeLogic.isLoaded) {
      return fonts.entries
          .firstWhere((x) => x.key == $strings.localeName,
              orElse: () => fonts.entries.first)
          .value;
    } else {
      return fonts.entries.first.value;
    }
  }

  // TextStyle get titleFont => _getFontForLocale(_titleFonts);
  TextStyle get brandFonts => _getFontForLocale(_brandFonts);
  TextStyle get contentFont => _getFontForLocale(_contentFonts);

  late final TextStyle brandTitle = copy(brandFonts, sizePx: 64, heightPx: 56);

  late final TextStyle brandGlassLarge = copy(
    brandFonts,
    sizePx: 24,
    heightPx: 12,
    weight: FontWeight.w400,
  );

  late final TextStyle brandGlassSmall = copy(
    brandFonts,
    sizePx: 16,
    heightPx: 12,
    weight: FontWeight.w400,
  );

  late final TextStyle body = copy(contentFont, sizePx: 16, heightPx: 27);

  // late final TextStyle h1 = copy(titleFont, sizePx: 64, heightPx: 62);

  TextStyle copy(TextStyle style,
      {required double sizePx,
      double? heightPx,
      double? spacingPc,
      FontWeight? weight}) {
    return style.copyWith(
        fontSize: sizePx,
        height: heightPx != null ? (heightPx / sizePx) : style.height,
        letterSpacing:
            spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
        fontWeight: weight);
  }
}

@immutable
class _Times {
  final Duration fast = const Duration(milliseconds: 300);
  final Duration med = const Duration(milliseconds: 600);
  final Duration slow = const Duration(milliseconds: 900);
  final Duration pageTransition = const Duration(milliseconds: 200);
}

@immutable
class _Corners {
  late final double sm = 4;
  late final double md = 8;
  late final double lg = 32;
  late final double xl = 50;
}

@immutable
class _Insets {
  late final double xxs = 4;
  late final double xs = 8;
  late final double sm = 16;
  late final double md = 24;
  late final double lg = 32;
  late final double xl = 48;
  late final double xxl = 56;
  late final double offset = 80;
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(
        color: Colors.black.withOpacity(.25),
        offset: const Offset(0, 2),
        blurRadius: 4),
  ];
  final text = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: const Offset(0, 2),
        blurRadius: 2),
  ];
  final textStrong = [
    Shadow(
        color: Colors.black.withOpacity(.6),
        offset: const Offset(0, 4),
        blurRadius: 6),
  ];
}
