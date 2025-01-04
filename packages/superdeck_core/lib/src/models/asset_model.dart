import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'asset_model.mapper.dart';

@MappableClass(discriminatorKey: 'type')
sealed class LocalAsset with LocalAssetMappable {
  final String key;
  final String fileName;
  final LocalAssetExtension extension;
  final String type;

  LocalAsset({
    required this.fileName,
    required this.extension,
    required this.key,
    required this.type,
  });

  static String buildKey(String valueToHash) => generateValueHash(valueToHash);
  String get path => '${type}_$fileName.${extension.name}';

  static final schema = Schema.object(
    {
      "file_name": Schema.string(),
      "extension": LocalAssetExtension.schema,
      "key": Schema.string(),
      "type": Schema.string(),
    },
    required: [
      "file_name",
      "extension",
      "key",
      "type",
    ],
  );

  static final typeSchema = DiscriminatedObjectSchema(
    discriminatorKey: 'type',
    schemas: {
      'thumbnail': SlideThumbnailAsset.schema,
      'mermaid': MermaidAsset.schema,
      'remote': CacheRemoteAsset.schema,
    },
  );

  LocalAsset fromMap(Map<String, dynamic> map) {
    typeSchema.validateOrThrow(map);
    return LocalAssetMapper.fromMap(map);
  }
}

@MappableClass(discriminatorValue: 'thumbnail')
class SlideThumbnailAsset extends LocalAsset with SlideThumbnailAssetMappable {
  SlideThumbnailAsset({
    required super.key,
    required super.fileName,
    required super.extension,
  }) : super(type: 'thumbnail');

  factory SlideThumbnailAsset.fromSlideKey(String slideKey) {
    return SlideThumbnailAsset(
      key: slideKey,
      fileName: slideKey,
      extension: LocalAssetExtension.png,
    );
  }

  static final schema = LocalAsset.schema.extend({});
}

@MappableClass(discriminatorValue: 'mermaid')
class MermaidAsset extends LocalAsset with MermaidAssetMappable {
  @MappableConstructor()
  MermaidAsset({
    required super.key,
    required super.fileName,
    required super.extension,
  }) : super(type: 'mermaid');

  factory MermaidAsset.fromSyntax(String mermaidSyntax) {
    final key = LocalAsset.buildKey(mermaidSyntax);
    return MermaidAsset(
      key: key,
      fileName: key,
      extension: LocalAssetExtension.png,
    );
  }

  static final schema = LocalAsset.schema.extend({});
}

@MappableClass(discriminatorValue: 'remote')
class CacheRemoteAsset extends LocalAsset with CacheRemoteAssetMappable {
  @MappableConstructor()
  CacheRemoteAsset({
    required super.key,
    required super.fileName,
    required super.extension,
  }) : super(type: 'remote');

  factory CacheRemoteAsset.fromUrl(String url) {
    return CacheRemoteAsset(
      key: url,
      fileName: LocalAsset.buildKey(url),
      extension: LocalAssetExtension.png,
    );
  }

  static final schema = LocalAsset.schema.extend({});
}

@MappableEnum()
enum LocalAssetExtension {
  png,
  jpeg,
  gif,
  webp,
  svg;

  static final schema = Schema.enumValue(values);

  static LocalAssetExtension? tryParse(String value) {
    final extension = value.toLowerCase();

    if (extension == 'jpg') {
      return LocalAssetExtension.jpeg;
    }
    return LocalAssetExtension.values
        .firstWhereOrNull((e) => e.name == extension);
  }
}
