
import 'package:flutter_template/common_libs.dart';

class AppScaffold extends StatelessWidget with GetItMixin {
  AppScaffold({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Animate.defaultDuration = $styles.times.fast;
    return Stack(
      children: [
        Theme(
          data: $styles.colors.toThemeData(),
          // Provide a default texts style to allow Hero's to render text properly
          child: DefaultTextStyle(
            style: $styles.text.body,
            child: child,
          ),
        ),
      ],
    );
  }
}
