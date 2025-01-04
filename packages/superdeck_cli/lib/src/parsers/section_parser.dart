import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:superdeck_core/superdeck_core.dart';

/// Parses a markdown string into a list of SectionBlocks.
///
/// This function reads through each line of the given [markdown]. Normal lines
/// are appended to the current section. Lines that start with `{@` are treated
/// as "tag blocks" and can define new sections or nested blocks.
///
/// If a tag is found, it reads until a closing `}` is encountered, then converts
/// the extracted tags into blocks, updating the current section or starting a
/// new one as needed.
List<SectionBlock> parseSections(String markdown) {
  final lines = LineSplitter().convert(markdown);
  final sections = <SectionBlock>[];
  SectionBlock? currentSection;

  // Use a for loop instead of a while loop with manual index increments
  // This reduces complexity and off-by-one error risks.
  for (var i = 0; i < lines.length; i++) {
    final blockContent = _readBlockContent(lines, i);

    if (blockContent != null) {
      final blocks = blockContent.blocks;
      i = blockContent.endIndex;

      // Process the extracted tag content into blocks
      // Integrate these blocks into the current section/sections list
      for (final block in blocks) {
        if (block is SectionBlock) {
          // If we encounter a new SectionBlock, close off the previous one first.
          if (currentSection != null) {
            sections.add(currentSection);
          }
          currentSection = block;
        } else if (block is ColumnBlock) {
          // If we have a ColumnBlock, treat it as content in the current section.
          currentSection ??= SectionBlock();
          currentSection = currentSection.appendContent(block);
        }
      }
    } else {
      final line = lines[i];
      // Normal text line, just append to the current section.
      currentSection ??= SectionBlock();
      currentSection = currentSection.appendLine(line);
    }
  }

  // If we ended with an open section, add it to the sections list.
  if (currentSection != null) {
    sections.add(currentSection);
  }

  return sections;
}

/// A record representing the result of reading tag content.
/// `content` is the full tag content, `newIndex` is the updated line index
/// after reading the tag content.
class _ReadBlockTag {
  final List<Block> blocks;
  final int endIndex;
  const _ReadBlockTag(this.blocks, this.endIndex);
}

/// Reads a tag block starting from [startIndex] in the [lines].
///
/// A tag block starts with `{@` and ends when a line's trimmed content ends
/// with `}`. This function accumulates all relevant lines until the tag is closed.
///
/// Throws a [FormatException] if the tag is never properly closed.
_ReadBlockTag? _readBlockContent(List<String> lines, int startIndex) {
  final line = lines[startIndex];
  final trimmedLine = line.trim();
  if (!trimmedLine.startsWith('{@')) {
    return null;
  }
  var content = line;
  var i = startIndex;

  // Keep reading until we find a line that ends with '}'
  while (!content.trim().endsWith('}')) {
    i++;
    if (i >= lines.length) {
      throw FormatException(
        'Unclosed tag in markdown starting at line $startIndex.',
      );
    }
    content += '\n${lines[i]}';
  }
  final tagData = extractTagContents(content);

  final blocks =
      tagData.map((data) => Block.parse(data.blockType, data.options)).toList();

  return _ReadBlockTag(blocks, i);
}

typedef SyntaxTagData = ({BlockType blockType, Map<String, dynamic> options});

/// Extracts tag definitions from a single tag content block.
///
/// Tags are expected to follow the pattern `{@BlockType options...}`.
/// This function uses a regex to capture `BlockType` and the raw options,
/// then converts the raw options from YAML to a map. If the block type is
/// not recognized, it defaults to a widget block.
///
/// Throws a [FormatException] if no tags are found or if the tag format is invalid.
List<SyntaxTagData> extractTagContents(String tagContent) {
  final tagRegex = RegExp(r'{@(\w+)(.*?)}', dotAll: true);
  final matches = tagRegex.allMatches(tagContent);

  if (matches.isEmpty) {
    throw FormatException(
      'Invalid tag format: No tags found in "${tagContent.trim()}".',
    );
  }

  return matches.map((match) {
    final blockTypeStr = match.group(1);
    var rawOptions = match.group(2) ?? '';

    var blockType = _getBlockType(blockTypeStr!);
    Map<String, dynamic> options;
    try {
      options = convertYamlToMap(rawOptions);
    } catch (e, stackTrace) {
      Error.throwWithStackTrace(
        FormatException(
          'Cannot parse options for "$blockTypeStr": $rawOptions',
        ),
        stackTrace,
      );
    }

    // If the blockType isn't recognized, treat it as a widget.
    if (blockType == null) {
      blockType = BlockType.widget;
      // Validate that 'type' is not used, as it's reserved.
      if (options['type'] != null) {
        throw FormatException(
          'Invalid options for "$blockTypeStr": "type" is a reserved property.',
        );
      }
      // Add the 'name' property to identify the widget.
      options = {...options, 'name': blockTypeStr};

      return (blockType: BlockType.widget, options: options);
    }

    return (blockType: blockType, options: options);
  }).toList();
}

/// Attempts to find a [BlockType] enum value matching [blockTypeStr].
///
/// If no matching block type is found, returns null. This allows graceful fallback
/// to a widget block type later.
BlockType? _getBlockType(String blockTypeStr) {
  return BlockType.values.firstWhereOrNull((e) => e.name == blockTypeStr);
}
