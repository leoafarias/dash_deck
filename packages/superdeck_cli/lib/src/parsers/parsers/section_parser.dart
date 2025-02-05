import 'package:superdeck_cli/src/parsers/parsers/base_parser.dart';
import 'package:superdeck_cli/src/parsers/parsers/block_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

class SectionParser extends BaseParser<List<SectionBlock>> {
  const SectionParser();

  @override
  List<SectionBlock> parse(String content) {
    final sections = <SectionBlock>[];
    SectionBlock? currentSection;

    final tagBlocks = parseTagBlocks(content);
    final tagBlockContents = List.generate(tagBlocks.length, (index) => '');

    // If there are no tag blocks, we can just add the entire markdown as a single section.
    if (tagBlocks.isEmpty) {
      currentSection = SectionBlock();
      currentSection = currentSection.appendText(content);
      sections.add(currentSection);

      return sections;
    }

    // If the first tag block is not at the start of the markdown,
    // we need to add a new section for the content before the first tag block.
    if (tagBlocks.first.startIndex > 0) {
      currentSection = SectionBlock();
      currentSection = currentSection
          .appendText(content.substring(0, tagBlocks.first.startIndex));
    }

    // Extract the content between each tag block.
    for (var idx = 0; idx < tagBlocks.length; idx++) {
      final block = tagBlocks[idx];
      if (idx == tagBlocks.length - 1) {
        tagBlockContents[idx] = content.substring(block.endIndex).trim();
      } else {
        final nextBlock = tagBlocks[idx + 1];

        tagBlockContents[idx] =
            content.substring(block.endIndex, nextBlock.startIndex).trim();
      }
    }

    // Parse the tag blocks into elements.
    for (var idx = 0; idx < tagBlocks.length; idx++) {
      final tag = tagBlocks[idx];

      final block = Block.parse(tag.options);

      final content = tagBlockContents[idx];

      if (block is SectionBlock) {
        // If we encounter a new SectionBlock, close off the previous one first.
        if (currentSection != null) {
          sections.add(currentSection);
        }
        currentSection = block;
      } else {
        currentSection ??= SectionBlock();
        currentSection = currentSection.appendBlock(block);
      }

      if (content.isNotEmpty) {
        currentSection = currentSection.appendText(content);
      }
    }

    // If we ended with an open section, add it to the sections list.
    if (currentSection != null) {
      sections.add(currentSection);
    }

    return sections;
  }
}
