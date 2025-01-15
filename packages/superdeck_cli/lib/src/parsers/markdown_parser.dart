import 'dart:convert';

import 'package:superdeck_cli/src/parsers/extractors/block_extractor.dart';
import 'package:superdeck_cli/src/parsers/extractors/comment_extractor.dart';
import 'package:superdeck_cli/src/parsers/extractors/front_matter_extractor.dart';
import 'package:superdeck_core/superdeck_core.dart';

/// Responsible for splitting the entire markdown into separate slides,
/// extracting front matter, and capturing comments.
class MarkdownParser {
  final IFrontmatterExtractor frontmatterExtractor;
  final ICommentExtractor commentExtractor;
  final IBlockExtractor blockExtractor;

  const MarkdownParser({
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

  List<Slide> parse(String markdown) {
    final lines = LineSplitter().convert(markdown);
    final slidesRawContent = _splitSlides(lines);

    final slides = <Slide>[];

    for (final slideContent in slidesRawContent) {
      // 1) Extract front matter
      final frontmatter = frontmatterExtractor.parseFrontmatter(slideContent);
      // 2) Remove the front matter from the raw markdown
      final stripped =
          _removeFrontmatter(slideContent, frontmatter.extractedText);

      // 3) Extract comments
      final comments = commentExtractor.parseComments(stripped);

      // 4) Parse sections
      final sections = blockExtractor.parse(stripped);

      // 4) Generate a key (this is just a placeholder)
      final key = _generateKey(slideContent);

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

abstract interface class IBlockParser<T extends Block> {
  T parse(String markdown);
}
