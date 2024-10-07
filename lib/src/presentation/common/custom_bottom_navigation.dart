import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_template/core/theme/styles.dart';

class CustomBottomNavigation extends HookWidget {
  final void Function(int)? onTabSelected;

  const CustomBottomNavigation({
    super.key,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(0);

    final setSelectedTab = useCallback((int index) {
      currentIndex.value = index;
      if (onTabSelected != null) onTabSelected!(index);
    }, []);

    return BottomNavigationBar(
      currentIndex: currentIndex.value,
      onTap: setSelectedTab,
      selectedItemColor: $styles.colors.accent1,
      backgroundColor: Colors.black,
      selectedLabelStyle: $styles.text.stylish.copyWith(
        color: $styles.colors.white,
      ),
      unselectedLabelStyle: $styles.text.stylish.copyWith(
        color: $styles.colors.white,
      ),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.gamepad),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
          label: 'Screen 2',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.user),
          label: 'Screen 3',
        ),
      ],
    );
  }
}
