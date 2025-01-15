import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/src/helpers/uuid_v4.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'block_model.mapper.dart';

@MappableEnum()
enum BlockType {
  section,
  content,
  local_image,
  remote_image,
  widget,
  dartCode,
  mermaid;

  static final schema = Schema.enumValue(values);
}

@MappableClass(discriminatorKey: 'type')
abstract class Block with BlockMappable {
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

  static final schema = Schema.object(
    {
      "type": BlockType.schema,
      "align": ContentAlignment.schema,
      "flex": Schema.int(),
      "scrollable": Schema.boolean(),
    },
  );
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

    if (lastPart is ContentBlock) {
      blocksCopy.last = lastPart.copyWith(
        content: lastPart.content.isEmpty
            ? content
            : '${lastPart.content}\n$content',
      );
    } else {
      if (content.trim().isNotEmpty) {
        blocksCopy.add(
          ContentBlock(
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
    'blocks': Schema.list(ContentBlock.typeSchema),
  });

  SectionBlock appendContent(ContentBlock part) {
    return copyWith(blocks: [...blocks, part]);
  }
}

@MappableClass(discriminatorValue: 'content')
class ContentBlock extends Block with ContentBlockMappable {
  final String? _content;
  final bool scrollable;

  ContentBlock({
    String? content,
    super.flex,
    super.align,
    super.type = BlockType.content,
    this.scrollable = false,
  }) : _content = content;

  String get content => _content ?? '';

  static final schema = Block.schema.extend({
    'content': Schema.string(),
    'scrollable': Schema.boolean(),
  });

  static ContentBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return ContentBlockMapper.fromMap(map);
  }

  static final typeSchema = DiscriminatedObjectSchema(
    discriminatorKey: 'type',
    schemas: {
      BlockType.content.name: ContentBlock.schema,
      BlockType.widget.name: WidgetBlock.schema,
      BlockType.local_image.name: LocalImageBlock.schema,
      BlockType.remote_image.name: RemoteImageBlock.schema,
      BlockType.mermaid.name: MermaidBlock.schema,
      BlockType.dartCode.name: DartCodeBlock.schema,
    },
  );
}

@MappableClass()
abstract class ImageBlock extends ContentBlock with ImageBlockMappable {
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
    required super.type,
  });

  static final schema = ContentBlock.schema.extend(
    {
      "fit": ImageFit.schema,
      "src": Schema.string(),
      "width": Schema.double(),
      "height": Schema.double(),
    },
    required: [
      "src",
    ],
  );
}

@MappableClass(discriminatorValue: 'local_image')
class LocalImageBlock extends ImageBlock with LocalImageBlockMappable {
  LocalImageBlock({
    required super.src,
    super.fit,
    super.width,
    super.height,
    super.flex,
    super.align,
    super.content,
    super.scrollable,
  }) : super(type: BlockType.local_image);

  static LocalImageBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);

    return LocalImageBlockMapper.fromMap(map);
  }

  static final schema = ImageBlock.schema;
}

@MappableClass(discriminatorValue: 'remote_image')
class RemoteImageBlock extends ImageBlock with RemoteImageBlockMappable {
  RemoteImageBlock({
    required super.src,
    super.fit,
    super.width,
    super.height,
    super.flex,
    super.align,
    super.content,
    required super.scrollable,
  }) : super(type: BlockType.remote_image);

  static final schema = ImageBlock.schema;
}

@MappableClass(discriminatorValue: 'mermaid')
class MermaidBlock extends ImageBlock with MermaidBlockMappable {
  final String syntax;

  MermaidBlock({
    required this.syntax,
    required super.src,
    required super.fit,
    required super.width,
    required super.height,
    required super.flex,
    required super.align,
    required super.content,
    required super.scrollable,
  }) : super(type: BlockType.mermaid);

  static final schema = ImageBlock.schema.extend({
    "syntax": Schema.string(),
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
enum DartPadTheme {
  dark,
  light;

  static final schema = Schema.enumValue(values);
}

@MappableClass(discriminatorValue: 'dart_code')
class DartCodeBlock extends ContentBlock with DartCodeBlockMappable {
  final String id;
  final DartPadTheme? theme;
  final bool embed;

  DartCodeBlock({
    required this.id,
    this.theme,
    super.flex,
    super.content,
    super.align,
    this.embed = true,
    super.scrollable,
  }) : super(type: BlockType.dartCode);

  static DartCodeBlock parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return DartCodeBlockMapper.fromMap(map);
  }

  static final schema = ContentBlock.schema.extend(
    {
      'id': Schema.string(),
      'theme': DartPadTheme.schema,
      'embed': Schema.boolean(),
    },
    required: [
      "id",
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

  static final schema = Schema.enumValue(values);
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

  static final schema = Schema.enumValue(values);
}
