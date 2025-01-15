import 'package:yaml/yaml.dart';

typedef ExtractedFrontmatter = ({
  Map<String, dynamic> options,
  String? extractedText,
});

/// Simple interface for frontmatter extraction
abstract class FrontmatterExtractor {
  ExtractedFrontmatter parseFrontmatter(String content);
}

class YamlFrontmatterExtractorImpl implements FrontmatterExtractor {
  const YamlFrontmatterExtractorImpl();
  @override
  ExtractedFrontmatter parseFrontmatter(String content) {
    // Regex to find '---' then YAML until '---'
    final regex = RegExp(r'^---\s*([\s\S]*?)\s*---', multiLine: true);
    final match = regex.firstMatch(content);

    if (match == null) {
      // No frontmatter
      return (options: {}, extractedText: null);
    }

    final rawYaml = match.group(1);
    if (rawYaml == null) {
      return (options: {}, extractedText: null);
    }

    // Parse the YAML
    try {
      final doc = loadYaml(rawYaml);
      final map = (doc is YamlMap)
          ? Map<String, dynamic>.from(doc)
          : <String, dynamic>{};

      return (
        options: map,
        extractedText: match.group(0), // entire matched frontmatter block
      );
    } catch (e) {
      // On error, just return empty
      return (options: {}, extractedText: match.group(0));
    }
  }
}
