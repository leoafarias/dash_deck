import 'dart:convert';

import 'package:superdeck_cli/src/parsers/slide_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:yaml/yaml.dart';

class MarkdownParser {
  static List<SlideRaw> parse(String markdown) {
    final slidesRaw = _splitSlides(markdown);
    return slidesRaw.map(_parseSlide).toList();
  }

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

  static SlideRaw _parseSlide(String input) {
    final key = assetHash(input);
    final regex = RegExp(
      r'^---.*\r?\n([\s\S]*?)---',
      multiLine: true,
    );
    final match = regex.firstMatch(input);
    if (match == null) {
      // get everything after the second `---`
      final contents = input.split('---').last;
      return SlideRaw(
        markdown: contents.trim(),
        frontMatter: {},
        key: key,
      );
    }

    final yamlString = match.group(1);
    final markdownContent = input.replaceFirst(match.group(0)!, '');

    final yamlMap = loadYaml(yamlString!) as YamlMap?;

    return SlideRaw(
      markdown: markdownContent.trim(),
      frontMatter: yamlMap == null ? {} : jsonDecode(jsonEncode(yamlMap)),
      key: key,
    );
  }
}

String serializeYamlFrontmatter(Map<String, dynamic> data) {
  final yamlString = jsonEncode(data);
  return '---\n$yamlString---\n';
}
