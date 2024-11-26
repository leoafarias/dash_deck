import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/src/helpers/uuid_v4.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'block_model.mapper.dart';

@MappableEnum()
enum BlockType {
  section,
  column,
  image,
  widget,
  dartpad,
}

@MappableClass(discriminatorKey: 'type')
sealed class Block with BlockMappable {
  final ContentAlignment? align;
  final int? flex;
  final BlockType type;
  late final String key;
  Block({
    this.flex,
    this.align,
    required this.type,
  }) {
    key = uuidV4();
  }

  Block merge(Block? other) {
    if (other == null) return this;
    return copyWith.$merge(other);
  }

  static parse(BlockType type, Map<String, dynamic> map) {
    return switch (type) {
      BlockType.column => ColumnBlock.parse(map),
      BlockType.image => ImageBlock.parse(map),
      BlockType.widget => WidgetBlock.parse(map),
      BlockType.section => SectionBlock.parse(map),
      BlockType.dartpad => DartPadBlock.parse(map),
    };
  }

  static final schema = Schema.object({
    "align": ContentAlignment.schema.optional(),
    "flex": Schema.int.optional(),
    "scrollable": Schema.boolean.optional(),
  });
}

class NullIfEmptyBlock extends SimpleMapper<Block> {
  const NullIfEmptyBlock();

  @override
  Block decode(dynamic value) {
    return ContentBlockMapper.fromMap(value);
  }

  @override
  dynamic encode(Block self) {
    final map = self.toMap();
    if (map.isEmpty) {
      return null;
    }
    return map;
  }
}

@MappableClass(
  discriminatorValue: 'section',
  includeCustomMappers: [NullIfEmptyBlock()],
)
class SectionBlock extends Block with SectionBlockMappable {
  final List<ContentBlock> blocks;

  SectionBlock({
    this.blocks = const [],
    super.flex,
    super.align,
  }) : super(type: BlockType.section);

  SectionBlock appendLine(String content) {
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
          ColumnBlock(
            content: content,
          ),
        );
      }
    }

    return copyWith(blocks: blocksCopy);
  }

  static SectionBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return SectionBlockMapper.fromMap(map);
  }

  static final schema = Block.schema.extend({
    'blocks': Schema.list(ContentBlock.typeSchema).optional(),
  });

  SectionBlock appendContent(ContentBlock part) {
    return copyWith(blocks: [...blocks, part]);
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class ContentBlock extends Block with ContentBlockMappable {
  final String? _content;
  final bool scrollable;

  ContentBlock({
    String? content,
    super.flex,
    super.align,
    required super.type,
    this.scrollable = false,
  }) : _content = content;

  String get content => _content ?? '';

  static final schema = Block.schema.extend({
    'content': Schema.string.optional(),
    'scrollable': Schema.boolean.optional(),
  });

  static final typeSchema = DiscriminatorSchema(
    baseSchema: schema,
    discriminatorKey: 'type',
    schemas: {
      BlockType.column.name: ColumnBlock.schema,
      BlockType.widget.name: WidgetBlock.schema,
      BlockType.image.name: ImageBlock.schema,
      BlockType.dartpad.name: DartPadBlock.schema,
    },
  );
}

@MappableClass(discriminatorValue: MappableClass.useAsDefault)
class ColumnBlock extends ContentBlock with ColumnBlockMappable {
  ColumnBlock({
    super.flex,
    super.align,
    super.content,
    super.scrollable,
  }) : super(type: BlockType.column);

  static final schema = ContentBlock.schema;

  static ColumnBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return ColumnBlockMapper.fromMap(map);
  }
}

@MappableClass(discriminatorValue: 'image')
class ImageBlock extends ContentBlock with ImageBlockMappable {
  final String src;
  final ImageFit? fit;
  final double? width;
  final double? height;

  ImageBlock({
    required this.src,
    this.fit,
    this.width,
    this.height,
    super.flex,
    super.align,
    super.content,
    super.scrollable,
  }) : super(type: BlockType.image);

  static ImageBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    print(map);
    return ImageBlockMapper.fromMap(map);
  }

  static final schema = ContentBlock.schema.extend({
    "fit": ImageFit.schema,
    "src": Schema.string.required(),
    "width": Schema.double.optional(),
    "height": Schema.double.optional(),
  });
}

@MappableClass(
  discriminatorValue: 'widget',
  hook: UnmappedPropertiesHook('args'),
)
class WidgetBlock extends ContentBlock with WidgetBlockMappable {
  final String name;
  final Map<String, dynamic> args;

  @override
  WidgetBlock({
    required this.name,
    this.args = const {},
    super.flex,
    super.align,
    super.content,
    super.scrollable,
  }) : super(type: BlockType.widget);

  static WidgetBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return WidgetBlockMapper.fromMap(map);
  }

  static final schema = ContentBlock.schema.extend(
    {"name": Schema.string.required()},
    additionalProperties: true,
  );
}

@MappableEnum()
enum DartPadTheme {
  dark,
  light;

  static final schema = Schema.string.isEnum(values);
}

@MappableClass()
class DartPadBlock extends ContentBlock with DartPadBlockMappable {
  final String id;
  final DartPadTheme? theme;
  final bool embed;

  DartPadBlock({
    required this.id,
    this.theme,
    super.flex,
    super.content,
    super.align,
    this.embed = true,
    super.scrollable,
  }) : super(type: BlockType.dartpad);

  static DartPadBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return DartPadBlockMapper.fromMap(map);
  }

  static final schema = ContentBlock.schema.extend({
    'id': Schema.string.required(),
    'theme': DartPadTheme.schema.optional(),
    'embed': Schema.boolean.optional(),
  });
}

typedef Decoder<T> = T Function(Map<String, dynamic>);

T mapDecoder<T>(Map<String, dynamic> args) {
  return args as T;
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

  static final schema = Schema.string.isEnum(values);
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

  static final schema = Schema.string.isEnum(values);
}

extension on SchemaValue<String> {
  SchemaValue<String> isEnum<T extends Enum>(List<T> values) {
    return copyWith(validators: [
      ...validators,
      ArrayValidator(values.map((e) => e.name.snakeCase()).toList()),
    ]);
  }
}
