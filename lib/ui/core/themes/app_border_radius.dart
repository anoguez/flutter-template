import 'package:flutter/widgets.dart';

/// Design tokens for border radii.
///
/// Prefer these named constants over inline `BorderRadius.circular(...)`
/// calls in the UI layer. See app_spacing.dart for the same rationale on
/// keeping these values unscaled.
abstract final class AppBorderRadius {
  /// 4 dp — tiny rounding
  static const double xs = 4;

  /// 8 dp — small chips, icon badges, popup menus
  static const double sm = 8;

  /// 12 dp — buttons, text fields
  static const double md = 12;

  /// 16 dp — cards, containers
  static const double lg = 16;

  /// 24 dp — prominent card corners
  static const double xl = 24;

  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(xs));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(xl));
}
