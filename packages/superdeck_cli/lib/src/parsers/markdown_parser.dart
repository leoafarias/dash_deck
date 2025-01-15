import 'dart:async';
import 'dart:convert';

import 'package:superdeck_cli/src/parsers/extractors/block_extractor.dart';
import 'package:superdeck_cli/src/parsers/extractors/comment_extractor.dart';
import 'package:superdeck_cli/src/parsers/extractors/front_matter_extractor.dart';
import 'package:superdeck_core/superdeck_core.dart';

/// Responsible for splitting the entire markdown into separate slides,
/// extracting front matter, and capturing comments.
class MarkdownParser {
  final List<BlockTransformer> transformers;
  final FrontmatterExtractor frontmatterExtractor;
  final CommentExtractor commentExtractor;
  final BlockExtractor blockExtractor;

  const MarkdownParser({
    required this.transformers,
    required this.frontmatterExtractor,
    required this.commentExtractor,
    required this.blockExtractor,
  });

  /// Example logic to split slides on `---` lines, while ignoring code fences.
  List<String> _splitSlides(List<String> lines) {
    final slides = <String>[];
    final buffer = <String>[];

    bool insideCodeFence = false;

    for (final line in lines) {
      if (_isCodeFence(line)) {
        insideCodeFence = !insideCodeFence;
      }
      // If we see '---' outside a code fence, that might indicate a new slide
      if (line.trim() == '---' && !insideCodeFence) {
        if (buffer.isNotEmpty) {
          slides.add(buffer.join('\n'));
          buffer.clear();
        }
      } else {
        buffer.add(line);
      }
    }

    // Add the last slide if any remains
    if (buffer.isNotEmpty) {
      slides.add(buffer.join('\n'));
    }

    return slides;
  }

  String _removeFrontmatter(String content, String? extracted) {
    if (extracted == null || extracted.isEmpty) return content;

    // A naive example: just replace the extracted front matter portion with ''
    return content.replaceFirst(extracted, '');
  }

  String _generateKey(String slideContent) {
    return slideContent.hashCode.toString();
  }

  Future<List<Slide>> parse(String markdown) async {
    final lines = LineSplitter().convert(markdown);
    final rawSlides = _splitSlides(lines);

    final slides = <Slide>[];

    for (final rawSlide in rawSlides) {
      // 1) Extract front matter
      final frontmatter = frontmatterExtractor.parseFrontmatter(rawSlide);
      // 2) Remove the front matter from the raw markdown
      var stripped = _removeFrontmatter(rawSlide, frontmatter.extractedText);

      // 3) Extract comments
      final comments = commentExtractor.parseComments(stripped);

      for (final transformer in transformers) {
        stripped = await transformer.transform(stripped);
      }

      // 4) Parse sections
      final sections = blockExtractor.parse(stripped);

      // 4) Generate a key (this is just a placeholder)
      final key = _generateKey(rawSlide);

      slides.add(
        Slide(
          key: key,
          options: SlideOptions.fromMap(frontmatter.options),
          markdown: stripped.trim(),
          sections: sections,
          comments: comments,
        ),
      );
    }

    return slides;
  }
}

bool _isCodeFence(String line) {
  return line.trim().startsWith('```');
}

abstract interface class BlockTransformer {
  FutureOr<String> transform(String markdown);
}
