import 'package:flutter_template/common_libs.dart';

class CustomCard extends StatelessWidget {
  final String headerLabel;
  final Color? headerColor;
  final Widget? child;

  const CustomCard({
    super.key,
    required this.headerLabel,
    this.headerColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Column(
      children: [
        // HEADER
        Container(
          padding: EdgeInsets.only(left: 8.w),
          width: double.infinity,
          decoration: BoxDecoration(
            color: headerColor ?? colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppBorderRadius.sm),
              topRight: Radius.circular(AppBorderRadius.sm),
            ),
          ),
          child: Text(
            headerLabel,
            style: $styles.text.headline.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // BODY
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(AppBorderRadius.sm),
              bottomRight: Radius.circular(AppBorderRadius.sm),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: child,
          ),
        )
      ],
    );
  }
}
