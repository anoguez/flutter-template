import 'package:flutter_template/common_libs.dart';

class DashedDivider extends StatelessWidget {
  final Color? color;
  final double height;
  final double width;
  final double space;
  const DashedDivider({
    super.key,
    this.color,
    this.height = 1,
    this.width = 3,
    this.space = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();

        final dashCount = (boxWidth / (2 * width)).floor();
        return Padding(
          padding: EdgeInsets.symmetric(vertical: space),
          child: Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: width,
                height: height,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: color ?? $styles.colors.accent1,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
