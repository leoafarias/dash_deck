import 'package:dart_mappable/dart_mappable.dart';
import 'package:path/path.dart' as p;
import 'package:superdeck_core/src/schema/schema.dart';

part 'asset_model.mapper.dart';

@MappableClass()
final class Asset with AssetMappable {
  final String path;
  final int width;
  final int height;
  final String? reference;
  Asset({
    required this.path,
    required this.width,
    required this.height,
    required this.reference,
  });

  String get extension => p.extension(path);

  bool get isPortrait => height >= width;

  bool get isLandscape => !isPortrait;

  double get aspectRatio => width / height;

  Uri get uri => Uri.parse(path);

  static final schema = Schema.object(
    {
      "path": Schema.string.required(),
      "width": Schema.int.required(),
      "height": Schema.int.required(),
      "reference": Schema.string.optional(),
    },
    additionalProperties: true,
  );

  static Asset fromMap(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return AssetMapper.fromMap(map);
  }
}
