import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:flutter_template/routing/routes.dart";
import "package:flutter_template/routing/destination.dart";
import "package:flutter_template/ui/core/app_scaffold.dart";
import "package:flutter_template/ui/home/home.dart";
import "package:flutter_template/ui/profile/profile_screen.dart";
import "package:flutter_template/ui/settings/settings_screen.dart";
import "package:flutter_template/ui/todos/todos_screen.dart";

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: "root");

GoRouter goRouter() => GoRouter(
  navigatorKey: _rootNavigator,
  restorationScopeId: "root",
  initialLocation: AppDestination.home.path,
  routes: [
    GoRoute(
      path: ScreenPaths.root,
      redirect: (_, _) => AppDestination.home.path,
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppScaffold(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: "home"),
          routes: [
            GoRoute(
              path: AppDestination.home.path,
              builder: (_, _) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: "todos"),
          routes: [
            GoRoute(
              path: AppDestination.todos.path,
              builder: (_, _) => const TodosScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: "screen3"),
          routes: [
            GoRoute(
              path: AppDestination.profile.path,
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
