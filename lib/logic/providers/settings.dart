import 'package:flutter_template/logic/providers/theme_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings.g.dart';

@riverpod
class Settings extends _$Settings {
  @override
  Settings build() => this;

  // TODO do not use to control state for local values
  final FormGroup formGroup = FormGroup({
    'isDarkModeEnabled': FormControl<bool>(value: false),
  });

  void enableDarkMode(bool enableDarkMode) {
    ref.read(appThemeProvider.notifier).enableDarkMode(enableDarkMode);
  }
}
