import 'package:superdeck_cli/src/parsers/markdown_parser.dart';
import 'package:test/test.dart';

void main() {
  group('MarkdownParser.parse', () {
    test('parses valid markdown into RawSlides', () {
      const markdown = '''
---
title: Slide 1
---

Content for slide 1

---
title: Slide 2 
---  

Content for slide 2

---

Content for slide 3
''';

      final slides = MarkdownParser.parse(markdown);

      expect(slides.length, equals(3));
      expect(slides[0].options['title'], equals('Slide 1'));
      expect(slides[0].markdown, equals('Content for slide 1'));
      expect(slides[1].options['title'], equals('Slide 2'));
      expect(slides[1].markdown, equals('Content for slide 2'));
      expect(slides[2].options, equals({}));
      expect(slides[2].markdown, equals('Content for slide 3'));
    });

    test(
      'parses RawSlides with additional properties in YAML frontmatter',
      () {
        const markdown = '''
---
title: Slide 1
---
Content for slide 1

---
title: Slide 2 
---  
Content for slide 2
''';

        final slides = MarkdownParser.parse(markdown);

        expect(slides.length, equals(2));
        expect(slides[0].options['title'], equals('Slide 1'));

        expect(slides[0].markdown, equals('Content for slide 1'));
        expect(slides[1].options['title'], equals('Slide 2'));

        expect(slides[1].markdown, equals('Content for slide 2'));
      },
    );

    test('handles RawSlides with no properties in frontmatter', () {
      const markdown = '''
---
---
Content for slide 1

---
---
Content for slide 2
''';

      final slides = MarkdownParser.parse(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options, equals({}));
      expect(slides[0].markdown, equals('Content for slide 1'));
      expect(slides[1].options, equals({}));
      expect(slides[1].markdown, equals('Content for slide 2'));
    });

    test('handles RawSlides with empty frontmatter', () {
      const markdown = '''
---
title: 
---
Content for slide 1

---
title: 
---  
Content for slide 2
''';

      final slides = MarkdownParser.parse(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options['title'], isNull);
      expect(slides[0].markdown, equals('Content for slide 1'));
      expect(slides[1].options['title'], isNull);
      expect(slides[1].markdown, equals('Content for slide 2'));
    });

    test('handles empty markdown string', () {
      const markdown = '';

      final slides = MarkdownParser.parse(markdown);

      expect(slides, isEmpty);
    });

    test('ignores content outside slide separators', () {
      const markdown = '''
This content is outside slides
---
title: Slide 1
---
Content for slide 1

This last content is also outside slides
''';

      final slides = MarkdownParser.parse(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options, equals({}));
      expect(slides[1].options['title'], equals('Slide 1'));
      expect(
        slides[1].markdown,
        equals(
          'Content for slide 1\n\nThis last content is also outside slides',
        ),
      );
    });

    test('parses RawSlide with no content but valid frontmatter', () {
      const markdown = '''
---
title: Slide 1
---
''';

      final slides = MarkdownParser.parse(markdown);

      expect(slides.length, equals(1));
      expect(slides[0].options['title'], equals('Slide 1'));
      expect(slides[0].markdown, isEmpty);
    });

    test(
      'parses multiple RawSlides with some missing content or frontmatter',
      () {
        const markdown = '''
---
title: Slide 1
---
Content for slide 1

---
title: Slide 2
---
---
title: Slide 3
---
Content for slide 3
''';

        final slides = MarkdownParser.parse(markdown);

        expect(slides.length, equals(3));
        expect(slides[0].options['title'], equals('Slide 1'));
        expect(slides[0].markdown, equals('Content for slide 1'));

        expect(slides[1].options['title'], equals('Slide 2'));
        expect(slides[1].markdown, isEmpty);

        expect(slides[2].options['title'], equals('Slide 3'));
        expect(slides[2].markdown, equals('Content for slide 3'));
      },
    );
  });

  // Group test notes from comments
  group('Correctly parses slide notes from markdown comments', () {
    test('parses notes from markdown comments', () {
      const markdown = '''
---
title: Slide 1
---
Content for slide 1

<!-- This is a note for slide 1 -->

---
title: Slide 2
---

Content for slide 2

''';

      final slides = MarkdownParser.parse(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options['title'], equals('Slide 1'));
      expect(
        slides[0].markdown,
        equals('Content for slide 1\n\n<!-- This is a note for slide 1 -->'),
      );
      expect(slides[0].comments.length, equals(1));
      expect(slides[0].comments[0], equals('This is a note for slide 1'));

      expect(slides[1].options['title'], equals('Slide 2'));
      expect(slides[1].markdown, equals('Content for slide 2'));
      expect(slides[1].comments, isEmpty);
    });

    test('parses multiple notes from markdown comments', () {
      const markdown = '''
---
title: Slide 1
---
Content for slide 1

<!-- This is a note for slide 1 -->

<!-- This is another note for slide 1 -->

<!-- This is a third note for 
slide 1 -->

---
title: Slide 2
---

Content for slide 2

''';

      final slides = MarkdownParser.parse(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options['title'], equals('Slide 1'));
      expect(
        slides[0].markdown,
        equals(
          'Content for slide 1\n\n<!-- This is a note for slide 1 -->\n\n<!-- This is another note for slide 1 -->\n\n<!-- This is a third note for \nslide 1 -->',
        ),
      );
      expect(slides[0].comments.length, equals(3));
      expect(slides[0].comments[0], equals('This is a note for slide 1'));

      expect(
        slides[0].comments[1],
        equals('This is another note for slide 1'),
      );

      expect(
        slides[0].comments[2],
        equals('This is a third note for \nslide 1'),
      );

      expect(slides[1].options['title'], equals('Slide 2'));
      expect(slides[1].markdown, equals('Content for slide 2'));
      expect(slides[1].comments, isEmpty);
    });
  });

  // Test that mixes single --- with frontmatter
  group('Handles slides with mixed frontmatter and ---', () {
    test('parses slides with mixed frontmatter and ---', () {
      const markdown = '''
---
title: Slide 1
--- 
Content for slide 1

---

Content for the second slide
''';

      final slides = MarkdownParser.parse(markdown);

      expect(slides.length, equals(2));

      expect(slides[0].options['title'], equals('Slide 1'));
      expect(slides[0].markdown, equals('Content for slide 1'));

      expect(slides[1].options, equals({}));
      expect(slides[1].markdown, equals('Content for the second slide'));

      expect(slides[1].comments, isEmpty);
    });
  });
}
