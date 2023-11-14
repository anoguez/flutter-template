import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/ui/common/custom_snackbar.dart';

SnackBarController useSnackBar() {
  return use(const _SnackBarController());
}

class SnackBarController {
  final BuildContext context;

  SnackBarController(this.context);

  show(String message) {
    return CustomSnackBar(context: context).show(message);
  }
}

class _SnackBarController extends Hook<SnackBarController> {
  const _SnackBarController();

  @override
  _SnackBarControllerState createState() => _SnackBarControllerState();
}

class _SnackBarControllerState
    extends HookState<SnackBarController, _SnackBarController> {
  // late SnackBarController _controller;

  @override
  void initHook() {
    super.initHook();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  SnackBarController build(BuildContext context) {
    return SnackBarController(context);
  }
}
