import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/router/go_router.dart';
import 'package:flutter_template/ui/screens/screen1.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Screen 2"),
        ElevatedButton(
          onPressed: () {
            // context.push(ScreenPaths.screen1);
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const Screen1(),
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: const Text("Go to detail"),
        )
      ],
    ));
  }
}
