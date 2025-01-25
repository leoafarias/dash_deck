import 'package:superdeck_cli/src/parsers/parsers/block_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

LayoutElement _parseElement(ParsedTagBlock tagBlock) {
  final options = tagBlock.options;

  return switch (tagBlock.tag) {
    (SectionElement.key) => SectionElement.parse(options),
    (ContentElement.key) =>
      ContentElement.parse({...options, 'type': tagBlock.tag, 'content': ''}),
    (ImageElement.key) =>
      ImageElement.parse({...options, 'type': tagBlock.tag}),
    (DartPadElement.key) =>
      DartPadElement.parse({...options, 'type': tagBlock.tag}),
    _ => WidgetElement.parse(
        {...options, 'name': tagBlock.tag, 'type': WidgetElement.key},
      ),
  };
}

/// Parses a markdown string into a list of SectionBlocks.
///
/// This function reads through each line of the given [markdown]. Normal lines
/// are appended to the current section. Lines that start with `{@` are treated
/// as "tag blocks" and can define new sections or nested blocks.
///
/// If a tag is found, it reads until a closing `}` is encountered, then converts
/// the extracted tags into blocks, updating the current section or starting a
/// new one as needed.
List<SectionElement> parseSections(String markdown) {
  final sections = <SectionElement>[];
  SectionElement? currentSection;

  final tagBlocks = parseTagBlocks(markdown);
  final tagBlockContents = List.generate(tagBlocks.length, (index) => '');

  // If there are no tag blocks, we can just add the entire markdown as a single section.
  if (tagBlocks.isEmpty) {
    currentSection = SectionElement();
    currentSection = currentSection.appendText(markdown);
    sections.add(currentSection);

    return sections;
  }

  // If the first tag block is not at the start of the markdown,
  // we need to add a new section for the content before the first tag block.
  if (tagBlocks.first.startIndex > 0) {
    currentSection = SectionElement();
    currentSection = currentSection
        .appendText(markdown.substring(0, tagBlocks.first.startIndex));
  }

  // Extract the content between each tag block.
  for (var idx = 0; idx < tagBlocks.length; idx++) {
    final block = tagBlocks[idx];
    if (idx == tagBlocks.length - 1) {
      tagBlockContents[idx] = markdown.substring(block.endIndex).trim();
    } else {
      final nextBlock = tagBlocks[idx + 1];

      tagBlockContents[idx] =
          markdown.substring(block.endIndex, nextBlock.startIndex).trim();
    }
  }

  // Parse the tag blocks into elements.
  for (var idx = 0; idx < tagBlocks.length; idx++) {
    final tag = tagBlocks[idx];
    final element = _parseElement(tag);

    final content = tagBlockContents[idx];

    if (element is SectionElement) {
      // If we encounter a new SectionBlock, close off the previous one first.
      if (currentSection != null) {
        sections.add(currentSection);
      }
      currentSection = element;
    } else if (element is BlockElement) {
      currentSection ??= SectionElement();
      currentSection = currentSection.appendElement(element);
    }

    if (content.isNotEmpty) {
      currentSection = currentSection!.appendText(content);
    }
  }

  // If we ended with an open section, add it to the sections list.
  if (currentSection != null) {
    sections.add(currentSection);
  }

  return sections;
}
