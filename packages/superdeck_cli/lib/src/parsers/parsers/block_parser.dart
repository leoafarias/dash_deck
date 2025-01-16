import 'dart:convert';

final codeFencePattern = RegExp(
  r'```(?<backtickInfo>[^`]*)[\s\S]*?```',
  multiLine: true,
);

// ```<language> {<key1>: <value1>, <key2>: <value2>, ...}
// <code content>
// ```

// Data class to hold code block details
class ParsedFencedCode {
  final Map<String, dynamic> options;
  final String language;
  final String content;
  // The first index of the opening fence
  final int startIndex;
  // The last index of the closing fence
  final int endIndex;

  const ParsedFencedCode({
    required this.options,
    required this.language,
    required this.content,
    required this.startIndex,
    required this.endIndex,
  });

  @override
  String toString() {
    return 'ParsedCodeBlock(language: $language, content: $content, startIndex: $startIndex, endIndex: $endIndex)';
  }
}

List<ParsedFencedCode> parseFencedCode(String text) {
  final matches = codeFencePattern.allMatches(text);
  List<ParsedFencedCode> parsedBlocks = [];

  for (final match in matches) {
    final backtickInfo = match.namedGroup('backtickInfo');

    final lines = backtickInfo?.split('\n');
    final firstLine = lines?.first ?? '';
    final rest = lines?.sublist(1).join('\n') ?? '';

    final language = firstLine.split(' ')[0];
    final options = firstLine.replaceFirst(language, '').trim();

    final content = rest;

    final startIndex = match.start;
    final endIndex = match.end;

    parsedBlocks.add(ParsedFencedCode(
      options: jsonDecode(extractStringMap(options)),
      language: language,
      content: content.trim(),
      startIndex: startIndex,
      endIndex: endIndex,
    ));
  }

  return parsedBlocks;
}

class ParsedTagBlock {
  final String tag;
  final Map<String, dynamic> options;
  final int startIndex;

  final int endIndex;

  const ParsedTagBlock({
    required this.tag,
    required this.options,
    required this.startIndex,
    required this.endIndex,
  });
}

List<ParsedTagBlock> parseTagBlocks(String text) {
  // @tag
  // @tag {key: value}
  // @tag{key: value, key2: value2}
  // @tag {key: value, key2: value2, key3: value3}
  // @tag{
  //   key: value
  //   key2: value2
  //   key3: value3
  // }

  // Get the "tag", which could be any word, and also maybe it does not have space
  final tagRegex = RegExp(r'@(\w+)(?:\s*{([^{}]*)})?');

  final matches = tagRegex.allMatches(text);
  List<ParsedTagBlock> parsedBlocks = [];
  for (final match in matches) {
    final tag = match.group(1) ?? '';
    final options = match.group(2) ?? '';

    final startIndex = match.start;
    final endIndex = match.end;

    parsedBlocks.add(ParsedTagBlock(
      tag: tag,
      options: jsonDecode(extractStringMap(options)),
      startIndex: startIndex,
      endIndex: endIndex,
    ));
  }

  return parsedBlocks;
}

/// Transforms a string of the format `{key1: value1, key2: value2}`
/// into a JSON-like string with keys and string values properly quoted.
String extractStringMap(String input) {
  String content = input.trim();
  if (content.startsWith('{') && content.endsWith('}')) {
    content = content.substring(1, content.length - 1);
  }

  final keyValues = content
      .split(RegExp(r'\s*(,|\n)\s*'))
      .where((keyValue) => keyValue.isNotEmpty);

  final keyValuePairs = keyValues.map((keyValue) {
    final key = (keyValue.split(':')[0]).trim();
    var value = keyValue.split(':')[1].trim();

    // Check if value is true or false

    if (bool.tryParse(value) != null) {
      value = bool.parse(value).toString();
    } else if (int.tryParse(value) != null) {
      value = int.parse(value).toString();
    } else if (double.tryParse(value) != null) {
      value = double.parse(value).toString();
    } else {
      value = _addQuotesIfNeeded(value);
    }

    return '${_addQuotesIfNeeded(key)}: $value';
  });

  return '{${keyValuePairs.join(', ')}}';
}

String _addQuotesIfNeeded(String value) {
  if (!value.startsWith('"') && !value.endsWith('"')) {
    value = '"$value"';
  }

  return value;
}
