import 'package:flutter_template/common_libs.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

PersistentTabController usePersistentTabController() {
  return use(const _PersistentTabController());
}

class _PersistentTabController extends Hook<PersistentTabController> {
  const _PersistentTabController();

  @override
  _PersistentTabControllerState createState() =>
      _PersistentTabControllerState();
}

class _PersistentTabControllerState
    extends HookState<PersistentTabController, _PersistentTabController> {
  late PersistentTabController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = PersistentTabController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  PersistentTabController build(BuildContext context) {
    return _controller;
  }
}
