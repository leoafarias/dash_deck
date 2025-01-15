import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/parsers/markdown_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

class RemoteAssetTransformer implements BlockTransformer {
  final http.Client _httpClient = http.Client();
  RemoteAssetTransformer();

  @override
  Future<String> transform(String markdown) async {
    final imageRegex = RegExp(r'\!\[.*?\]\((.*?)\s*("(?:.*[^"])")?\s*\)');
    final matches = imageRegex.allMatches(markdown);

    for (final match in matches) {
      final url = match.group(1)!;
      final asset = RemoteAsset.fromUrl(url);

      final block = RemoteAssetBlock(asset: asset);
      markdown = markdown.replaceAll(match.group(0)!, block.toJson());
    }

    return markdown;
  }
}

/// A task responsible for caching images referenced in markdown slides.
class RemoteAssetCaching extends Task {
  /// A set to track assets currently being processed to prevent duplicate downloads.
  static final Set<String> _executingAssets = {};

  /// HTTP client used for downloading images.
  static final http.Client _httpClient = http.Client();

  /// Constructs an [RemoteAssetCaching] with the name 'image_caching'.
  RemoteAssetCaching() : super('remote_asset_caching');

  // Function to download and save a single asset.
  Future<Uint8List?> _fetchData(String url) async {
    try {
      logger.info('Downloading asset: $url');
      final response = await _httpClient.get(Uri.parse(url));

      // Verify successful response.
      if (response.statusCode != 200) {
        logger.warning(
          'Failed to download $url: Status ${response.statusCode}',
        );

        return null;
      }

      final contentType = response.headers['content-type'] ?? '';
      // Validate content type.
      if (!contentType.startsWith('image/')) {
        logger.warning('Invalid content type for $url: $contentType');

        return null;
      }

      // Define supported image formats.

      final extension = contentType.split('/').last.toLowerCase();

      // Check if the image format is supported.
      if (AssetExtension.tryParse(extension) == null) {
        logger.warning('Unsupported image format for $url: $extension');

        return null;
      }

      return response.bodyBytes;
    } catch (e, stackTrace) {
      logger.severe('Error downloading asset $url: $e', e, stackTrace);
    }

    return null;
  }

  @override
  Future<TaskContext> run(TaskContext context) async {
    final assetBlocks = context.blocks.whereType<RemoteAssetBlock>();

    for (final block in assetBlocks) {
      final url = block.asset.src;

      if (_executingAssets.contains(url)) {
        continue;
      }

      _executingAssets.add(url);
      final asset = CacheRemoteAsset.fromUrl(url);
      if (await context.dataStore.checkAssetExists(asset)) {
        continue;
      }
      final data = await _fetchData(url);

      if (data == null) {
        continue;
      }

      await context.writeAsset(asset, data);
    }

    return context;
  }
}
