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
    final colors = context.colors;
    return OutlinedButton(
      onPressed: () {
        if (onPressed != null) onPressed!();
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        fixedSize: fixedSize,
        side: BorderSide(color: primaryColor ?? colors.primary),
        shape: borderRadius == null
            ? null
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius!.r),
              ),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: $styles.horizontalInsets.sm,
        children: [
          if (leadingIcon != null)
            Icon(leadingIcon, color: primaryColor ?? colors.primary),
          Text(
            label,
            style: $styles.text.body
                .copyWith(
                  color: secondaryColor ?? colors.primary,
                )
                .merge(textStyle),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
