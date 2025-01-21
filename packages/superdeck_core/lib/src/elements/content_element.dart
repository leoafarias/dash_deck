import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'content_element.mapper.dart';

@MappableClass()
sealed class BlockElement extends LayoutElement with BlockElementMappable {
  final String type;

  BlockElement({
    required this.type,
    super.flex,
    super.align,
    super.scrollable,
  });

  static final schema = LayoutElement.schema.extend(
    {
      'type': Schema.string(),
    },
    required: ['type'],
  );

  static final typeSchema = DiscriminatedObjectSchema(
    discriminatorKey: 'type',
    schemas: {
      ContentElement.key: ContentElement.schema,
      DartPadElement.key: DartPadElement.schema,
      AssetElement.key: AssetElement.schema,
      WidgetElement.key: WidgetElement.schema,
    },
  );
}

@MappableClass()
class ContentElement extends BlockElement with ContentElementMappable {
  static const key = 'column';
  final String content;
  ContentElement(
    this.content, {
    super.flex,
    super.align,
    super.scrollable,
  }) : super(type: key);

  static ContentElement parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return ContentElementMapper.fromMap(map);
  }

  static final schema = BlockElement.schema.extend(
    {
      'content': Schema.string(),
    },
    required: ['content'],
  );
}

@MappableEnum()
enum DartPadTheme {
  dark,
  light;

  static final schema = Schema.enumValue(values);
}

@MappableClass()
class DartPadElement extends BlockElement with DartPadElementMappable {
  final String id;
  final DartPadTheme? theme;
  final bool embed;
  final String code;

  static const key = 'dart_pad';

  DartPadElement({
    required this.id,
    this.theme,
    super.flex,
    required this.code,
    super.align,
    this.embed = true,
    super.scrollable,
  }) : super(type: key);

  static final schema = BlockElement.schema.extend(
    {
      'id': Schema.string(),
      'theme': DartPadTheme.schema,
      'embed': Schema.boolean(),
    },
    required: [
      "id",
    ],
  );

  static DartPadElement parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return DartPadElementMapper.fromMap(map);
  }
}

@MappableClass()
class AssetElement extends BlockElement with AssetElementMappable {
  static const key = 'asset';
  final Asset asset;
  final ImageFit? fit;
  final double? width;
  final double? height;
  AssetElement({
    required this.asset,
    this.fit,
    this.width,
    this.height,
    super.flex,
    super.align,
    super.scrollable,
  }) : super(type: key);

  static final schema = BlockElement.schema.extend(
    {
      "fit": Schema.enumValue(ImageFit.values),
      "asset": Asset.schema,
      "width": Schema.double(),
      "height": Schema.double(),
    },
    required: [
      "asset",
    ],
  );

  static AssetElement parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return AssetElementMapper.fromMap(map);
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
  hook: UnmappedPropertiesHook('args'),
)
class WidgetElement extends BlockElement with WidgetElementMappable {
  static const key = 'widget';
  final Map<String, dynamic> args;
  final String name;
  @override
  WidgetElement({
    required this.name,
    this.args = const {},
    super.flex,
    super.align,
    super.scrollable,
  }) : super(type: key);

  static final schema = BlockElement.schema.extend(
    {
      "name": Schema.string(),
    },
    required: [
      "name",
    ],
    additionalProperties: true,
  );

  static WidgetElement parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return WidgetElementMapper.fromMap(map);
  }
}
