import 'package:flutter/widgets.dart';

/// Design tokens for spacing, padding, and gaps.
///
/// Values are plain, unscaled [double]s — do NOT bake `flutter_screenutil`
/// (`.w`/`.h`) sizing in here. Apply responsive scaling at the call site if
/// the surrounding context needs it (e.g. `AppSpacing.md.w`). `$styles`
/// (see styles.dart) exposes a screen-scaled convenience wrapper around
/// these same values for widgets that want that behavior by default.
abstract final class AppSpacing {
  /// 2 dp
  static const double xxs = 2;

  /// 4 dp — micro gaps, tight icon margins
  static const double xs = 4;

  /// 8 dp — small gaps, compact padding
  static const double sm = 8;

  /// 16 dp — standard content padding
  static const double md = 16;

  /// 24 dp — section gaps, large card padding
  static const double lg = 24;

  /// 32 dp — screen-level section separation
  static const double xl = 32;

  /// 48 dp — hero-level separation
  static const double xxl = 48;

  /// 56 dp — extra-large offset
  static const double xxl2 = 56;

  /// 80 dp — offset/hero-level padding
  static const double offset = 80;

  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);

  static const Widget gapXs = SizedBox(height: xs);
  static const Widget gapSm = SizedBox(height: sm);
  static const Widget gapMd = SizedBox(height: md);
  static const Widget gapLg = SizedBox(height: lg);
  static const Widget gapXl = SizedBox(height: xl);

  static const Widget hGapXs = SizedBox(width: xs);
  static const Widget hGapSm = SizedBox(width: sm);
  static const Widget hGapMd = SizedBox(width: md);
}
