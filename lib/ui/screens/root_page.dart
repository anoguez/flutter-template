import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/hooks/use_persistent_tab_controller.dart';
import 'package:flutter_template/ui/screens/home.dart';
import 'package:flutter_template/ui/screens/screen2.dart';
import 'package:flutter_template/ui/screens/screen3.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class RootPage extends HookWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = usePersistentTabController();
    final colorScheme = Theme.of(context).colorScheme;

    return PersistentTabView(
      context,
      controller: tabController,
      backgroundColor: colorScheme.background,
      items: [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: colorScheme.primary,
          inactiveColorPrimary: colorScheme.onSecondary,
          activeColorSecondary: colorScheme.onPrimary,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.settings),
          title: ("Settings"),
          activeColorPrimary: colorScheme.primary,
          inactiveColorPrimary: colorScheme.onSecondary,
          activeColorSecondary: colorScheme.onPrimary,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.account_circle),
          title: ("Account"),
          activeColorPrimary: colorScheme.primary,
          inactiveColorPrimary: colorScheme.onSecondary,
          activeColorSecondary: colorScheme.onPrimary,
        ),
      ],
      navBarStyle: NavBarStyle.style1,
      screens: const [
        HomeScreen(),
        Screen2(),
        Screen3(),
      ],
    );
  }
}
