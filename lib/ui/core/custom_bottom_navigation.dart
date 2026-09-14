import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:flutter_template/core/extensions/theme_extension.dart";
import "package:flutter_template/ui/core/themes/styles.dart";

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    required this.currentIndex,
    required this.onTabSelected,
    super.key,
  });

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
    items: const [
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.house),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.listCheck),
        label: "Todos",
      ),
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.user),
        label: "Profile",
      ),
    ],
  );
}
