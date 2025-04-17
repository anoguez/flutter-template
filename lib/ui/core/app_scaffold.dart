import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_template/ui/core/themes/styles.dart';
import 'package:flutter_template/ui/core/custom_bottom_navigation.dart';

class AppScaffold extends HookWidget {
  final Widget? child;
  final List<Widget> pages;

  const AppScaffold({
    required this.pages,
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentIndex = useState(0);

    final selectTab = useCallback((int index) {
      if (index == currentIndex.value) return;

      currentIndex.value = index;
      pageController.jumpToPage(currentIndex.value);
    }, []);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.greyFade,
        ),
        child: PageView(
          controller: pageController,
          children: pages,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        onTabSelected: selectTab,
      ),
    );
  }
}
