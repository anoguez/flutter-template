import 'package:flutter_template/common_libs.dart';

@immutable
class AppColors {
  // Main colors
  final Color accent1 = const Color(0xFF73eb00);
  final Color accent2 = const Color(0xFF6A5087);

  final Color lightBackground = const Color(0xFFF8ECE5);
  final Color darkBackground = const Color(0xFF212121);

  /// Common
  final Color white = Colors.white;
  final Color black = Colors.black;
  final Color midnightGreen = const Color(0xFF00555E);
  final Color silverPink = const Color(0xFFBEABA1);
  final Color offWhite = const Color(0xFFF8ECE5);
  final Color error = Colors.red;
  final Color disabled = Colors.grey.withOpacity(0.4);

  final LinearGradient greyFade = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF626161),
      Color(0xFF212121),
    ],
  );
}
