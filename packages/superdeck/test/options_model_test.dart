import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck_core/superdeck_core.dart';

void main() {
  group('ColumnBlock', () {
    test('merge returns original instance when other is null', () {
      final options = ContentBlock();
      expect(options.merge(null), same(options));
    });

    test('merge returns new instance with merged values', () {
      final options1 = ContentBlock(flex: 2, align: ContentAlignment.topLeft);
      final options2 = ContentBlock(align: ContentAlignment.bottomRight);
      final merged = options1.merge(options2);
      expect(merged.flex, options1.flex);
      expect(merged.align, options2.align);
    });
  });

  group('ImageOptions', () {
    test('constructor sets properties correctly', () {
      final options = LocalAssetBlock(
          src: 'image.png',
          fit: ImageFit.cover,
          flex: 3,
          align: ContentAlignment.center);
      expect(options.src, 'image.png');
      expect(options.fit, ImageFit.cover);
      expect(options.flex, 3);
      expect(options.align, ContentAlignment.center);
    });
  });

  group('WidgetOptions', () {
    test('constructor sets properties correctly', () {
      final options = WidgetBlock(
        name: 'MyWidget',
        args: {'key': 'value'},
        flex: 2,
        align: ContentAlignment.topCenter,
      );
      expect(options.type, 'MyWidget');
      expect(options.args, {'key': 'value'});
      expect(options.flex, 2);
      expect(options.align, ContentAlignment.topCenter);
    });
  });
}
