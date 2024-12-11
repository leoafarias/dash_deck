// deck_repository.dart (After)

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:superdeck_core/superdeck_core.dart';

typedef CustomJsonDecoder = FutureOr<dynamic> Function(String);
typedef CustomAssetLoader = FutureOr<String> Function(String key);

Future<String> _loadString(String key) async {
  return File(key).readAsString();
}

class DeckRepository {
  late final Directory assetDir;
  late final File slidesFile;
  late final Directory generatedDir;
  late final File markdownFile;
  late final CustomJsonDecoder _jsonDecoder;
  late final CustomAssetLoader _assetLoader;

  // late final FileWatcher _watcher;
  StreamController<List<Slide>>? _controller;

  DeckRepository({
    Directory? assetDir,
    File? slidesFile,
    Directory? generatedDir,
    File? markdownFile,
    CustomJsonDecoder? decoder,
    CustomAssetLoader? assetLoader,
  }) {
    this.assetDir = assetDir ?? Directory(p.join('.superdeck'));
    this.slidesFile =
        slidesFile ?? File(p.join(this.assetDir.path, 'slides.json'));
    this.generatedDir =
        generatedDir ?? Directory(p.join(this.assetDir.path, 'generated'));
    this.markdownFile = markdownFile ?? File('slides.md');

    // _watcher = FileWatcher(this.slidesFile);

    _jsonDecoder = decoder ?? jsonDecode;
    _assetLoader = assetLoader ?? _loadString;
  }

  Future<void> ensureReady() async {
    if (!await generatedDir.exists()) {
      await generatedDir.create(recursive: true);
    }

    if (!await markdownFile.exists()) {
      await markdownFile.create(recursive: true);
    }

    // If slides file is missing or invalid, initialize with empty array
    if (!await slidesFile.exists()) {
      await slidesFile.writeAsString('[]');
    } else {
      try {
        await loadSlides(); // Validate load once
      } catch (_) {
        // If invalid, reset to empty list
        await slidesFile.writeAsString('[]');
      }
    }
  }

  Future<List<Slide>> loadSlides() async {
    final content = await slidesFile.readAsString();
    final jsonData = await _jsonDecoder(content);

    if (jsonData is! List) {
      // If not a list, consider this invalid data
      return [];
    }

    final slides = <Slide>[];
    for (final slide in jsonData) {
      try {
        slides.add(Slide.parse(slide));
      } catch (e) {
        // Could log a warning about invalid slide data
        // Skipping invalid slides might be acceptable, or you can fail fast
      }
    }

    return slides;
  }

  Stream<List<Slide>> watch() {
    if (_controller != null) {
      _controller!.close();
    }

    final controller = StreamController<List<Slide>>();

    _controller = controller;

    loadSlides().then((slides) {
      controller.add(slides);
    });

    // Listen for file modifications
    final subscription =
        slidesFile.watch(events: FileSystemEvent.modify).listen(
      (event) async {
        try {
          final slides = await loadSlides();
          controller.add(slides);
        } catch (e) {
          controller.addError(e);
        }
      },
      onError: (error) {
        controller.addError(error);
      },
    );

    _controller!.onCancel = () async {
      await subscription.cancel();
      await controller.close();
    };

    return controller.stream;
  }

  Future<void> saveSlides(List<Slide> slides) async {
    final json = prettyJson(slides.map((e) => e.toMap()).toList());
    await slidesFile.writeAsString(json);
  }

  Future<String> loadMarkdown() async {
    return markdownFile.readAsString();
  }

  Future<String> loadAssetAsString(String path) async {
    try {
      return await _assetLoader(path);
    } catch (e) {
      // Log or handle asset loading error
      rethrow;
    }
  }

  File getAssetFile(LocalAsset asset) {
    return File(p.join(generatedDir.path, asset.path));
  }

  File getSlideThumbnail(String slideKey) {
    return File(
      p.join(generatedDir.path, 'thumbnail_$slideKey.png'),
    );
  }

  void stopWatch() => _controller?.close();
}
