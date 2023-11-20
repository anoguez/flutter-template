import 'package:flutter/cupertino.dart';
import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/ui/common/popup_menu.dart';
import 'package:flutter_template/ui/screens/home.dart';
import 'package:flutter_template/ui/screens/root_page.dart';
import 'package:flutter_template/ui/screens/settings/settings_screen.dart';
import 'package:flutter_template/ui/screens/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

class ScreenPaths {
  static String root = '/';
  static String splash = '/splash';
  static String home = '/home';
  static String screen1 = '/screen1';
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
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
            (state) => SettingsScreen(key: state.pageKey),
            useTransitionAnimation: false,
          ),
        ],
        observers: const [],
      ),
    ],
  );
}

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
  ProviderRef ref,
) async {
  final appLogic = ref.read(appLogicProvider);

  // Prevent anyone from navigating away from `/` if app is starting up.
  if (!appLogic.isBootstrapComplete && state.fullPath != ScreenPaths.splash) {
    return ScreenPaths.splash;
  }
  debugPrint('Navigate to: ${state.fullPath}');

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
