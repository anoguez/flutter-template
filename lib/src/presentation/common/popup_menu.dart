import 'package:flutter_template/common_libs.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular($styles.corners.sm),
      ),
      constraints: BoxConstraints(minWidth: ScreenUtil().screenWidth * 0.8),
      icon: const Icon(Icons.menu),
      onSelected: (value) {
        // TODO: fix me
        // PersistentNavBarNavigator.pushNewScreen(
        //   context,
        //   screen: const SettingsScreen(),
        //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
        // );
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "menu1",
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: $styles.horizontalInsets.sm,
            children: [
              Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              const Text('Settings'),
            ],
          ),
        ),
      ],
    );
  }
}
