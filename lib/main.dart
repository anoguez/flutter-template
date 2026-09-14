import "dart:async";

import 'package:flutter_template/l10n/generated/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/core/services/app_service.dart';
import 'package:flutter_template/ui/core/themes/theme.dart';
import 'package:flutter_template/routing/router.dart';

void main() {
  runZonedGuarded<void>(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
      try {
        await init();
        runApp(const MyApp());
      } catch (error, stackTrace) {
        FlutterError.reportError(
          FlutterErrorDetails(exception: error, stack: stackTrace),
        );
        runApp(const _StartupFailureApp());
      } finally {
        FlutterNativeSplash.remove();
      }
    },
    (error, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stackTrace),
      );
    },
  );
}

class _StartupFailureApp extends StatelessWidget {
  const _StartupFailureApp();

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    home: const Scaffold(
      body: Center(child: Text("Unable to start the app. Please restart it.")),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = goRouter();

    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder<String>(
          valueListenable: settingsLogic.themeMode,
          builder: (context, themeMode, _) => ValueListenableBuilder<String?>(
            valueListenable: settingsLogic.currentLocale,
            builder: (context, localeCode, _) => MaterialApp.router(
              locale: localeCode == null ? null : Locale(localeCode),
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.values.byName(themeMode),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
            ),
          ),
        );
      },
      // MyApp()
    );
  }
}
