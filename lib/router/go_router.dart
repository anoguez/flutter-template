import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/ui/common/popup_menu.dart';
import 'package:flutter_template/ui/screens/home.dart';
import 'package:flutter_template/ui/screens/root_page.dart';
import 'package:flutter_template/ui/screens/screen1.dart';
import 'package:flutter_template/ui/screens/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

class ScreenPaths {
  static String root = '/';
  static String splash = '/splash';
  static String home = '/home';
  static String screen1 = '/screen1';
}

final goRouterProvider = Provider.autoDispose<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigator,
    initialLocation: '/',
    redirect: (context, state) => _handleRedirect(context, state, ref),
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
            "/",
            (state) => RootPage(key: state.pageKey),
            useTransitionAnimation: false,
          ),
          AppRoute(
            ScreenPaths.home,
            (state) => HomeScreen(key: state.pageKey),
            useTransitionAnimation: false,
          ),
          AppRoute(
            ScreenPaths.screen1,
            (state) => Screen1(key: state.pageKey),
            useTransitionAnimation: false,
          ),
        ],
        observers: const [],
      ),
    ],
  );
});

class AppRoute extends GoRoute {
  AppRoute(
    String path,
    Widget Function(GoRouterState s) builder, {
    List<GoRoute> routes = const [],
    bool useFade = false,
    bool useTransitionAnimation = true,
    GlobalKey<NavigatorState>? parentNavigatorKey,
  }) : super(
          path: path,
          name: path,
          routes: routes,
          parentNavigatorKey: parentNavigatorKey,
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
  BuildContext _,
  GoRouterState state,
  ProviderRef ref,
) async {
  final appLogic = ref.read(appLogicProvider);
  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete && state.location != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }
  debugPrint('Navigate to: ${state.location}');

  // final authRepository = ref.read(authRepositoryProvider);
  // final authSession = await authRepository.getAuthData();

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
