import 'package:petitparser/petitparser.dart';

extension ParserExtension<R> on Parser<R> {
  Parser between(Parser start, Parser end) =>
      (start & this & end).map((values) => values[1]);
}

class StringOptionsDefinition extends GrammarDefinition {
  const StringOptionsDefinition();

  Parser _quote() => char('"') | char("'");

  Parser quotedString() =>
      pattern('^"').star().flatten().between(ref(_quote), ref(_quote));

  /// An expression is a key-value pair or a key only.
  Parser expression() =>
      (ref(key) & char('=').trim().optional() & ref(value).optional())
          .map((values) {
        String key = (values[0] as String).trim();
        final secondValue = values[2];
        if (secondValue != null) {
          return switch (secondValue) {
            SeparatedList list => MapEntry(key, list.elements),
            String string => MapEntry(key, string.trim()),
            _ => MapEntry(key, secondValue),
          };
        }

        return MapEntry(key, true); // Default to true if value is missing
      });

  /// Defines the key with allowed characters: letters, numbers, underscores, hyphens, dots.
  Parser key() => (word() | char('_') | char('-') | char('.')).plus().flatten();

  /// Defines possible value types.
  Parser value() => ref(quotedString) | ref(list) | ref(boolean) | ref(number);

  /// Parses lists enclosed in square brackets.
  ///
  /// Example: [1, 2, 3]
  /// Example: ["1", "2", "3"]

  Parser list() =>
      (ref(numberList) | listItem().plusSeparated(char(',').trim()))
          .optional()
          .between(char('['), char(']'));

  /// Parses individual list items.
  Parser listItem() =>
      ref(numberRange) | ref(number) | ref(quotedString) | ref(boolean);

  /// Parses boolean values (case-insensitive).
  Parser boolean() => (stringIgnoreCase('true').map((_) => true) |
      stringIgnoreCase('false').map((_) => false));

  /// Parses numbers (integers and floating-point).
  Parser number() => (char('-').optional() &
          digit().plus() &
          (char('.') & digit().plus()).optional())
      .flatten()
      .map((value) => num.parse(value));

  /// Parses a list of numbers and ranges, separated by commas.
  Parser numberList() =>
      (ref(numberRange) | ref(number).map((value) => [value]))
          .plusSeparated(char(',').trim())
          .map((values) {
        // Flatten the list of lists
        return values.elements
            .expand((element) => element as List)
            .toSet()
            .toList();
      });

  Parser numberRange() => (ref(number) & char('-') & ref(number)).map((values) {
        final start = values[0] as int;
        final end = values[2] as int;
        if (start > end) {
          throw FormatException('Invalid range: $start-$end');
        }

        return List.generate(end - start + 1, (index) => start + index);
      });

  /// Defines space separators (one or more spaces).
  Parser space() => whitespace().plus();

  /// The start rule parses multiple expressions separated by spaces
  /// and converts them into a Map<String, dynamic>.
  @override
  Parser start() => ref(expression)
      .starSeparated(ref(space))
      .map((entries) => Map.fromEntries(
            entries.elements.cast<MapEntry<String, dynamic>>(),
          ))
      .end();
}

typedef FrontMatterGrammarDefinitionResult = ({String yaml, String markdown});

class FrontMatterGrammarDefinition
    extends GrammarDefinition<FrontMatterGrammarDefinitionResult> {
  const FrontMatterGrammarDefinition();

  Parser _delimiter() => string('---');

  Parser<FrontMatterGrammarDefinitionResult> _doubleDelimiter() =>
      (ref(_delimiter) &
              ref(yamlString) &
              ref(_delimiter) &
              ref(markdownContent))
          .map((values) => (yaml: values[1], markdown: values[3]));

  Parser<FrontMatterGrammarDefinitionResult> _singleDelimiter() =>
      (ref(_delimiter) & ref(markdownContent).optional())
          .map((values) => (yaml: '', markdown: values[1]));

  Parser<FrontMatterGrammarDefinitionResult> _noDelimiter() =>
      ref(markdownContent).map((values) => (yaml: '', markdown: values[0]));

  Parser yamlString() => any().starLazy(ref(_delimiter)).flatten();

  Parser markdownContent() => any().star().flatten();

  @override
  Parser<FrontMatterGrammarDefinitionResult> start() =>
      (ref(_doubleDelimiter) | ref(_singleDelimiter) | ref(_noDelimiter))
          .map((values) => (
                yaml: (values.yaml ?? '').trim(),
                markdown: (values.markdown ?? '').trim(),
              ));
}

class HtmlCommentDefinition extends GrammarDefinition<String> {
  const HtmlCommentDefinition();

  Parser _open() => string('<!--');

  Parser _close() => string('-->');

  /// Matches the full HTML comment: `<!-- comment-body -->`
  Parser htmlComment() => ref(commentBody).between(ref(_open), ref(_close));

  /// Matches the comment body:
  /// - Consumes any character unless it forms `--`
  /// - Stops lazily before the closing `-->`.
  ///
  /// This ensures we don't allow `--` anywhere **inside** the comment content,
  /// which is the strict rule for valid HTML comments.
  Parser commentBody() => (string('--').not() & any())
      .starLazy(ref(_close))
      .flatten('Invalid HTML comment (contains `--` before closing).');

  @override
  Parser<String> start() =>
      ref(htmlComment).trim().end().map((value) => (value as String).trim());
}
