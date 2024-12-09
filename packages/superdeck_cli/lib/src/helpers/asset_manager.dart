import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:image/image.dart' as img;
import 'package:superdeck_core/superdeck_core.dart';

class AssetManager {
  final String assetsJsonPath;
  late List<Asset> _neededAssets;
  late List<Asset> assets;

  AssetManager({required this.assetsJsonPath}) {
    _loadAssets();
  }

  // Load assets from JSON file
  void _loadAssets() {
    if (File(assetsJsonPath).existsSync()) {
      final fileContent = File(assetsJsonPath).readAsStringSync();
      final jsonData = List<Map<String, dynamic>>.from(jsonDecode(fileContent));

      assets = jsonData.map((value) => Asset.fromMap(value)).toList();
    } else {
      assets = [];
    }
  }

  // Save assets to JSON file
  void _saveAssets() {
    final jsonData =
        _neededAssets.map((asset) => MapEntry(asset.path, asset.toJson()));
    File(assetsJsonPath).writeAsStringSync(jsonEncode(jsonData));
  }

  // Check if an asset exists
  bool checkAsset(File file) {
    final asset = assets.firstWhereOrNull(
      (asset) => asset.path == file.path,
    );

    if (asset == null) {
      return false;
    }

    _neededAssets.add(asset);
    return true;
  }

  // Add a new asset if it doesn't exist
  Future<void> addAsset(File file, [String? reference]) async {
    final image = await img.decodeImageFile(file.path);

    if (image == null) {
      throw Exception('Image could not be decoded');
    }

    final asset = Asset(
      path: file.path,
      width: image.width,
      height: image.height,
      reference: reference,
    );
    _neededAssets.add(asset);
  }

  void finalize() {
    // Delete the assets that are not in needed assets but are on assets
    for (final asset in assets) {
      if (!_neededAssets.contains(asset)) {
        File(asset.path).deleteSync();
      }
    }
    _saveAssets();
  }
}
