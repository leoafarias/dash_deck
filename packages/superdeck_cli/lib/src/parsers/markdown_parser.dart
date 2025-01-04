import 'dart:convert';

import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:yaml/yaml.dart';

class RawSlide {
  String key;
  String markdown;
  Map<String, dynamic> options;
  List<String> comments;

  RawSlide({
    required this.key,
    required this.markdown,
    required this.options,
    required this.comments,
  });
}

class MarkdownParser {
  const MarkdownParser._();
  static List<RawSlide> parse(String markdown) {
    final slidesRaw = _splitSlides(markdown);

    final slides = <RawSlide>[];

    for (var slide in slidesRaw) {
      slides.add(_parseSlide(slide));
    }

    return slidesRaw.map(_parseSlide).toList();
  }

  /// Splits the entire markdown into slides.
  ///
  /// A "slide" is defined by frontmatter sections delimited with `---`.
  /// Code blocks (fenced by ```) are respected, so `---` inside a code block
  /// won't be treated as frontmatter delimiters.
  static List<String> _splitSlides(String content) {
    content = content.trim();
    final lines = LineSplitter().convert(content);
    final slides = <String>[];
    final buffer = StringBuffer();
    bool insideFrontMatter = false;

    var isCodeBlock = false;

    for (var line in lines) {
      final trimmed = line.trim();
      if (trimmed.startsWith('```')) {
        isCodeBlock = !isCodeBlock;
      }
      if (isCodeBlock) {
        buffer.writeln(line);
        continue;
      }

      if (insideFrontMatter && trimmed.isEmpty) {
        insideFrontMatter = false;
      }

      if (trimmed == '---') {
        if (!insideFrontMatter) {
          if (buffer.isNotEmpty) {
            slides.add(buffer.toString().trim());
            buffer.clear();
          }
        }
        insideFrontMatter = !insideFrontMatter;
      }
      buffer.writeln(line);
    }

    if (buffer.isNotEmpty) {
      slides.add(buffer.toString());
    }

    return slides;
  }

  static RawSlide _parseSlide(String input) {
    final key = LocalAsset.buildKey(input);

    final (frontMatter, markdownContent) = _extractFrontmatter(input);
    final notes = _extractComments(markdownContent);

    return RawSlide(
      key: key,
      markdown: markdownContent.trim(),
      options: frontMatter ?? {},
      comments: notes,
    );
  }

  static List<String> _extractComments(String markdown) {
    final comments = <String>[];
    final _commentRegex = RegExp(r'<!--(.*?)-->', dotAll: true);
    for (final match in _commentRegex.allMatches(markdown)) {
      final comment = match.group(1)?.trim();
      if (comment != null) {
        comments.add(comment);
      }
    }

    return comments;
  }

  /// Extracts frontmatter from the input slide.
  /// Returns a tuple: (yamlMap, remainingMarkdown).
  /// If no frontmatter is found, returns (null, entireInputAfterSecondDelimiterIfPresent).
  static (Map<String, dynamic>?, String) _extractFrontmatter(String input) {
    final _frontmatterRegex = RegExp(
      r'^---.*\r?\n([\s\S]*?)\r?\n---',
      multiLine: true,
    );

    final match = _frontmatterRegex.firstMatch(input);
    if (match == null) {
      // No frontmatter found
      final contents = input.split('---').last;

      return (null, contents);
    }

    final yamlString = match.group(1);

    final markdownContent = input.replaceFirst(match.group(0)!, '');
    Map<String, dynamic>? yamlMap;

    if (yamlString != null) {
      try {
        final parsed = loadYaml(yamlString);
        if (parsed is YamlMap) {
          yamlMap = jsonDecode(jsonEncode(parsed)) as Map<String, dynamic>?;
        } else if (parsed is String) {
          yamlMap = {'$parsed': null} as Map<String, dynamic>?;
        }
      } catch (e) {
        logger.err('Cannot parse yaml frontmatter: $e');
        yamlMap = {};
      }
    }

    return (yamlMap, markdownContent);
  }

  String serializeYamlFrontmatter(Map<String, dynamic> data) {
    final yamlString = jsonEncode(data);

    return '---\n$yamlString---\n';
  }
}
