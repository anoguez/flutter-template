// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/theme/typography.dart';

export 'colors.dart';

final $styles = AppStyle();

@immutable
class AppStyle {
  /// The current theme colors for the app
  final AppColors colors = AppColors();

  final AppThemes appTheme = AppThemes();

  /// Rounded edge corner radii
  late final _Corners corners = _Corners();

  late final _Shadows shadows = _Shadows();

  late final _Gradients gradients = _Gradients();

  /// Padding and margin values
  late final _HorizontalInsets horizontalInsets = _HorizontalInsets();

  late final _VerticalInsets verticalInsets = _VerticalInsets();

  /// Text styles
  late final CustomTypography text = CustomTypography();

  /// Animation Durations
  final _Times times = _Times();
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
  late final double xxs = 2.w;
  late final double xs = 4.w;
  late final double sm = 8.w;
  late final double md = 16.w;
  late final double lg = 24.w;
  late final double xl = 32.w;
}

@immutable
class _HorizontalInsets {
  late final double xxs = 2.w;
  late final double xs = 4.w;
  late final double sm = 8.w;
  late final double md = 16.w;
  late final double lg = 24.w;
  late final double xl = 32.w;
  late final double xxl = 48.w;
  late final double xxl2 = 56.w;
  late final double offset = 80.w;
}

@immutable
class _VerticalInsets {
  late final double xxs = 2.h;
  late final double xs = 4.h;
  late final double sm = 8.h;
  late final double md = 16.h;
  late final double lg = 24.h;
  late final double xl = 32.h;
  late final double xxl = 48.h;
  late final double xxl2 = 56.h;
  late final double offset = 80.h;
}

@immutable
class _Shadows {
  final textSoft = [
    Shadow(
      color: Colors.black.withOpacity(.25),
      offset: const Offset(0, 2),
      blurRadius: 4,
    ),
  ];
  final text = [
    Shadow(
      color: Colors.black.withOpacity(.6),
      offset: const Offset(0, 2),
      blurRadius: 2,
    ),
  ];
  final textStrong = [
    Shadow(
      color: Colors.black.withOpacity(.6),
      offset: const Offset(0, 4),
      blurRadius: 6,
    ),
  ];
}

@immutable
class _Gradients {
  final linearGradient = const LinearGradient(
    colors: [Colors.amber, Colors.green, Colors.blue],
    stops: [0, 0.1, 1],
  );
}
