import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_core/superdeck_core.dart';

import 'base_parser.dart';

final _codeFencePattern = RegExp(
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

class FencedCodeParser extends BaseParser<List<ParsedFencedCode>> {
  const FencedCodeParser();

  @override
  List<ParsedFencedCode> parse(String text) {
    final matches = _codeFencePattern.allMatches(text);
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

      print('options: $options');

      final Map<String, dynamic> optionsMap =
          options.isNotEmpty ? YamlUtils.convertYamlToMap(options) : {};

      parsedBlocks.add(
        ParsedFencedCode(
          options: optionsMap,
          language: language,
          content: content.trim(),
          startIndex: startIndex,
          endIndex: endIndex,
        ),
      );
    }

    return parsedBlocks;
  }
}

class ParsedTagBlock {
  final String tag;
  final int startIndex;
  final int endIndex;
  final Map<String, dynamic> _options;

  const ParsedTagBlock({
    required this.tag,
    required Map<String, dynamic> options,
    required this.startIndex,
    required this.endIndex,
  }) : _options = options;

  Map<String, dynamic> get options {
    final keys = [
      SectionBlock.key,
      ColumnBlock.key,
      ImageBlock.key,
      DartPadBlock.key,
      WidgetBlock.key,
    ];

    if (!keys.contains(tag)) {
      return {..._options, 'name': tag, 'type': WidgetBlock.key};
    }

    return {..._options, 'type': tag};
  }
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

      parsedBlocks.add(
        ParsedTagBlock(
          tag: tag,
          options: YamlUtils.convertYamlToMap(options),
          startIndex: startIndex,
          endIndex: endIndex,
        ),
      );
    }

    return parsedBlocks;
  } catch (e) {
    logger.err('Failed to parse tag blocks: $e');
    // print(text);

    return [];
  }
}
