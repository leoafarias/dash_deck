import 'dart:convert';

import 'package:superdeck_cli/src/parsers/base_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:yaml/yaml.dart';

typedef MarkdownExtraction = ({
  String contents,
  Map<String, dynamic> frontMatter,
  String key,
});

class FrontMatterParser extends Parser<MarkdownExtraction> {
  @override
  MarkdownExtraction parse(String input) {
    final key = assetHash(input);
    final regex = RegExp(
      r'^---.*\r?\n([\s\S]*?)---',
      multiLine: true,
    );
    final match = regex.firstMatch(input);
    if (match == null) {
      // get everything after the second `---`
      final contents = input.split('---').last;
      return (
        contents: contents.trim(),
        frontMatter: {},
        key: key,
      );
    }

    final yamlString = match.group(1);
    final markdownContent = input.replaceFirst(match.group(0)!, '');

    final yamlMap = loadYaml(yamlString!) as YamlMap?;

    return (
      contents: markdownContent.trim(),
      frontMatter: yamlMap == null ? {} : jsonDecode(jsonEncode(yamlMap)),
      key: key,
    );
  }
}

String serializeYamlFrontmatter(Map<String, dynamic> data) {
  final yamlString = jsonEncode(data);
  return '---\n$yamlString---\n';
}
