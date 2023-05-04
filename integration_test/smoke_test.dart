import 'package:flutter_template/common_libs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  // Start app
  final container = ProviderContainer();
  registerSingletons();

  await container.read(appLogicProvider).bootstrap();

  testWidgets('Smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MyApp(),
      ),
    );

    await tester.pumpAndSettle(); // Finish animations and scheduled microtasks
    await tester.pump(const Duration(seconds: 2)); // Render another frame in 2s
  });
}
