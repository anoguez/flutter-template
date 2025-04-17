import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/core/services/app_service.dart';
import 'package:flutter_template/core/save_load_mixin.dart';

class SettingsService with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final hasCompletedOnboarding = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);
  late final hasDismissedSearchMessage = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);
  late final currentLocale = ValueNotifier<String?>(null)
    ..addListener(scheduleSave);
  late final isDarkModeEnabled = ValueNotifier<bool>(false)
    ..addListener(scheduleSave);

  final bool useBlurs = defaultTargetPlatform != TargetPlatform.android;

  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value = value['hasCompletedOnboarding'] ?? false;
    hasDismissedSearchMessage.value =
        value['hasDismissedSearchMessage'] ?? false;
    currentLocale.value = value['currentLocale'];
    isDarkModeEnabled.value = value['isDarkModeEnabled'] ?? false;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding': hasCompletedOnboarding.value,
      'hasDismissedSearchMessage': hasDismissedSearchMessage.value,
      'currentLocale': currentLocale.value,
      'isDarkModeEnabled': isDarkModeEnabled.value,
    };
  }

  Future<void> changeLocale(Locale value) async {
    currentLocale.value = value.languageCode;
    await localeLogic.loadIfChanged(value);
    // Re-init controllers that have some cached data that is localized
  }

  Future<void> enableDarkModeEnabled(bool value) async {
    isDarkModeEnabled.value = value;
  }
}
