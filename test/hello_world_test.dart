import 'package:test/test.dart';

void main() {
  group('Dart 3 - New features', () {
    test('RECORDS', () {
      (String, int) userInfo(Map<String, dynamic> json) {
        return (json['name'] as String, json['height'] as int);
      }

      final (String name, int height) =
          userInfo({'name': 'Anderson', 'height': 176});

      expect(name, "Anderson");
      expect(height, 176);
    });
  });
}
