import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class ApplicationPresentationState {
  const ApplicationPresentationState({
    this.themeMode = ThemeMode.system,
    this.locale,
  });

  final ThemeMode themeMode;
  final Locale? locale;

  ApplicationPresentationState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) => ApplicationPresentationState(
    themeMode: themeMode ?? this.themeMode,
    locale: locale ?? this.locale,
  );
}

abstract interface class ApplicationPreferencesStore {
  Future<Map<String, Object?>> read();
  Future<void> write(Map<String, Object?> values);
}

class SharedPreferencesApplicationPreferencesStore
    implements ApplicationPreferencesStore {
  static const _key = 'application_preferences';

  @override
  Future<Map<String, Object?>> read() async {
    final values = await SharedPreferences.getInstance();
    return {
      'themeMode': values.getString('$_key.themeMode'),
      'locale': values.getString('$_key.locale'),
    };
  }

  @override
  Future<void> write(Map<String, Object?> values) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(
      '$_key.themeMode',
      values['themeMode']! as String,
    );
    await preferences.setString('$_key.locale', values['locale']! as String);
  }
}

class InMemoryApplicationPreferencesStore
    implements ApplicationPreferencesStore {
  InMemoryApplicationPreferencesStore([Map<String, Object?>? values])
    : _values = {...?values};
  final Map<String, Object?> _values;
  @override
  Future<Map<String, Object?>> read() async => {..._values};
  @override
  Future<void> write(Map<String, Object?> values) async {
    _values
      ..clear()
      ..addAll(values);
  }
}

class ApplicationPreferences extends ChangeNotifier {
  ApplicationPreferences(this._store);
  final ApplicationPreferencesStore _store;
  ApplicationPresentationState _presentation =
      const ApplicationPresentationState();
  ApplicationPresentationState get presentation => _presentation;

  Future<void> restore() async {
    final values = await _store.read();
    final legacyDarkMode = values['isDarkModeEnabled'] == true;
    final modeName =
        values['themeMode'] as String? ?? (legacyDarkMode ? 'dark' : 'system');
    _presentation = ApplicationPresentationState(
      themeMode: ThemeMode.values.byName(modeName),
      locale: switch (values['locale'] as String?) {
        final code? when code.isNotEmpty => Locale(code),
        _ => null,
      },
    );
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode themeMode) =>
      _update(_presentation.copyWith(themeMode: themeMode));

  Future<void> setLocale(Locale locale) =>
      _update(_presentation.copyWith(locale: locale));

  Future<void> _update(ApplicationPresentationState next) async {
    _presentation = next;
    notifyListeners();
    await _store.write({
      'themeMode': next.themeMode.name,
      'locale': next.locale?.languageCode ?? '',
    });
  }
}
