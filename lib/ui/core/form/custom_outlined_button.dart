import 'package:flutter_template/common_libs.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.primaryColor,
    this.secondaryColor,
    this.textStyle,
    this.leadingIcon,
    this.fixedSize = const Size.fromWidth(80),
    this.borderRadius,
  });

  final String label;
  final void Function()? onPressed;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Size? fixedSize;
  final TextStyle? textStyle;
  final IconData? leadingIcon;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (onPressed != null) onPressed!();
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        disabledBackgroundColor: AppColors.grey3.withOpacity(0.5),
        fixedSize: fixedSize,
        side: BorderSide(color: primaryColor ?? AppColors.midnightGreen),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 24.r),
        ),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: $styles.horizontalInsets.sm,
        children: [
          if (leadingIcon != null) Icon(leadingIcon, color: primaryColor),
          Text(
            label,
            style: $styles.text.body
                .copyWith(
                  color: secondaryColor ?? Colors.black,
                )
                .merge(textStyle),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
