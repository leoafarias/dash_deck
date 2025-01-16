import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/src/helpers/mappers.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'block_model.mapper.dart';

@MappableClass()
abstract class LayoutElement with LayoutElementMappable {
  final ContentAlignment? align;
  final int? flex;
  final bool scrollable;

  LayoutElement({
    this.flex,
    this.align,
    this.scrollable = false,
  });

  LayoutElement merge(LayoutElement? other) {
    if (other == null) return this;
    return copyWith.$merge(other);
  }

  static final schema = Schema.object(
    {
      "align": Schema.enumValue(ContentAlignment.values),
      "flex": Schema.int(),
      "scrollable": Schema.boolean(),
    },
  );
}

@MappableClass(
  includeCustomMappers: [NullIfEmptyBlock()],
)
class SectionElement extends LayoutElement with SectionElementMappable {
  final List<BlockElement> blocks;

  static const key = 'section';

  SectionElement({
    this.blocks = const [],
    super.flex,
    super.align,
  });

  SectionElement appendText(String content) {
    final lastPart = blocks.lastOrNull;
    final blocksCopy = [...blocks];

    if (lastPart is ContentElement) {
      blocksCopy.last = lastPart.copyWith(
        content: lastPart.content.isEmpty
            ? content
            : '${lastPart.content}\n$content',
      );
    } else {
      if (content.trim().isNotEmpty) {
        blocksCopy.add(
          ContentElement(content),
        );
      }
    }

    return copyWith(blocks: blocksCopy);
  }

  static SectionElement parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return SectionElementMapper.fromMap(map);
  }

  static final schema = LayoutElement.schema.extend({
    'blocks': Schema.list(BlockElement.typeSchema),
  });

  SectionElement appendElement(BlockElement part) {
    return copyWith(blocks: [...blocks, part]);
  }
}

@MappableEnum()
enum ContentAlignment {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight;
}
