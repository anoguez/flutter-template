import 'package:flutter_template/common_libs.dart';

class CustomSnackBar {
  final BuildContext context;

  CustomSnackBar({required this.context});

  show(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
