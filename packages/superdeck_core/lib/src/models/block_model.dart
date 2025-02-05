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
    {
      'type': Schema.string(),
      'align': Schema.enumValue(ContentAlignment.values),
      'flex': Schema.int(),
      'scrollable': Schema.boolean(),
    },
    required: ['type'],
  );

  static Block parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return BlockMapper.fromMap(map);
  }

  static final typeSchema = DiscriminatedObjectSchema(
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

  SectionBlock({
    this.blocks = const [],
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
          ColumnBlock(content: content),
        );
      }
    }

    return copyWith(blocks: blocksCopy);
  }

  static SectionBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return SectionBlockMapper.fromMap(map);
  }

  static final schema = Block.schema.extend(
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
  ColumnBlock({
    this.content = '',
    super.align,
    super.flex,
    super.scrollable,
  }) : super(type: key);

  static ColumnBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return ColumnBlockMapper.fromMap(map);
  }

  static final schema = Block.schema.extend(
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

  static DartPadBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return DartPadBlockMapper.fromMap(map);
  }
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

  static ImageBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return ImageBlockMapper.fromMap(map);
  }
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
    {
      "name": Schema.string(),
    },
    required: [
      "name",
    ],
    additionalProperties: true,
  );

  static WidgetBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return WidgetBlockMapper.fromMap(map);
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
