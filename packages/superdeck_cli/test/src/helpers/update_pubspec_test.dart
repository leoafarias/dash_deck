import 'package:superdeck_cli/src/helpers/update_pubspec.dart';
import 'package:test/test.dart';

void main() {
  group('updatePubspecAssets', () {
    test('adds superdeck assets to empty pubspec', () {
      final input = '''
name: test_app
description: A test app
version: 1.0.0
''';
      final result = updatePubspecAssets(input);
      expect(result.contains('.superdeck/'), isTrue);
      expect(result.contains('.superdeck/generated/'), isTrue);
    });

    test('adds superdeck assets to pubspec with existing flutter section', () {
      final input = '''
name: test_app
flutter:
  uses-material-design: true
''';
      final result = updatePubspecAssets(input);
      expect(result.contains('.superdeck/'), isTrue);
      expect(result.contains('.superdeck/generated/'), isTrue);
      expect(result.contains('uses-material-design: true'), isTrue);
    });

    test('preserves existing assets while adding superdeck assets', () {
      final input = '''
name: test_app
flutter:
  assets:
    - assets/images/
    - assets/fonts/
''';
      final result = updatePubspecAssets(input);
      expect(result.contains('assets/images/'), isTrue);
      expect(result.contains('assets/fonts/'), isTrue);
      expect(result.contains('.superdeck/'), isTrue);
      expect(result.contains('.superdeck/generated/'), isTrue);
    });

    test('does not duplicate existing superdeck assets', () {
      final input = '''
name: test_app
flutter:
  assets:
    - .superdeck/
    - .superdeck/generated/
''';
      final result = updatePubspecAssets(input);
      expect(result.split('.superdeck/').length - 1, equals(2));
      expect(result.split('.superdeck/generated/').length - 1, equals(1));
    });

    test('preserves other flutter configuration', () {
      final input = '''
name: test_app
flutter:
  uses-material-design: true
  fonts:
    - family: CustomFont
      fonts:
        - asset: fonts/CustomFont-Regular.ttf
''';
      final result = updatePubspecAssets(input);
      expect(result.contains('uses-material-design: true'), isTrue);
      expect(result.contains('family: CustomFont'), isTrue);
      expect(result.contains('fonts/CustomFont-Regular.ttf'), isTrue);
      expect(result.contains('.superdeck/'), isTrue);
      expect(result.contains('.superdeck/generated/'), isTrue);
    });
  });
}
