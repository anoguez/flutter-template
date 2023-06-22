import 'package:flutter_template/common_libs.dart';
import 'package:flutter_template/ui/common/slider_points.dart';
import 'package:flutter_template/ui/common/swipe_detector.dart';

class ImageCarousel extends HookWidget {
  final int initialIndex;
  final int? maxAllowedIndex;
  final List<Widget> pages;
  final Function(int index)? onPageChanged;

  const ImageCarousel({
    super.key,
    this.maxAllowedIndex,
    required this.pages,
    this.initialIndex = 0,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(initialPage: initialIndex);
    final selectedIndex = useState(initialIndex);
    final animationDuration = 400.ms;

    return SizedBox(
      width: double.maxFinite,
      height: 160.h,
      child: Stack(
        children: [
          SwipeDetector(
            onSwipeLeft: () {
              if (selectedIndex.value == maxAllowedIndex) return;
              pageController.animateToPage(
                selectedIndex.value + 1,
                duration: animationDuration,
                curve: Curves.easeIn,
              );
            },
            onSwipeRight: () {
              if (selectedIndex.value == 0) return;
              pageController.animateToPage(
                selectedIndex.value - 1,
                duration: animationDuration,
                curve: Curves.easeIn,
              );
            },
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: pages,
              onPageChanged: (value) {
                selectedIndex.value = value;

                if (onPageChanged != null) {
                  onPageChanged!(selectedIndex.value);
                }
              },
            ),
          ),
          Positioned(
            bottom: 10.h,
            right: 16.w,
            child: SliderPoints(
              selectedColor: $styles.colors.accent1,
              unselectedColor: $styles.colors.accent2,
              itemCount: pages.length,
              maxAllowedIndex: maxAllowedIndex ?? pages.length,
              selectedIndex: selectedIndex.value,
              onTap: (index) {
                selectedIndex.value = index;
                pageController.animateToPage(
                  index,
                  duration: 300.ms,
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
