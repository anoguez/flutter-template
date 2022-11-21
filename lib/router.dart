import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/ui/screens/home.dart';
import 'package:flutter_template/ui/screens/splash_screen.dart';

class ScreenPaths {
  static String splash = '/';
  static String home = '/home';
}

final appRouter = GoRouter(
  redirect: _handleRedirect,
  routes: [
    AppRoute(
        ScreenPaths.splash, (_) => const SplashScreen()), // This will be hidden
    AppRoute(ScreenPaths.home, (_) => const HomeScreen()),
  ],
);

class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [], this.useFade = false})
      : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );
            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
}

FutureOr<String?> _handleRedirect(BuildContext context, GoRouterState state) {
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete && state.location != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }
  debugPrint('Navigate to: ${state.location}');
  return null; // do nothing
}
