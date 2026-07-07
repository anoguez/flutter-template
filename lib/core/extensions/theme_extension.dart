import 'package:flutter/material.dart';

/// Shorthand access to the current [ThemeData] from a [BuildContext].
///
/// Prefer `context.colors`/`context.textTheme` over a global styles
/// singleton so widgets always reflect the theme in effect for their
/// position in the tree (and react correctly to theme/brightness changes).
extension ThemeContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}
