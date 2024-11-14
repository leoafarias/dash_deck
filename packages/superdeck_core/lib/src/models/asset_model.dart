import 'package:dart_mappable/dart_mappable.dart';
import 'package:path/path.dart' as p;
import 'package:superdeck_core/src/schema/schema.dart';

part 'asset_model.mapper.dart';

@MappableClass()
final class AssetModel with AssetModelMappable {
  final String path;
  final int width;
  final int height;
  final String? reference;
  AssetModel({
    required this.path,
    required this.width,
    required this.height,
    required this.reference,
  });

  String get extension => p.extension(path);

  bool get isPortrait => height >= width;

  bool get isLandscape => !isPortrait;

  double get aspectRatio => width / height;

  static final schema = SchemaShape(
    {
      "path": Schema.string.required(),
      "width": Schema.integer.required(),
      "height": Schema.integer.required(),
      "reference": Schema.string.optional(),
    },
    additionalProperties: true,
  );

  static AssetModel fromMap(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return AssetModelMapper.fromMap(map);
  }
}
