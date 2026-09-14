import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:flutter_template/ui/core/custom_bottom_navigation.dart";
import "package:flutter_template/ui/core/popup_menu.dart";
import "package:flutter_template/ui/core/themes/styles.dart";
import "package:flutter_template/routing/destination.dart";

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _selectTab(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Flutter Template"),
      actions: const [PopupMenu()],
    ),
    body: DecoratedBox(
      decoration: BoxDecoration(gradient: AppColors.greyFade),
      child: navigationShell,
    ),
    bottomNavigationBar: CustomBottomNavigation(
      destinations: primaryDestinations,
      currentIndex: navigationShell.currentIndex,
      onTabSelected: _selectTab,
    ),
  );
}
