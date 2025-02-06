import 'package:superdeck_cli/src/parsers/parsers/base_parser.dart';
import 'package:superdeck_cli/src/parsers/parsers/block_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

class SectionParser extends BaseParser<List<SectionBlock>> {
  const SectionParser();

  @override
  List<SectionBlock> parse(String content) {
    final parsedBlocks = const BlockParser().parse(content);

    // If there are no tag blocks, we can just add the entire markdown as a single section.
    if (parsedBlocks.isEmpty) {
      return [SectionBlock.text(content)];
    }

    final aggregator = _SectionAggregator();

    for (var idx = 0; idx < parsedBlocks.length; idx++) {
      final parsedBlock = parsedBlocks[idx];
      final isFirst = idx == 0;
      final isLast = idx == parsedBlocks.length - 1;

      final startIndex = parsedBlock.startIndex;
      final endIndex = parsedBlock.endIndex;

      String blockContent;
      // If the first tag block is not at the start of the markdown,
      // we need to add a new section for the content before the first tag block.
      if (isFirst && startIndex > 0) {
        blockContent = content.substring(0, startIndex);
      } else if (isLast) {
        blockContent = content.substring(endIndex).trim();
      } else {
        final nextBlock = parsedBlocks[idx + 1];
        blockContent = content.substring(endIndex, nextBlock.startIndex);
      }

      final block = Block.parse(parsedBlock.data);

      aggregator
        ..addBlock(block)
        ..addContent(blockContent);
    }

    // print(aggregator.sections);

    return aggregator.sections;
  }
}

class _SectionAggregator {
  List<SectionBlock> sections = [];

  _SectionAggregator();

  SectionBlock _getSection() {
    if (sections.isEmpty) {
      sections.add(SectionBlock([]));
    }

    return sections.last;
  }

  void addContent(String content) {
    final section = _getSection();
    final block = section.blocks.lastOrNull;
    final blocks = [...section.blocks];

    if (content.trim().isEmpty) {
      return;
    }

    if (block is ColumnBlock) {
      final newContent =
          block.content.isEmpty ? content : '${block.content}\n$content';

      blocks.last = block.copyWith(content: newContent);
    } else {
      blocks.add(ColumnBlock(content));
    }

    sections.last = section.copyWith(blocks: blocks);
  }

  void addBlock(Block block) {
    if (block is SectionBlock) {
      sections.add(block);
    } else {
      final lastSection = _getSection();
      final blocks = [...lastSection.blocks, block];

      sections.last = lastSection.copyWith(blocks: blocks);
    }
  }
}
