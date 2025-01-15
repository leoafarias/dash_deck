import 'dart:convert';

import 'package:superdeck_core/superdeck_core.dart';
import 'package:yaml/yaml.dart';

/// Each block parser should implement how it transforms "options" into a concrete Block.
abstract interface class BlockExtractor {
  List<SectionBlock> parse(String markdown);
}

/// Parses the body markdown of a RawSlide, detecting lines like `{@BlockType ...}`
/// to create structured SectionBlocks with nested child blocks.
class BlockExtractorImpl implements BlockExtractor {
  final BlockExtractorRegistry registry;

  const BlockExtractorImpl({required this.registry});

  /// Checks if the line is a block tag starting with '{@' and ending with '}'.
  bool _isBlockTag(String line) {
    return line.startsWith('{@') && line.endsWith('}');
  }

  /// Parses the markdown and returns a list of SectionBlocks with nested blocks.
  List<SectionBlock> parse(String markdown) {
    final lines = LineSplitter().convert(markdown);
    final sections = <SectionBlock>[];
    SectionBlock? currentSection;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();

      final block = registry.parseBlock(line);

      if (block != null) {
        if (block is SectionBlock) {
          if (currentSection != null) {
            sections.add(currentSection);
          }
          currentSection = block;
        } else if (block is ContentBlock) {
          currentSection ??= SectionBlock();
          currentSection.appendContent(block);
        }
      } else {
        if (line.isNotEmpty) {
          currentSection ??= SectionBlock();
          currentSection.appendLine(line);
        }
      }
    }

    if (currentSection != null) {
      sections.add(currentSection);
    }

    return sections;
  }
}

/// Custom exception for invalid block formats.
class InvalidBlockFormatException implements Exception {
  final String message;

  const InvalidBlockFormatException(this.message);

  @override
  String toString() => 'InvalidBlockFormatException: $message';
}

typedef BlockCreator = Block Function(Map<String, dynamic> options);

class BlockExtractorRegistry {
  final Map<String, BlockCreator> _creators = {};

  BlockExtractorRegistry() {
    register('section', (opts) => SectionBlock.parse(opts));
    register('column', (opts) => ContentBlock.parse(opts));
    register('image', (opts) => LocalAssetBlock.parse(opts));
    register('widget', (opts) => WidgetBlock.parse(opts));
    register('dart_code', (opts) => DartCodeBlock.parse(opts));
  }

  void register(String blockType, BlockCreator creator) {
    _creators[blockType.toLowerCase()] = creator;
  }

  Block? parseBlock(String line) {
    if (!_isBlockTag(line)) {
      return null;
    }

    final (blockType, options) = _extractBlockTypeAndOptions(line);
    final creator = _creators[blockType.toLowerCase()];
    if (creator == null) {
      // fallback or "WidgetBlock" approach
      // e.g. return WidgetBlock(name: blockType, options: options);
      throw Exception('Unknown block type: $blockType');
    }

    return creator(options);
  }
}

bool _isBlockTag(String line) {
  return line.startsWith('{@') && line.endsWith('}');
}

/// Extracts the block type and options from a tag line.
///
/// Example: '{@section key:value foo:bar}' -> ('section', {'key': 'value', 'foo': 'bar'})
(String, Map<String, dynamic>) _extractBlockTypeAndOptions(String tagLine) {
  final tagRegex = RegExp(r'{@(\w+)\s*([^}]*)}');
  final match = tagRegex.firstMatch(tagLine);

  if (match == null) {
    throw InvalidBlockFormatException('Invalid tag format: $tagLine');
  }

  final blockType = match.group(1)!;
  final optionsStr = match.group(2)!;

  final options = <String, dynamic>{};
  if (optionsStr.isNotEmpty) {
    try {
      final yamlOptions = loadYaml(optionsStr);
      if (yamlOptions is YamlMap) {
        options.addAll(Map<String, dynamic>.from(yamlOptions));
      }
    } catch (_) {
      // Fallback to simple key:value parsing
      final pairs = optionsStr.split(RegExp(r'\s+'));
      for (final pair in pairs) {
        if (pair.contains(':')) {
          final kv = pair.split(':');
          if (kv.length == 2) {
            options[kv[0].trim()] = kv[1].trim();
          }
        }
      }
    }
  }

  return (blockType, options);
}
