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
    return Column(
      children: [
        // HEADER
        Container(
          padding: EdgeInsets.only(left: 8.w),
          width: double.infinity,
          decoration: BoxDecoration(
            color: headerColor ?? Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.r),
              topRight: Radius.circular(8.r),
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
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.r),
              bottomRight: Radius.circular(8.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: child,
          ),
        )
      ],
    );
  }
}
