import 'package:petitparser/petitparser.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/parsers/parsers/base_parser.dart';
import 'package:superdeck_cli/src/parsers/parsers/grammar_definitions.dart';
import 'package:superdeck_core/superdeck_core.dart';

typedef ExtractedFrontmatter = ({
  Map<String, dynamic> frontmatter,
  String? contents,
});

class FrontmatterParser extends BaseParser<ExtractedFrontmatter> {
  const FrontmatterParser();

  ExtractedFrontmatter parse(String content) {
    final parser = const FrontMatterGrammarDefinition()
        .build<FrontMatterGrammarDefinitionResult>();
    final result = parser.parse(content);

    if (result is Failure) {
      throw FormatException(result.message, content, result.position);
    }

    final yamlString = result.value.yaml;
    final markdownContent = result.value.markdown;
    Map<String, dynamic> yamlMap = {};

    try {
      yamlMap = YamlUtils.convertYamlToMap(yamlString);
    } catch (e) {
      logger.err('Cannot parse yaml frontmatter: $e');
      yamlMap = {};
    }

    return (frontmatter: yamlMap, contents: markdownContent);
  }
}
