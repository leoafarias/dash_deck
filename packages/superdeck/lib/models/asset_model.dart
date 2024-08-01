import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:path/path.dart' as p;

import '../helpers/mappers.dart';

part 'asset_model.mapper.dart';

@MappableEnum()
enum AssetFileType {
  png,
  jpg,
  jpeg,
  gif,
  webp;

  static AssetFileType parse(String value) {
    return values.firstWhereOrNull((e) => e.name == value) ??
        (throw Exception('Invalid file type: $value'));
  }

  static AssetFileType? tryParse(String value) {
    return values.firstWhereOrNull((e) => value.startsWith(e.name));
  }

  bool isPng() => this == AssetFileType.png;

  bool isJpg() => this == AssetFileType.jpg || this == AssetFileType.jpeg;

  bool isGif() => this == AssetFileType.gif;
}

@MappableEnum()
enum SlideAssetType {
  cached,
  thumb,
  mermaid;

  static SlideAssetType parse(String value) {
    return values.firstWhereOrNull((e) => e.name == value) ??
        (throw Exception('Invalid asset type: $value'));
  }

  static SlideAssetType? tryParse(String value) {
    return values.firstWhereOrNull((e) => value.startsWith(e.name));
  }
}

@MappableClass(
  includeCustomMappers: [
    FileMapper(),
    SizeMapper(),
  ],
)
final class SlideAsset with SlideAssetMappable {
  final String path;
  final int width;
  final int height;

  SlideAsset({
    required this.path,
    required this.width,
    required this.height,
  });

  String get extension => p.extension(path);

  bool get isPortrait => height > width;

  bool get isLandscape => !isPortrait;

  static const fromMap = SlideAssetMapper.fromMap;
  static const fromJson = SlideAssetMapper.fromJson;
}
