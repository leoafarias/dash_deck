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
  image,
  thumnail,
  mermaid,
}

@MappableClass()
class GeneratedAsset with GeneratedAssetMappable {
  final String fileName;
  final AssetExtension extension;
  final AssetType type;

  GeneratedAsset._({
    required this.fileName,
    required this.extension,
    required this.type,
  });

  String get src => '${type.name}_$fileName.${extension.name}';

  static String buildKey(String valueToHash) => generateValueHash(valueToHash);

  String get path => src;

  static final schema = Schema.object(
    {
      "file_name": Schema.string(),
      "extension": AssetExtension.schema,
      "type": Schema.enumValue(AssetType.values),
    },
    required: [
      "file_name",
      "extension",
      "type",
    ],
  );

  static GeneratedAsset parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return GeneratedAssetMapper.fromMap(map);
  }

  factory GeneratedAsset.thumbnail(String slideKey) {
    return GeneratedAsset._(
      fileName: slideKey,
      extension: AssetExtension.png,
      type: AssetType.thumnail,
    );
  }

  factory GeneratedAsset.mermaid(String syntax) {
    return GeneratedAsset._(
      fileName: GeneratedAsset.buildKey(syntax),
      extension: AssetExtension.png,
      type: AssetType.mermaid,
    );
  }

  factory GeneratedAsset.image(String url, AssetExtension extension) {
    return GeneratedAsset._(
      fileName: GeneratedAsset.buildKey(url),
      extension: extension,
      type: AssetType.image,
    );
  }
}
