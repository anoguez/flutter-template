import 'package:flutter_template/common_libs.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.primaryColor,
    this.secondaryColor,
    this.textStyle,
    this.leadingIcon,
    this.fixedSize = const Size.fromWidth(80),
    this.leadingIconImage,
    this.borderRadius,
  }) : super(
          key: key,
        );

  final String label;
  final void Function()? onPressed;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Size? fixedSize;
  final TextStyle? textStyle;
  final IconData? leadingIcon;
  final Image? leadingIconImage;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) onPressed!();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor ?? $styles.colors.accent1,
        disabledBackgroundColor: $styles.colors.disabled,
        fixedSize: fixedSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 24.r),
        ),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: $styles.horizontalInsets.sm,
        children: [
          if (leadingIcon != null) Icon(leadingIcon),
          if (leadingIconImage != null) leadingIconImage!,
          Text(
            label,
            style: $styles.text.body
                .copyWith(
                  color: secondaryColor ?? $styles.colors.white,
                )
                .merge(textStyle),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
