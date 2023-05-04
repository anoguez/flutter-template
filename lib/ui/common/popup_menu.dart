import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/ui/screens/screen1.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PopupMenu extends ConsumerWidget {
  const PopupMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular($styles.corners.sm),
      ),
      constraints: BoxConstraints(minWidth: ScreenUtil().screenWidth * 0.8),
      icon: const Icon(Icons.menu),
      onSelected: (value) {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: const Screen1(),
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "menu1",
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: $styles.horizontalInsets.sm,
            children: [
              Icon(Icons.settings, color: $styles.colors.accent2),
              const Text('Settings')
            ],
          ),
        ),
      ],
    );
  }
}
