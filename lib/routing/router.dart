import "package:flutter_template/common_libs.dart";
import "package:flutter_template/routing/routes.dart";
import "package:flutter_template/ui/core/app_scaffold.dart";
import "package:flutter_template/ui/home/home.dart";
import "package:flutter_template/ui/profile/profile_screen.dart";
import "package:flutter_template/ui/settings/settings_screen.dart";
import "package:flutter_template/ui/todos/todos_screen.dart";

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: "root");

GoRouter goRouter() => GoRouter(
  navigatorKey: _rootNavigator,
  restorationScopeId: "root",
  initialLocation: ScreenPaths.home,
  routes: [
    GoRoute(path: ScreenPaths.root, redirect: (_, _) => ScreenPaths.home),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: "home"),
          routes: [
            GoRoute(
              path: ScreenPaths.home,
              builder: (_, _) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: "todos"),
          routes: [
            GoRoute(
              path: ScreenPaths.todos,
              builder: (_, _) => const TodosScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: "screen3"),
          routes: [
            GoRoute(
              path: ScreenPaths.profile,
              builder: (_, _) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: ScreenPaths.settings,
      parentNavigatorKey: _rootNavigator,
      builder: (_, _) => const SettingsScreen(),
    ),
  ],
);
