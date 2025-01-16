import 'dart:convert';

import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:yaml/yaml.dart';

typedef ExtractedFrontmatter = ({
  Map<String, dynamic> frontmatter,
  String? contents,
});

class FrontmatterParser {
  const FrontmatterParser();

  ExtractedFrontmatter extract(String content) {
    /// Extracts frontmatter from the input slide.
    /// Returns a tuple: (yamlMap, remainingMarkdown).
    /// If no frontmatter is found, returns (null, entireInputAfterSecondDelimiterIfPresent).

    final _frontmatterRegex = RegExp(
      r'^---.*\r?\n([\s\S]*?)\r?\n---',
      multiLine: true,
    );

    final match = _frontmatterRegex.firstMatch(content);
    if (match == null) {
      // No frontmatter found
      final contents = content.split('---').last;

      return (frontmatter: {}, contents: contents);
    }

    final yamlString = match.group(1);

    final markdownContent = content.replaceFirst(match.group(0)!, '');
    Map<String, dynamic> yamlMap = {};

    if (yamlString != null) {
      try {
        final parsed = loadYaml(yamlString);
        if (parsed is YamlMap) {
          yamlMap = jsonDecode(jsonEncode(parsed)) as Map<String, dynamic>;
        } else if (parsed is String) {
          yamlMap = {'$parsed': null} as Map<String, dynamic>;
        }
      } catch (e) {
        logger.err('Cannot parse yaml frontmatter: $e');
        yamlMap = {};
      }
    }

    return (frontmatter: yamlMap, contents: markdownContent);
  }
}
