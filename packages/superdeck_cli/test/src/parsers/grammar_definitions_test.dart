import 'package:petitparser/petitparser.dart';
import 'package:superdeck_cli/src/parsers/parsers/grammar_definitions.dart';
import 'package:test/test.dart';

void main() {
  group('HtmlCommentDefinition', () {
    final parser = const HtmlCommentDefinition().build();

    test('parses simple HTML comment', () {
      expect(parser.parse('<!-- Simple comment -->').value, 'Simple comment');
    });

    test('parses empty HTML comment', () {
      expect(parser.parse('<!---->').value, '');
    });

    // Trst if you can have -- in the comment
    test('parses HTML comment with --', () {
      final result = parser.parse('<!-- This is a -- comment -->');

      expect(result is Failure, isTrue);
      expect(
        result.message,
        'Invalid HTML comment (contains `--` before closing).',
      );
      expect(result.position, 4);
      expect(() => result.value, throwsA(isA<ParserException>()));
    });

    // check if acomment has spaces in front or in teh end
    test('parses HTML comment with spaces in front or in the end', () {
      expect(
          parser.parse('   <!-- Simple comment -->').value, 'Simple comment');
      expect(parser.parse('<!-- Simple comment -->  ').value, 'Simple comment');
    });

    test('parses multiline HTML comment', () {
      const comment = '''<!-- This is a
      multiline comment -->''';
      expect(parser.parse(comment).value.trim(),
          'This is a\n      multiline comment');
    });
  });

  group('StringOptionsDefinition', () {
    final parser = StringOptionsDefinition().build();
    test('Parses single boolean option without value', () {
      expect(parser.parse('showLineNumbers=true').value,
          {'showLineNumbers': true});
    });

    // number example
    test('Parses number option', () {
      expect(parser.parse('count=10').value, {'count': 10});
      expect(parser.parse('count=10.5').value, {'count': 10.5});
      expect(parser.parse('count=-10.5').value, {'count': -10.5});
    });

    test('Parses single boolean option without equal sign', () {
      expect(parser.parse('showLineNumbers').value, {'showLineNumbers': true});
    });

    test('Parses boolean options with true and false', () {
      expect(parser.parse('showLineNumbers=true').value,
          {'showLineNumbers': true});
      expect(parser.parse('showLineNumbers=false').value,
          {'showLineNumbers': false});
    });

    test('Parses string options with quotes', () {
      expect(parser.parse('fileName="example.dart"').value,
          {'fileName': 'example.dart'});
      expect(parser.parse('anotherOption="another_example.dart"').value,
          {'anotherOption': 'another_example.dart'});
    });

    test('Parses list options', () {
      expect(
        parser.parse('options=["option1", "option2", "option3"]').value,
        {
          'options': ['option1', 'option2', 'option3']
        },
      );
      expect(parser.parse('lines=[2-5,3]').value, {
        'lines': [2, 3, 4, 5]
      });
    });

    test('Parses multiple options on the same line separated by spaces', () {
      expect(parser.parse('flex=1 align="center"').value,
          {'flex': 1, 'align': 'center'});
      expect(parser.parse('flex=3 align="top_left"').value,
          {'flex': 3, 'align': 'top_left'});
    });

    test('Handles mixed types', () {
      expect(
        parser
            .parse(
                'showLineNumbers=true fileName="test.dart" options=["opt1", "opt2"] flex=2')
            .value,
        {
          'showLineNumbers': true,
          'fileName': 'test.dart',
          'options': ['opt1', 'opt2'],
          'flex': 2,
        },
      );
    });

    test('Handles expressions without values gracefully', () {
      expect(
        parser.parse('showLineNumbers fileName="test.dart"').value,
        {
          'showLineNumbers': true,
          'fileName': 'test.dart',
        },
      );
    });

    test('Handles lists with quoted items', () {
      expect(
        parser.parse('options=["option one", "option two"]').value,
        {
          'options': ['option one', 'option two']
        },
      );
    });

    test('Handles numeric values', () {
      expect(parser.parse('count=10 threshold=15.5').value,
          {'count': 10, 'threshold': 15.5});
    });

    test('Handles extended key characters', () {
      expect(
        parser
            .parse(
                'user-name="JohnDoe" user.email="john.doe@example.com" isAdmin=true')
            .value,
        {
          'user-name': 'JohnDoe',
          'user.email': 'john.doe@example.com',
          'isAdmin': true,
        },
      );
    });

    test('Handles empty input', () {
      expect(parser.parse('').value, {});
    });

    test('Handles keys with underscores and numbers', () {
      expect(parser.parse('key_1=10 key_2="value"').value,
          {'key_1': 10, 'key_2': 'value'});
    });

    test('Handles keys with camelCase and PascalCase', () {
      expect(parser.parse('camelCaseKey=true PascalCaseKey="value"').value,
          {'camelCaseKey': true, 'PascalCaseKey': 'value'});
    });

    test('Handles values with special characters', () {
      expect(parser.parse('key="!@#\$%^&*()_+-=[]{}|;:,.<>?"').value,
          {'key': '!@#\$%^&*()_+-=[]{}|;:,.<>?'});
    });

    test('Handles negative numeric values', () {
      expect(parser.parse('negativeInt=-10 negativeDouble=-3.14').value,
          {'negativeInt': -10, 'negativeDouble': -3.14});
    });

    test('Handles list options with numeric values', () {
      expect(parser.parse('numbers=[1, 2, 3]').value, {
        'numbers': [1, 2, 3]
      });
    });

    test('Handles list options with boolean values', () {
      expect(parser.parse('booleans=[true, false]').value, {
        'booleans': [true, false]
      });
    });
  });

  group('FrontmatterDefinition', () {
    final parser = const FrontMatterGrammarDefinition().build();

    test('parses frontmatter', () {
      const content = '''---
title: "Sample Document"
author: "John Doe"
tags:
  - example
  - test
---
# Heading
Content goes here.
''';
      final result = parser.parse(content).value;
      expect(result.yaml, '''title: "Sample Document"
author: "John Doe"
tags:
  - example
  - test''');
      expect(result.markdown, '# Heading\nContent goes here.');
    });

    test('parses frontmatter with no content', () {
      const content = '''---
title: "Empty Document"
author: "Jane Smith"
tags:
  - empty
  - test
---
''';
      final result = parser.parse(content).value;
      expect(result.yaml, '''title: "Empty Document"
author: "Jane Smith"
tags:
  - empty
  - test''');
      expect(result.markdown, '');
    });

    test('parses frontmatter with single delimiter', () {
      const content = '---';
      final result = parser.parse(content).value;
      expect(result.yaml, '');
      expect(result.markdown, '');
    });

    test('parses frontmatter with single delimiter and content', () {
      const content = '''
---
# Heading
Content goes here.
''';
      final result = parser.parse(content).value;
      expect(result.yaml, '');
      expect(result.markdown, '# Heading\nContent goes here.');
    });
  });
}
