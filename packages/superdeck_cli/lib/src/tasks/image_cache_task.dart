import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart' as md;
import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/parsers/slide_parser.dart';

/// A task responsible for caching images referenced in markdown slides.
class ImageCachingTask extends Task {
  /// Constructs an [ImageCachingTask] with the name 'image_caching'.
  ImageCachingTask() : super('image_caching');

  /// A set to track assets currently being processed to prevent duplicate downloads.
  static final Set<String> _executingAssets = {};

  /// HTTP client used for downloading images.
  static final http.Client _httpClient = http.Client();

  @override
  Future<TaskContext> run(TaskContext context) async {
    final slide = context.slide;
    final content = slide.markdown;

    // Parse the markdown content to extract image URLs.
    final document = md.Document();
    final nodes = document.parseInline(content);
    final Set<String> urls = {};

    for (final node in nodes) {
      if (node is md.Element && node.tag == 'img') {
        final src = node.attributes['src'];
        if (src != null && src.startsWith('http')) {
          urls.add(src);
        }
      }
    }

    // Iterate over each asset and process if not already executing.
    for (final url in urls) {
      if (_executingAssets.contains(url)) {
        continue; // Skip if the asset is already being processed.
      }
      _executingAssets.add(url);
      final asset = CachedRemoteAssetRaw.fromUrl(url);
      if (await context.checkAssetExists(asset)) {
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

      final contentType = response.headers['content-type'];
      // Validate content type.
      if (contentType == null || !contentType.startsWith('image/')) {
        logger.warning('Invalid content type for $url: $contentType');
        return null;
      }

      // Define supported image formats.

      final extension = contentType.split('/').last.toLowerCase();

      // Check if the image format is supported.
      if (AssetType.tryParse(extension) == null) {
        logger.warning('Unsupported image format for $url: $extension');
        return null;
      }

      return response.bodyBytes;
    } catch (e, stackTrace) {
      logger.severe('Error downloading asset $url: $e', e, stackTrace);
    }
    return null;
  }
}
