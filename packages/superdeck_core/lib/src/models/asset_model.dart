import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'asset_model.mapper.dart';

@MappableEnum()
enum AssetExtension {
  png,
  jpeg,
  gif,
  webp,
  svg;

  static final schema = Schema.enumValue(values);

  static AssetExtension? tryParse(String value) {
    final extension = value.toLowerCase();

    if (extension == 'jpg') {
      return AssetExtension.jpeg;
    }
    return AssetExtension.values.firstWhereOrNull((e) => e.name == extension);
  }
}

@MappableEnum()
enum AssetType {
  remote,
  local,
  slideThumbnail,
  mermaidImage,
  cacheRemoteImage,
}

@MappableClass(discriminatorKey: 'type')
abstract class Asset with AssetMappable {
  final String src;
  final AssetType type;

  Asset({
    required this.src,
    required this.type,
  });

  static final schema = Schema.object(
    {
      "src": Schema.string(),
      "type": Schema.enumValue(AssetType.values),
    },
    required: [
      "src",
      "type",
    ],
  );
}

@MappableClass()
class LocalAsset extends Asset with LocalAssetMappable {
  final String fileName;
  final AssetExtension extension;

  LocalAsset._({
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

  static LocalAsset parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return LocalAssetMapper.fromMap(map);
  }

  factory LocalAsset.thumbnail(String slideKey) {
    return LocalAsset._(
      fileName: slideKey,
      extension: AssetExtension.png,
      type: AssetType.slideThumbnail,
    );
  }

  factory LocalAsset.mermaidGraph(String syntax) {
    return LocalAsset._(
      fileName: syntax,
      extension: AssetExtension.png,
      type: AssetType.mermaidImage,
    );
  }

  factory LocalAsset.cacheRemote(String url) {
    return LocalAsset._(
      fileName: LocalAsset.buildKey(url),
      extension: AssetExtension.png,
      type: AssetType.cacheRemoteImage,
    );
  }
}
