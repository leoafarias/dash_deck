import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:superdeck_core/superdeck_core.dart';

List<SectionBlock> parseSections(String markdown) {
  final lines = LineSplitter().convert(markdown);
  var sections = <SectionBlock>[];

  SectionBlock? currentSection;
  var index = 0;

  while (index < lines.length) {
    var line = lines[index];
    final trimmedLine = line.trim();

    if (trimmedLine.startsWith('{@')) {
      // Start of a tag, read until we find the closing '}'
      var tagContent = line;
      while (!tagContent.trim().endsWith('}')) {
        index++;
        if (index >= lines.length) {
          throw Exception('Unclosed tag in markdown');
        }
        tagContent += '\n${lines[index]}';
      }

      // Process the tagContent
      final tagData = extractTagsFromLine(tagContent);

      final blocks = tagData.map(
        (data) => Block.parse(data.blockType, data.options),
      );

      for (final block in blocks) {
        if (block is SectionBlock) {
          // Add the previous section to the list
          if (currentSection != null) {
            sections.add(currentSection);
          }
          // Start a new section
          currentSection = block;
        } else if (block is ColumnBlock) {
          // Add a new subsection to the current section
          currentSection ??= SectionBlock();
          currentSection = currentSection.appendContent(block);
        }
      }
    } else {
      currentSection ??= SectionBlock();

      currentSection = currentSection.appendLine(line);
    }
    index++;
  }

  // Add the last section to the list
  if (currentSection != null) {
    sections.add(currentSection);
  }

  return sections;
}

typedef SyntaxTagData = ({
  BlockType blockType,
  Map<String, dynamic> options,
});

List<SyntaxTagData> extractTagsFromLine(String tagContent) {
  // Parse tags from the line
  final tagRegex = RegExp(r'{@(\w+)(.*?)}', dotAll: true);
  final matches = tagRegex.allMatches(tagContent);

  if (matches.isEmpty) {
    throw Exception('Invalid tag format');
  }

  return matches.map((match) {
    final blockTypeStr = match.group(1);
    var rawOptions = match.group(2) ?? '';

    var blockType = _getBlockType(blockTypeStr!);

    var options = convertYamlToMap(rawOptions);

    // If there is no block treat it as a widget
    if (blockType == null) {
      blockType = BlockType.widget;
      if (options['type'] != null) {
        throw Exception(
          '$blockTypeStr cannot have a property named "type", as it is reserved property.',
        );
      }
      options = {...options, 'name': blockTypeStr};
    }

    return (blockType: blockType, options: options);
  }).toList();
}

BlockType? _getBlockType(String blockTypeStr) {
  return BlockType.values.firstWhereOrNull(
    (e) => e.name == blockTypeStr,
  );
}

// final _imageMarkdownRegex =
//     RegExp(r'!\[(.*?)\]\((.*?)\)(?:\s*\{\.([^\}]+)\})?');

// ImageBlock? parseImageBlock(String markdown) {
//   final match = _imageMarkdownRegex.firstMatch(markdown);
//   if (match == null) {
//     return null;
//   }

//   final url = match.group(2)!;

//   return ImageBlock(
//     src: url,
//   );
// }
