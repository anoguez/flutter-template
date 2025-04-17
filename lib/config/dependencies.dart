import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/core/services/locale_service.dart';

final sl = GetIt.instance;

void registerSingletons() {
  GetIt.I.registerLazySingleton<SettingsService>(() => SettingsService());
  GetIt.I.registerLazySingleton<LocaleService>(() => LocaleService());
}