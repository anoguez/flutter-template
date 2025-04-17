import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/routing/routes.dart';
import 'package:flutter_template/ui/core/app_scaffold.dart';
import 'package:flutter_template/ui/core/popup_menu.dart';
import 'package:flutter_template/ui/home/home.dart';
import 'package:flutter_template/ui/screen2/screen2.dart';
import 'package:flutter_template/ui/screen3/screen3.dart';
import 'package:flutter_template/ui/settings/settings_screen.dart';
import 'package:flutter_template/ui/splash/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

GoRouter goRouter() => GoRouter(
      navigatorKey: _rootNavigator,
      initialLocation: ScreenPaths.root,
      redirect: _handleRedirect,
      routes: [
        AppRoute(ScreenPaths.splash, (_) => const SplashScreen()),

        // SHELL ROUTES
        ShellRoute(
          navigatorKey: _shellNavigator,
          builder: (context, state, child) => Scaffold(
            appBar: AppBar(
              title: const Text("Test"),
              actions: const [
                PopupMenu(),
              ],
            ),
            body: child,
          ),
          routes: [
            AppRoute(
              ScreenPaths.root,
              (state) => AppScaffold(
                key: state.pageKey,
                pages: const [
                  HomeScreen(key: Key('home screen')),
                  Screen2(key: Key('Screen2')),
                  Screen3(key: Key('Screen3')),
                ],
              ),
              useTransitionAnimation: false,
            ),
            AppRoute(
              ScreenPaths.home,
              (state) => HomeScreen(key: state.pageKey),
              useTransitionAnimation: false,
            ),
            AppRoute(
              ScreenPaths.screen1,
              (state) => SettingsScreen(key: state.pageKey),
              useTransitionAnimation: false,
            ),
          ],
          observers: const [],
        ),
      ],
    );

class AppRoute extends GoRoute {
  AppRoute(
    String path,
    Widget Function(GoRouterState s) builder, {
    List<GoRoute> super.routes = const [],
    bool useFade = false,
    bool useTransitionAnimation = true,
    super.parentNavigatorKey,
  }) : super(
          path: path,
          name: path,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
            );
            if (!useTransitionAnimation) {
              return NoTransitionPage(
                key: state.pageKey,
                child: pageContent,
                name: state.name,
              );
            }

            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                name: state.name,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(
              child: pageContent,
              name: state.name,
            );
          },
        );
}

FutureOr<String?> _handleRedirect(
  BuildContext context,
  GoRouterState state,
) async {
  // Prevent anyone from navigating away from `/` if app is starting up.
  // if (!appLogic.isBootstrapComplete && state.fullPath != ScreenPaths.splash) {
  //   return ScreenPaths.splash;
  // }
  debugPrint('Navigate to: ${state.fullPath}');

  // final authRepository = ref.read(authRepositoryProvider);
  // final authSession = await authRepository.getAuthData();

  // TODO: fixme
  // if (appLogic.isBootstrapComplete &&
  //     !authSession.isSignedIn &&
  //     ![
  //       ScreenPaths.webview,
  //       ScreenPaths.onboarding,
  //     ].contains(state.location)) {
  //   return ScreenPaths.login;
  // }

  return null; // do nothing
}
