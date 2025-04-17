import 'package:flutter_template/common_libs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'MyWidget has a title and message',
    (tester) async {
      // Create the widget by telling the tester to build it.
      await tester.pumpWidget(
        const SizedBox(
          width: 300,
          height: 300,
        ),
      );
    },
  );
}
