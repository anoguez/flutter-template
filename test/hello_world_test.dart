import "package:flutter_template/core/services/settings_service.dart";
import "package:test/test.dart";

void main() {
  group("SettingsService theme migration", () {
    test("migrates the legacy dark-mode preference", () {
      final settings = SettingsService()
        ..copyFromJson({"isDarkModeEnabled": true});

      expect(settings.themeMode.value, "dark");
    });

    test("persists an explicit theme mode", () async {
      final settings = SettingsService()..copyFromJson({"themeMode": "system"});

      await settings.setThemeMode("light");

      expect(settings.toJson()["themeMode"], "light");
    });
  });
}
