import 'package:flutter/material.dart';
import 'package:flutter_template/core/preferences/application_preferences.dart';
import 'package:test/test.dart';

void main() {
  test('migrates legacy dark mode into presentation state', () async {
    final preferences = ApplicationPreferences(
      InMemoryApplicationPreferencesStore({'isDarkModeEnabled': true}),
    );
    await preferences.restore();
    expect(preferences.presentation.themeMode, ThemeMode.dark);
  });

  test('persists an explicit presentation change', () async {
    final store = InMemoryApplicationPreferencesStore();
    final preferences = ApplicationPreferences(store);
    await preferences.setThemeMode(ThemeMode.light);
    expect((await store.read())['themeMode'], 'light');
  });
}
