import 'package:flutter_template/common_libs.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SwipeDetector extends HookConsumerWidget {
  final Widget child;
  final Duration debounceTime;
  final Function()? onSwipeRight;
  final Function()? onSwipeLeft;

  const SwipeDetector({
    super.key,
    required this.child,
    this.debounceTime = const Duration(milliseconds: 500),
    this.onSwipeLeft,
    this.onSwipeRight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDragging = useState(false);
    final debounceDragging = useCallback(() async {
      isDragging.value = true;
      Future.delayed(debounceTime, () => isDragging.value = false);
    }, []);

    return GestureDetector(
      onPanUpdate: (details) {
        if (isDragging.value) return;
        if (onSwipeRight != null && details.delta.dx > 0) onSwipeRight!();
        if (onSwipeLeft != null && details.delta.dx < 0) onSwipeLeft!();

        debounceDragging();
      },
      child: child,
    );
  }
}
