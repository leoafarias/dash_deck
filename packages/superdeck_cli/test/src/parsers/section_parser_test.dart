import 'package:superdeck_cli/src/parsers/section_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:test/test.dart';

void main() {
  // A helper function to parse the markdown and optionally check the number of sections.
  List<SectionBlock> parseAndExpectSections(
    String markdown, {
    int? expectedSectionCount,
    String? reason,
  }) {
    final sections = parseSections(markdown);
    if (expectedSectionCount != null) {
      expect(
        sections.length,
        expectedSectionCount,
        reason: reason ?? 'Unexpected number of sections parsed.',
      );
    }

    return sections;
  }

  // 1. Basic Parsing Tests - Start with fundamental functionality
  group('Basic Parsing', () {
    test('Empty markdown returns no sections', () {
      final sections = parseAndExpectSections(
        '',
        expectedSectionCount: 0,
        reason: 'Empty input should produce no sections.',
      );
      expect(sections, isEmpty);
    });

    test('Markdown with no tags returns one section with all lines', () {
      const markdown = '''
      # Just some heading
      Some regular text.
      ''';
      final sections = parseSections(markdown);
      expect(
        sections.length,
        1,
        reason: 'Should create a single default section for plain text.',
      );
      expect(
        sections[0].blocks.length,
        1,
        reason: 'All lines should be in a single block.',
      );
      expect(sections[0].blocks[0].content, markdown);
    });
  });

  // 2. Tag Parsing - Core tag parsing functionality
  group('Tag Parsing', () {
    test('Parse tag with both parts', () {
      final input = '{@column blue: car}';
      final expectedOutput = [
        (blockType: BlockType.column, options: {'blue': 'car'}),
      ];

      final result = extractTagContents(input);

      expect(result.first.blockType, equals(expectedOutput.first.blockType));
      expect(result.first.options, equals(expectedOutput.first.options));
    });

    test('Parse tag with only first part', () {
      final input = '{@column: demo}';
      expect(
        () => extractTagContents(input),
        throwsA(isA<FormatException>()),
        reason: 'Tags must have a valid blockType before the colon.',
      );
    });

    test('Parse tag with extra whitespace', () {
      final input = '{@column   red  :   bike }';
      final expectedOutput = [
        (blockType: BlockType.column, options: {'red': 'bike'}),
      ];

      final result = extractTagContents(input);

      expect(result.first.blockType, equals(expectedOutput.first.blockType));
      expect(result.first.options, equals(expectedOutput.first.options));
    });

    test('Parse tag with underscore in part names', () {
      final input = '{@column my_color: my_vehicle}';
      final expectedOutput = [
        (blockType: BlockType.column, options: {'my_color': 'my_vehicle'}),
      ];

      final result = extractTagContents(input);

      expect(result.first.blockType, equals(expectedOutput.first.blockType));
      expect(result.first.options, equals(expectedOutput.first.options));
    });

    test('Parse tag with numbers in part names', () {
      final input = '''
{@column 
  color123: vehicle456 
  blabla: 10
}
''';
      final expectedOutput = [
        (
          blockType: BlockType.column,
          options: {'color123': 'vehicle456', 'blabla': 10},
        ),
      ];

      final result = extractTagContents(input);

      expect(result.first.blockType, equals(expectedOutput.first.blockType));
      expect(result.first.options, equals(expectedOutput.first.options));
    });

    test('Return exception for input without tag', () {
      final input = 'This is a regular text without a tag.';
      expect(
        () => extractTagContents(input),
        throwsA(isA<FormatException>()),
        reason: 'No tag means no matches, should throw FormatException.',
      );
    });

    test('Return exception for input with incomplete tag', () {
      final input = '{@column';
      expect(
        () => extractTagContents(input),
        throwsA(isA<FormatException>()),
        reason: 'Incomplete tag should throw FormatException.',
      );
    });

    test('Throws exception if options cannot be parsed', () {
      final input = '{@column: blue car}';
      expect(
        () => extractTagContents(input),
        throwsA(isA<FormatException>()),
        reason: 'Invalid options format should throw FormatException.',
      );
    });
  });

  // 3. Section Structure Tests
  group('Section Structure', () {
    test('Section with columns', () {
      const markdown = '''
{@section}
# Title

{@column}
content column 1.

{@column}
content column 2.

''';

      final sections =
          parseAndExpectSections(markdown, expectedSectionCount: 1);
      expect(sections[0].blocks.length, equals(3));
      expect(
        sections[0].blocks[0].content.trim(),
        '# Title',
        reason: 'First block is a title.',
      );
      expect(
        sections[0].blocks[1].content.trim(),
        'content column 1.',
        reason: 'Second block should contain first column content.',
      );
      expect(
        sections[0].blocks[2].content.trim(),
        'content column 2.',
        reason: 'Third block should contain second column content.',
      );
    });

    test('Only columns without sections', () {
      const markdown = '''
{@column}
Content column 1.

{@column}
Content column 2.

''';

      final sections =
          parseAndExpectSections(markdown, expectedSectionCount: 1);
      expect(sections[0].blocks.length, equals(2));
      expect(sections[0].blocks[0].content.trim(), 'Content column 1.');
      expect(sections[0].blocks[1].content.trim(), 'Content column 2.');
    });

    test('Columns then sections', () {
      const markdown = '''
# Regular Markdown

This is some regular markdown content.

{@section}
## Header Title

{@column}
Content inside the header.
''';

      final sections =
          parseAndExpectSections(markdown, expectedSectionCount: 2);
      expect(sections[0].blocks.length, equals(1));
      expect(sections[1].blocks.length, equals(2));

      expect(
        sections[0].blocks[0].content.trim(),
        '# Regular Markdown\n\nThis is some regular markdown content.',
        reason: 'First section should contain the initial markdown content.',
      );

      expect(sections[1].blocks[0].content.trim(), '## Header Title');
      expect(
        sections[1].blocks[1].content.trim(),
        'Content inside the header.',
      );
    });

    test('Header, body, and footer with columns', () {
      const markdown = '''
{@section}
# Header Title

{@column}
Header content column.

{@section}
{@column}
Body content column 1.

{@column}
Body content column 2.

{@section}
{@column}
Footer content column.

''';

      final sections =
          parseAndExpectSections(markdown, expectedSectionCount: 3);

      expect(sections[0].blocks.length, equals(2));
      expect(sections[1].blocks.length, equals(2));
      expect(sections[2].blocks.length, equals(1));
      expect(sections[0].blocks[0].content.trim(), '# Header Title');
      expect(sections[0].blocks[1].content.trim(), 'Header content column.');
      expect(sections[1].blocks[0].content.trim(), 'Body content column 1.');
      expect(sections[1].blocks[1].content.trim(), 'Body content column 2.');
      expect(sections[2].blocks[0].content.trim(), 'Footer content column.');
    });
  });

  // 4. Attribute Tests
  group('Attributes', () {
    group('Column Attributes', () {
      test('Header with columns and flex attribute', () {
        const markdown = '''
{@section}
{@column
  flex: 1
}
Header content column 1.

{@column
  flex: 2
}
Header content column 2.
''';

        final sections =
            parseAndExpectSections(markdown, expectedSectionCount: 1);
        expect(sections[0].blocks.length, equals(2));
        expect(
          sections[0].blocks[0].content.trim(),
          'Header content column 1.',
        );
        expect(
          sections[0].blocks[1].content.trim(),
          'Header content column 2.',
        );

        expect(
          sections[0].blocks[0].columnOptions.flex,
          equals(1),
          reason: 'First column should have flex=1',
        );
        expect(
          sections[0].blocks[1].columnOptions.flex,
          equals(2),
          reason: 'Second column should have flex=2',
        );
      });

      test('Section with columns and alignment attribute in snake case', () {
        const markdown = '''
{@section}
{@column
      align: center
}
Body content column 1.

{@column
      align: bottom_right
}
Body content column 2.
''';

        final sections =
            parseAndExpectSections(markdown, expectedSectionCount: 1);
        expect(sections[0].blocks.length, equals(2));
        expect(sections[0].blocks[0].content.trim(), 'Body content column 1.');
        expect(sections[0].blocks[1].content.trim(), 'Body content column 2.');

        expect(
          sections[0].blocks[0].columnOptions.align,
          equals(ContentAlignment.center),
        );
        expect(
          sections[0].blocks[1].columnOptions.align,
          equals(ContentAlignment.bottomRight),
        );
      });

      test(
        'Section with columns, flex, and alignment attributes in snake case',
        () {
          const markdown = '''
{@section}
{@column
  flex: 3 
  align: top_left
}
Footer content column 1.
{@column
  flex: 1
  align: center_right
}
Footer content column 2.
''';

          final sections =
              parseAndExpectSections(markdown, expectedSectionCount: 1);
          expect(sections[0].blocks.length, equals(2));

          expect(
            sections[0].blocks[0].content.trim(),
            'Footer content column 1.',
          );
          expect(
            sections[0].blocks[1].content.trim(),
            'Footer content column 2.',
          );

          expect(sections[0].blocks[0].columnOptions.flex, equals(3));
          expect(
            sections[0].blocks[0].columnOptions.align,
            equals(ContentAlignment.topLeft),
          );

          expect(sections[0].blocks[1].columnOptions.flex, equals(1));
          expect(
            sections[0].blocks[1].columnOptions.align,
            equals(ContentAlignment.centerRight),
          );
        },
      );

      test('Sections with columns and attributes', () {
        const markdown = '''
{@section}
{@column
    flex: 1
    align: center
}
Header content.

{@section}
{@column
    flex: 2
    align: center_left
}
Body content column 1.

{@column
    flex: 1
    align: center_right
}
Body content column 2.

{@section}
{@column
    flex: 1
    align: bottom_center
}
Footer content.

''';

        final sections =
            parseAndExpectSections(markdown, expectedSectionCount: 3);

        expect(sections[0].blocks.length, equals(1));
        expect(sections[1].blocks.length, equals(2));
        expect(sections[2].blocks.length, equals(1));

        expect(sections[0].blocks[0].content.trim(), 'Header content.');
        expect(sections[0].blocks[0].flex, equals(1));
        expect(
          sections[0].blocks[0].columnOptions.align,
          equals(ContentAlignment.center),
        );

        expect(sections[1].blocks[0].content.trim(), 'Body content column 1.');
        expect(sections[1].blocks[0].columnOptions.flex, equals(2));
        expect(
          sections[1].blocks[0].columnOptions.align,
          equals(ContentAlignment.centerLeft),
        );

        expect(sections[1].blocks[1].content.trim(), 'Body content column 2.');
        expect(sections[1].blocks[1].columnOptions.flex, equals(1));
        expect(
          sections[1].blocks[1].columnOptions.align,
          equals(ContentAlignment.centerRight),
        );

        expect(sections[2].blocks[0].content.trim(), 'Footer content.');
        expect(sections[2].blocks[0].columnOptions.flex, equals(1));
        expect(
          sections[2].blocks[0].columnOptions.align,
          equals(ContentAlignment.bottomCenter),
        );
      });
    });

    group('Inheritance', () {
      test('Columns inherit options from the parent', () {
        const markdown = '''
{@section align: center}
{@column}
Header content.

{@section
  align: top_left
  flex: 2
}
{@column
  flex: 3
}
Body content.

{@section
  align: bottom_right
  flex: 1
}
{@column align: bottom_right}
Footer content.

''';

        final sections =
            parseAndExpectSections(markdown, expectedSectionCount: 3);

        expect(sections[0].blocks.length, equals(1));
        expect(sections[1].blocks.length, equals(1));
        expect(sections[2].blocks.length, equals(1));

        expect(sections[0].blocks[0].content.trim(), 'Header content.');
        expect(
          sections[0].align,
          equals(ContentAlignment.center),
          reason: 'Should inherit center alignment from parent.',
        );

        expect(sections[1].blocks[0].content.trim(), 'Body content.');
        expect(sections[1].align, equals(ContentAlignment.topLeft));
        expect(
          sections[1].blocks[0].columnOptions.flex,
          equals(3),
          reason:
              'Column should have its own flex overriding or complementing parent.',
        );

        expect(sections[2].blocks[0].content.trim(), 'Footer content.');
        expect(sections[2].align, equals(ContentAlignment.bottomRight));
        expect(sections[2].flex, equals(1));
      });
    });

    group('Failure Cases', () {
      test('Invalid flex attribute format', () {
        const markdown = '''
{@section}
{@column flex: invalid}
Header content.

''';
        expect(
          () => parseSections(markdown),
          throwsA(isA<SchemaValidationException>()),
          reason: 'Invalid flex value should throw FormatException.',
        );
      });

      test('Invalid alignment attribute value', () {
        const markdown = '''
{@section}
{@column
  align:invalid_alignment
}
Header content.

''';

        expect(
          () => parseSections(markdown),
          throwsA(isA<FormatException>()),
          reason: 'Invalid alignment value should throw FormatException.',
        );
      });
    });
  });

  // 5. Tag Content Extraction Tests
  group('Tag Content Extraction', () {
    test('Empty string', () {
      final result = extractTagContents('{@section}');
      expect(result.first.blockType, equals(BlockType.section));
      expect(
        result.first.options,
        isEmpty,
        reason: 'No options should result in an empty map.',
      );
    });

    test('Single key-value pair', () {
      final result = extractTagContents('{@section key1: value1}');
      expect(result.first.blockType, equals(BlockType.section));
      expect(result.first.options, equals({'key1': 'value1'}));
    });

    test('Single key-value pair with https url', () {
      final result = extractTagContents('''
{@section
  key0: car 
  key1: https://www.google.com
}
''');
      expect(result.first.blockType, equals(BlockType.section));
      expect(
        result.first.options,
        equals({'key0': 'car', 'key1': 'https://www.google.com'}),
      );
    });

    test('Multiple key-value pairs', () {
      final result = extractTagContents('''
{@section 
  key1: value1
  key2: value2
}
''');
      expect(
        result.first.options,
        equals({'key1': 'value1', 'key2': 'value2'}),
      );
    });

    test('Extra spaces', () {
      final result = extractTagContents('''
{@section 
  key1:  value1  
  key2:  value2}
''');
      expect(
        result.first.options,
        equals({'key1': 'value1', 'key2': 'value2'}),
      );
    });

    test('Empty value', () {
      final result = extractTagContents('{@section key1:}');
      expect(result.first.options, equals({'key1': null}));
    });

    test('Missing value', () {
      expect(
        () => extractTagContents('{@section key1}'),
        throwsA(isA<FormatException>()),
        reason: 'Missing value should cause a FormatException.',
      );
    });

    test('Invalid tag format', () {
      expect(
        () => extractTagContents('{@section key1:'),
        throwsA(isA<FormatException>()),
        reason: 'Invalid formatting should throw FormatException.',
      );
    });

    test(
      'Returns contents of the first tag when multiple tags are present',
      () {
        final result = extractTagContents(
          '{@column firstTag: true} {@column secondTag: false}',
        );
        expect(result.length, equals(2));
        expect(result.first.blockType, equals(BlockType.column));
        expect(result.first.options, equals({'firstTag': true}));

        expect(result.last.blockType, equals(BlockType.column));
        expect(result.last.options, equals({'secondTag': false}));
      },
    );

    test('Mixed valid and invalid pairs', () {
      final result = extractTagContents('''
{@column
  key1: value1
  key2: value2
}
''');
      expect(result.first.blockType, equals(BlockType.column));

      expect(
        result.first.options,
        equals({'key1': 'value1', 'key2': 'value2'}),
      );
    });

    // Test falsy value
    test('Falsy value', () {
      final result = extractTagContents('''
{@column key1: false}
''');
      final result2 = extractTagContents('''
{@column 
  key1: false 
  key2: true
}
''');
      expect(result.first.options, equals({'key1': false}));
      expect(result2.first.options, equals({'key1': false, 'key2': true}));
    });

    test('Trims leading and trailing whitespace from tag contents', () {
      final result = extractTagContents('''
{@column
  key1: value1
  key2: value2
}
''');
      expect(
        result.first.options,
        equals({'key1': 'value1', 'key2': 'value2'}),
      );
    });
  });
}

// Extension used by tests to access ColumnBlock
extension on Block {
  ContentBlock get columnOptions => this as ContentBlock;
}
