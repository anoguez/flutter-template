import "package:flutter/material.dart";
import "package:flutter_template/core/extensions/theme_extension.dart";
import "package:flutter_template/ui/core/themes/styles.dart";
import "package:flutter_template/routing/destination.dart";

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    required this.destinations,
    required this.currentIndex,
    required this.onTabSelected,
    super.key,
  });

  final List<AppDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: onTabSelected,
    selectedLabelStyle: $styles.text.stylish.copyWith(
      color: context.colors.primary,
    ),
    unselectedLabelStyle: $styles.text.stylish.copyWith(
      color: context.colors.onSurfaceVariant,
    ),
    items: [
      for (final destination in destinations)
        BottomNavigationBarItem(
          icon: Icon(destination.icon),
          label: destination.label,
        ),
    ],
  );
}
