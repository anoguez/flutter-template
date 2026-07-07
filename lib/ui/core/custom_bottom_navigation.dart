import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_template/core/extensions/theme_extension.dart';
import 'package:flutter_template/ui/core/themes/styles.dart';

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
      selectedLabelStyle: $styles.text.stylish.copyWith(
        color: context.colors.primary,
      ),
      unselectedLabelStyle: $styles.text.stylish.copyWith(
        color: context.colors.onSurfaceVariant,
      ),
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.gamepad),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.listCheck),
          label: 'Todos',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.user),
          label: 'Screen 3',
        ),
      ],
    );
  }
}
