import 'package:petitparser/petitparser.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_core/superdeck_core.dart';

typedef ExtractedFrontmatter = ({
  Map<String, dynamic> frontmatter,
  String? contents,
});

class FrontmatterParser {
  const FrontmatterParser();

  Parser _createFrontmatterParser() {
    final delimiter = string('---').trim();
    final yamlContent = any().starLazy(delimiter).flatten();
    final markdownContent = any().star().flatten();

    return (delimiter & yamlContent & delimiter & markdownContent).end();
  }

  ExtractedFrontmatter extract(String content) {
    final parser = _createFrontmatterParser();
    final result = parser.parse(content);

    if (result is Failure) {
      // No frontmatter found
      final contents = content.split('---').last;

      return (frontmatter: {}, contents: contents);
    }

    final yamlString = result.value[1] as String?;
    final markdownContent = result.value[2] as String;
    Map<String, dynamic> yamlMap = {};

    if (yamlString != null) {
      try {
        yamlMap = convertYamlToMap(yamlString);
      } catch (e) {
        logger.err('Cannot parse yaml frontmatter: $e');
        yamlMap = {};
      }
    }

    return (frontmatter: yamlMap, contents: markdownContent);
  }
}
