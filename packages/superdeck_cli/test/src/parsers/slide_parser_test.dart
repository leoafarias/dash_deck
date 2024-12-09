import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/parsers/markdown_parser.dart';
import 'package:superdeck_cli/src/parsers/slide_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:test/test.dart';

Future<List<Slide>> _parseSlides(String markdown) async {
  final slidesRaws = MarkdownParser.parse(markdown);
  return await Future.wait(
      slidesRaws.map((slideRaw) => SlideConverter.convert(slideRaw, [])));
}

void main() {
  group('parseSlides', () {
    test('parses valid markdown into slides', () async {
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

      final slides = await _parseSlides(markdown);

      for (var slide in slides) {
        print('Slide: ${slide.options?.title}');
        print('Markdown: ${slide.markdown}');
      }

      expect(slides.length, equals(2));
      expect(slides[0].options?.title, equals('Slide 1'));
      expect(slides[0].markdown, equals('Content for slide 1'));
      expect(slides[1].options?.title, equals('Slide 2'));
      expect(slides[1].markdown, equals('Content for slide 2'));
    });

    test('parses slides with additional properties in YAML frontmatter',
        () async {
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

      final slides = await _parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options?.title, equals('Slide 1'));

      expect(slides[0].markdown, equals('Content for slide 1'));
      expect(slides[1].options?.title, equals('Slide 2'));

      expect(slides[1].markdown, equals('Content for slide 2'));
    });

    test('handles slides with no properties in frontmatter', () async {
      const markdown = '''
---
---
Content for slide 1

---
---
Content for slide 2
''';

      final slides = await _parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options, SlideOptions());
      expect(slides[0].markdown, equals('Content for slide 1'));
      expect(slides[1].options, SlideOptions());
      expect(slides[1].markdown, equals('Content for slide 2'));
    });

    test('handles slides with empty frontmatter', () async {
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

      final slides = await _parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options?.title, isNull);
      expect(slides[0].markdown, equals('Content for slide 1'));
      expect(slides[1].options?.title, isNull);
      expect(slides[1].markdown, equals('Content for slide 2'));
    });

    test('throws SDFormatException on invalid YAML frontmatter', () async {
      const markdown = '''
---  
invalid: yaml: frontmatter
---
Slide content
''';

      expect(() => _parseSlides(markdown), throwsA(isA<SdFormatException>()));
    });

    test('throws SDMarkdownParsingException on invalid slide schema', () async {
      const markdown = '''
---
invalidField: Invalid value
---  
Slide content 
''';

      expect(() => _parseSlides(markdown),
          throwsA(isA<SdMarkdownParsingException>()));
    });

    test('handles empty markdown string', () async {
      const markdown = '';

      final slides = await _parseSlides(markdown);

      expect(slides, isEmpty);
    });

    test('ignores content outside slide separators', () async {
      const markdown = '''
This content is outside slides
---
title: Slide 1
---
Content for slide 1

This content is also outside slides
''';

      final slides = await _parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[1].options?.title, equals('Slide 1'));
      expect(slides[1].markdown,
          equals('Content for slide 1\n\nThis content is also outside slides'));
    });

    test('parses slide with no content but valid frontmatter', () async {
      const markdown = '''
---
title: Slide 1
---
''';

      final slides = await _parseSlides(markdown);

      expect(slides.length, equals(1));
      expect(slides[0].options?.title, equals('Slide 1'));
      expect(slides[0].markdown, isEmpty);
    });

    test('parses multiple slides with some missing content or frontmatter',
        () async {
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

      final slides = await _parseSlides(markdown);

      expect(slides.length, equals(3));
      expect(slides[0].options?.title, equals('Slide 1'));
      expect(slides[0].markdown, equals('Content for slide 1'));

      expect(slides[1].options?.title, equals('Slide 2'));
      expect(slides[1].markdown, isEmpty);

      expect(slides[2].options?.title, equals('Slide 3'));
      expect(slides[2].markdown, equals('Content for slide 3'));
    });
  });

  // Group test notes from comments
  group('Correctly parses slide notes from markdown comments', () {
    test('parses notes from markdown comments', () async {
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

      final slides = await _parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options?.title, equals('Slide 1'));
      expect(slides[0].markdown,
          equals('Content for slide 1\n\n<!-- This is a note for slide 1 -->'));
      expect(slides[0].notes.length, equals(1));
      expect(slides[0].notes[0].content, equals('This is a note for slide 1'));

      expect(slides[1].options?.title, equals('Slide 2'));
      expect(slides[1].markdown, equals('Content for slide 2'));
      expect(slides[1].notes, isEmpty);
    });

    test('parses multiple notes from markdown comments', () async {
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

      final slides = await _parseSlides(markdown);

      expect(slides.length, equals(2));
      expect(slides[0].options?.title, equals('Slide 1'));
      expect(
          slides[0].markdown,
          equals(
              'Content for slide 1\n\n<!-- This is a note for slide 1 -->\n\n<!-- This is another note for slide 1 -->\n\n<!-- This is a third note for \nslide 1 -->'));
      expect(slides[0].notes.length, equals(3));
      expect(slides[0].notes[0].content, equals('This is a note for slide 1'));

      expect(slides[0].notes[1].content,
          equals('This is another note for slide 1'));

      expect(slides[0].notes[2].content,
          equals('This is a third note for \nslide 1'));

      expect(slides[1].options?.title, equals('Slide 2'));
      expect(slides[1].markdown, equals('Content for slide 2'));
      expect(slides[1].notes, isEmpty);
    });
  });

  // Test that mixes single --- with frontmatter
  group('Handles slides with mixed frontmatter and ---', () {
    test('parses slides with mixed frontmatter and ---', () async {
      const markdown = '''
---
title: Slide 1
--- 
Content for slide 1

---

Content for the second slide
''';

      final slides = await _parseSlides(markdown);

      expect(slides.length, equals(2));

      expect(slides[0].options?.title, equals('Slide 1'));
      expect(slides[0].markdown, equals('Content for slide 1'));

      expect(slides[1].options, SlideOptions());
      expect(slides[1].markdown, equals('Content for the second slide'));

      expect(slides[1].notes, isEmpty);
    });
  });
}
