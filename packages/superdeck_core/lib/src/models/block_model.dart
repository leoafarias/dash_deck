import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../helpers/mappers.dart';

part 'block_model.mapper.dart';

@MappableClass(
  discriminatorKey: 'type',
)
sealed class Block with BlockMappable {
  final String type;
  final ContentAlignment? align;
  final int flex;
  final bool scrollable;
  Block({
    required this.type,
    this.align,
    this.flex = 1,
    this.scrollable = false,
  });

  static final schema = Schema.object(
    name: 'Block',
    {
      'type': Schema.string(),
      'align': Schema.enumValue(ContentAlignment.values),
      'flex': Schema.int(),
      'scrollable': Schema.boolean(),
    },
    required: ['type'],
    additionalProperties: true,
  );

  static Block parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return BlockMapper.fromMap(map);
  }

  static final typeSchema = DiscriminatedObjectSchema(
    name: 'BlockDiscriminator',
    discriminatorKey: 'type',
    schemas: {
      ColumnBlock.key: ColumnBlock.schema,
      DartPadBlock.key: DartPadBlock.schema,
      WidgetBlock.key: WidgetBlock.schema,
      ImageBlock.key: ImageBlock.schema,
    },
  );
}

@MappableClass(
  includeCustomMappers: [NullIfEmptyBlock()],
  discriminatorValue: SectionBlock.key,
)
class SectionBlock extends Block with SectionBlockMappable {
  final List<Block> blocks;

  static const key = 'section';

  SectionBlock(
    this.blocks, {
    super.align,
    super.flex,
    super.scrollable,
  }) : super(type: key);

  int get totalBlockFlex {
    return blocks.fold(0, (total, block) => total + block.flex);
  }

  SectionBlock appendText(String content) {
    final lastPart = blocks.lastOrNull;
    final blocksCopy = [...blocks];

    if (lastPart is ColumnBlock) {
      blocksCopy.last = lastPart.copyWith(
        content: lastPart.content.isEmpty
            ? content
            : '${lastPart.content}\n$content',
      );
    } else {
      if (content.trim().isNotEmpty) {
        blocksCopy.add(
          ColumnBlock(content),
        );
      }
    }

    return copyWith(blocks: blocksCopy);
  }

  static SectionBlock text(String content) {
    return SectionBlock([ColumnBlock(content)]);
  }

  static final schema = Block.schema.extend(
    name: 'SectionBlock',
    {
      'blocks': Schema.list(Block.typeSchema),
    },
  );

  SectionBlock appendBlock(Block part) {
    return copyWith(blocks: [...blocks, part]);
  }
}

@MappableClass(discriminatorValue: ColumnBlock.key)
class ColumnBlock extends Block with ColumnBlockMappable {
  static const key = 'column';
  final String content;
  ColumnBlock(
    this.content, {
    super.align,
    super.flex,
    super.scrollable,
  }) : super(type: key);

  static final schema = Block.schema.extend(
    name: 'ColumnBlock',
    {
      'content': Schema.string(),
    },
  );
}

@MappableEnum()
enum DartPadTheme {
  dark,
  light;
}

@MappableClass(discriminatorValue: DartPadBlock.key)
class DartPadBlock extends Block with DartPadBlockMappable {
  final String id;
  final DartPadTheme? theme;
  final bool embed;
  final String code;

  static const key = 'dartpad';

  DartPadBlock({
    required this.id,
    this.theme,
    required this.code,
    this.embed = true,
    super.align,
    super.flex,
    super.scrollable,
  }) : super(type: key);

  static final schema = Block.schema.extend(
    name: 'DartPadBlock',
    {
      'id': Schema.string(),
      'theme': Schema.enumValue(DartPadTheme.values),
      'embed': Schema.boolean(),
      'code': Schema.string(),
    },
    required: [
      "id",
    ],
  );
}

@MappableClass(discriminatorValue: ImageBlock.key)
class ImageBlock extends Block with ImageBlockMappable {
  static const key = 'image';
  final GeneratedAsset asset;
  final ImageFit? fit;
  final double? width;
  final double? height;
  ImageBlock({
    required this.asset,
    this.fit,
    this.width,
    this.height,
    super.align,
    super.flex,
    super.scrollable,
  }) : super(type: key);

  static final schema = Block.schema.extend(
    name: 'ImageBlock',
    {
      "fit": Schema.enumValue(ImageFit.values),
      "asset": GeneratedAsset.schema,
      "width": Schema.double(),
      "height": Schema.double(),
    },
    required: [
      "asset",
    ],
  );
}

@MappableEnum()
enum ImageFit {
  fill,
  contain,
  cover,
  fitWidth,
  fitHeight,
  none,
  scaleDown;
}

@MappableClass(
  discriminatorValue: WidgetBlock.key,
  hook: UnmappedPropertiesHook('args'),
)
class WidgetBlock extends Block with WidgetBlockMappable {
  static const key = 'widget';
  final Map<String, dynamic> args;
  final String name;
  @override
  WidgetBlock({
    required this.name,
    this.args = const {},
    super.align,
    super.flex,
    super.scrollable,
  }) : super(type: key);

  static final schema = Block.schema.extend(
    name: 'WidgetBlock',
    {
      "name": Schema.string(),
    },
    required: [
      "name",
    ],
    additionalProperties: true,
  );
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

extension StringColumnExt on String {
  ColumnBlock column() => ColumnBlock(this);
}

extension BlockExt on Block {
  Block alignCenter() => copyWith(align: ContentAlignment.center);
  Block alignCenterLeft() => copyWith(align: ContentAlignment.centerLeft);
  Block alignCenterRight() => copyWith(align: ContentAlignment.centerRight);
  Block alignTopLeft() => copyWith(align: ContentAlignment.topLeft);
  Block alignTopCenter() => copyWith(align: ContentAlignment.topCenter);
  Block alignTopRight() => copyWith(align: ContentAlignment.topRight);
  Block alignBottomLeft() => copyWith(align: ContentAlignment.bottomLeft);
  Block alignBottomCenter() => copyWith(align: ContentAlignment.bottomCenter);
  Block alignBottomRight() => copyWith(align: ContentAlignment.bottomRight);

  Block flex(int flex) => copyWith(flex: flex);
  Block scrollable([bool scrollable = true]) =>
      copyWith(scrollable: scrollable);
}
