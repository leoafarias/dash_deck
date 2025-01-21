import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_core/superdeck_core.dart';

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

    final Map<String, dynamic> optionsMap =
        options.isNotEmpty ? extractStringMap(options) : {};

    parsedBlocks.add(ParsedFencedCode(
      options: optionsMap,
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
  final tagRegex = RegExp(r'(?<!\S)@(\w+)(?:\s*{([^{}]*)})?');

  final matches = tagRegex.allMatches(text);
  List<ParsedTagBlock> parsedBlocks = [];
  try {
    for (final match in matches) {
      final tag = match.group(1) ?? '';
      final options = match.group(2) ?? '';

      final startIndex = match.start;
      final endIndex = match.end;

      final optionsMap = convertYamlToMap(options);

      parsedBlocks.add(ParsedTagBlock(
        tag: tag,
        options: optionsMap,
        startIndex: startIndex,
        endIndex: endIndex,
      ));
    }

    return parsedBlocks;
  } catch (e) {
    logger.err('Failed to parse tag blocks: $e');
    // print(text);

    return [];
  }
}

/// Transforms a string of the format `{key1: value1, key2: value2}`
/// into a JSON-like string with keys and string values properly quoted.
Map<String, dynamic> extractStringMap(String input) {
  String content = input.trim();
  if (content.startsWith('{') && content.endsWith('}')) {
    content = content.substring(1, content.length - 1);
  }

  // input will be valus like
  // Boolean examples
  // example 1: showLineNumbers=true
  // output 1: {showLineNumbers: true}
  // example 2: showLineNumbers=false
  // output 2: {showLineNumbers: false}
  // example 3: showLineNumbers // this equals to true
  // output 3: {showLineNumbers: true}
  // example 4: showLineNumbers="true"
  // output 4: {showLineNumbers: true}
  // example 5: showLineNumbers="false"
  // output 5: {showLineNumbers: false}

  // String examples
  // example 1: fileName="example.dart"
  // output 1: {fileName: "example.dart"}
  // example 2: anotherOption="another_example.dart"
  // output 2: {anotherOption: "another_example.dart"}

  // List examples
  // example 1: options=["option1", "option2", "option3"]
  // output 1: {options: ["option1", "option2", "option3"]}
  // example 2: otherOptions=["option1", "option2"]
  // output 2: {otherOptions: ["option1", "option2"]}
  // example 3: lines=[1, 2-3]
  // output 3: {lines: ["1", "2-3"]}

  return {};
}
