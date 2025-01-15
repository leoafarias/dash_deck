import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'asset_model.mapper.dart';

@MappableClass(discriminatorKey: 'type')
abstract class Asset with AssetMappable {
  final String src;
  final String type;

  Asset({
    required this.src,
    required this.type,
  });

  static final schema = Schema.object(
    {
      "src": Schema.string(),
      "type": Schema.string(),
    },
    required: [
      "src",
      "type",
    ],
  );

  static final typeSchema = DiscriminatedObjectSchema(
    discriminatorKey: 'type',
    schemas: {
      'thumbnail': SlideThumbnailAsset.schema,
      'mermaid': MermaidAsset.schema,
      'cache_remote': CacheRemoteAsset.schema,
      'remote': RemoteAsset.schema,
    },
  );

  Asset fromMap(Map<String, dynamic> map) {
    typeSchema.validateOrThrow(map);
    return AssetMapper.fromMap(map);
  }
}

@MappableClass(discriminatorValue: 'remote')
class RemoteAsset extends Asset with RemoteAssetMappable {
  RemoteAsset({
    required super.src,
    required super.type,
  });

  factory RemoteAsset.fromUrl(String url) {
    return RemoteAsset(
      src: url,
      type: 'remote',
    );
  }

  static final schema = Asset.schema;
}

@MappableClass()
sealed class LocalAsset extends Asset with LocalAssetMappable {
  final String fileName;
  final AssetExtension extension;

  LocalAsset({
    required this.fileName,
    required this.extension,
    required super.type,
  }) : super(src: '${type}_$fileName.${extension.name}');

  static String buildKey(String valueToHash) => generateValueHash(valueToHash);

  String get path => src;

  static final schema = Asset.schema.extend(
    {
      "file_name": Schema.string(),
      "extension": AssetExtension.schema,
      "key": Schema.string(),
    },
    required: [
      "file_name",
      "extension",
      "key",
    ],
  );
}

@MappableClass()
sealed class GeneratedAsset extends LocalAsset with GeneratedAssetMappable {
  final String key;

  GeneratedAsset({
    required this.key,
    required super.fileName,
    required super.extension,
    required super.type,
  });
}

@MappableClass(discriminatorValue: 'thumbnail')
class SlideThumbnailAsset extends GeneratedAsset
    with SlideThumbnailAssetMappable {
  SlideThumbnailAsset({
    required super.key,
    required super.fileName,
    required super.extension,
  }) : super(type: 'thumbnail');

  factory SlideThumbnailAsset.fromSlideKey(String slideKey) {
    return SlideThumbnailAsset(
      key: slideKey,
      fileName: slideKey,
      extension: AssetExtension.png,
    );
  }

  static final schema = LocalAsset.schema.extend({});
}

@MappableClass(discriminatorValue: 'mermaid')
class MermaidAsset extends GeneratedAsset with MermaidAssetMappable {
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
      extension: AssetExtension.png,
    );
  }

  static final schema = LocalAsset.schema.extend({});
}

@MappableClass(discriminatorValue: 'cache_remote')
class CacheRemoteAsset extends GeneratedAsset with CacheRemoteAssetMappable {
  @MappableConstructor()
  CacheRemoteAsset({
    required super.key,
    required super.fileName,
    required super.extension,
  }) : super(type: 'cache_remote');

  factory CacheRemoteAsset.fromUrl(String url) {
    return CacheRemoteAsset(
      key: url,
      fileName: LocalAsset.buildKey(url),
      extension: AssetExtension.png,
    );
  }

  static final schema = LocalAsset.schema.extend({});
}
