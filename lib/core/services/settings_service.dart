import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/core/services/app_service.dart';
import 'package:flutter_template/core/save_load_mixin.dart';

class SettingsService with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final hasCompletedOnboarding = ValueNotifier<bool>(false);
  late final hasDismissedSearchMessage = ValueNotifier<bool>(false);
  late final currentLocale = ValueNotifier<String?>(null);

  /// Persists an explicit preference while respecting the device by default.
  late final themeMode = ValueNotifier<String>('system');

  var _listenersInitialized = false;

  final bool useBlurs = defaultTargetPlatform != TargetPlatform.android;

  @override
  Future<void> load() async {
    await super.load();
    _initializeListeners();
  }

  void _initializeListeners() {
    if (_listenersInitialized) return;
    _listenersInitialized = true;
    hasCompletedOnboarding.addListener(scheduleSave);
    hasDismissedSearchMessage.addListener(scheduleSave);
    currentLocale.addListener(scheduleSave);
    themeMode.addListener(scheduleSave);
  }

  @override
  void copyFromJson(Map<String, dynamic> value) {
    hasCompletedOnboarding.value = value['hasCompletedOnboarding'] ?? false;
    hasDismissedSearchMessage.value =
        value['hasDismissedSearchMessage'] ?? false;
    currentLocale.value = value['currentLocale'];
    // Migrate templates created before theme modes were introduced.
    if (value.containsKey('themeMode')) {
      themeMode.value = value['themeMode'] as String? ?? 'system';
    } else if (value['isDarkModeEnabled'] == true) {
      themeMode.value = 'dark';
    } else {
      themeMode.value = 'system';
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hasCompletedOnboarding': hasCompletedOnboarding.value,
      'hasDismissedSearchMessage': hasDismissedSearchMessage.value,
      'currentLocale': currentLocale.value,
      'themeMode': themeMode.value,
    };
  }

  Future<void> changeLocale(Locale value) async {
    currentLocale.value = value.languageCode;
    await localeLogic.loadIfChanged(value);
    // Re-init controllers that have some cached data that is localized
  }

  Future<void> setThemeMode(String value) async {
    if (!ThemeMode.values.map((mode) => mode.name).contains(value)) return;
    themeMode.value = value;
  }
}
