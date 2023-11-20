import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/logic/providers/theme_provider.dart';
import 'package:flutter_template/router/go_router.dart';
import 'package:flutter_template/ui/common/app_scaffold.dart';

import 'logic/locale_logic.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep native splash screen up until app is finished bootstrapping
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Start app
  final container = ProviderContainer();
  registerSingletons();

  await container.read(appLogicProvider).bootstrap();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );

  // Remove splash screen when bootstrap is complete
  FlutterNativeSplash.remove();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);
    final themeModeState = ref.watch(appThemeProvider);
    // final locale = watchX((SettingsLogic s) => s.currentLocale);
    const locale = "en";

    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            locale: locale == null ? null : const Locale(locale),
            debugShowCheckedModeBanner: false,
            routerDelegate: appRouter.routerDelegate,
            routeInformationProvider: appRouter.routeInformationProvider,
            routeInformationParser: appRouter.routeInformationParser,
            theme: themeModeState,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (BuildContext context, Widget? child) {
              return AppScaffold(child: child!);
            },
          );
        },
        // MyApp()
      ),
    );
  }
}

void registerSingletons() {
  // Settings
  GetIt.I.registerLazySingleton<SettingsLogic>(() => SettingsLogic());
  // Localizations
  GetIt.I.registerLazySingleton<LocaleLogic>(() => LocaleLogic());
}

SettingsLogic get settingsLogic => GetIt.I.get<SettingsLogic>();
LocaleLogic get localeLogic => GetIt.I.get<LocaleLogic>();

AppLocalizations get $strings => localeLogic.strings;
