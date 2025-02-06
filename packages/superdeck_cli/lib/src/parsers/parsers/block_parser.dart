import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_core/superdeck_core.dart';

import 'base_parser.dart';

class ParsedBlock {
  final String type;
  final int startIndex;
  final int endIndex;
  final Map<String, dynamic> _data;

  const ParsedBlock({
    required this.type,
    required Map<String, dynamic> data,
    required this.startIndex,
    required this.endIndex,
  }) : _data = data;

  Map<String, dynamic> get data {
    final keys = [
      SectionBlock.key,
      ColumnBlock.key,
      ImageBlock.key,
      DartPadBlock.key,
      WidgetBlock.key,
    ];

    return !keys.contains(type)
        ? {..._data, 'name': type, 'type': WidgetBlock.key}
        : {..._data, 'type': type};
  }
}

class BlockParser extends BaseParser<List<ParsedBlock>> {
  const BlockParser();

  @override
  List<ParsedBlock> parse(String text) {
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

    try {
      return matches.map((match) {
        final type = match.group(1) ?? '';
        final options = match.group(2) ?? '';

        return ParsedBlock(
          type: type,
          data: YamlUtils.convertYamlToMap(options),
          startIndex: match.start,
          endIndex: match.end,
        );
      }).toList();
    } catch (e) {
      logger.err('Failed to parse tag blocks: $e');

      return [];
    }
  }
}
