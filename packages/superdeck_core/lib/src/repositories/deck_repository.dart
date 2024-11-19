import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:superdeck_core/src/helpers/watcher.dart';
import 'package:superdeck_core/superdeck_core.dart';

final _assetDir = Directory(p.join('.superdeck'));
final _slidesRef = File(p.join(_assetDir.path, 'slides.json'));
final _generatedDir = Directory(p.join(_assetDir.path, 'generated'));
final _projectConfigFile = File('superdeck.yaml');
final _markdownFile = File('slides.md');

typedef CustomJsonDecoder = FutureOr<dynamic> Function(String);
typedef CustomAssetLoader = FutureOr<String> Function(String key);

Future<String> _loadString(String key) async {
  return File(key).readAsString();
}

class DeckRepository {
  final CustomJsonDecoder _jsonDecoder;
  final CustomAssetLoader _assetLoader;

  Future<void> ensureReady() async {
    if (!await _generatedDir.exists()) {
      await _generatedDir.create(recursive: true);
    }

    if (!await _markdownFile.exists()) {
      await _markdownFile.create(recursive: true);
    }

    try {
      await loadSlides();
    } catch (e) {
      if (await _slidesRef.exists()) {
        await _slidesRef.delete();
      }
      await _slidesRef.writeAsString('{}');
    }
  }

  /// Whether the repository can do local File I/O operations
  final bool canRunLocal;
  final _watcher = FileWatcher(_slidesRef);

  DeckRepository({
    CustomJsonDecoder decoder = jsonDecode,
    CustomAssetLoader assetLoader = _loadString,
    this.canRunLocal = false,
  })  : _jsonDecoder = decoder,
        _assetLoader = assetLoader;

  Future<List<Slide>> loadSlides() async {
    final content = await _slidesRef.readAsString();

    final json = await _jsonDecoder(content);

    if (json == null) {
      return [];
    }

    List<Slide> slides = [];

    for (final slide in json) {
      slides.add(Slide.fromMap(slide));
    }

    return slides;
  }

  Stream<List<Slide>> watch() {
    if (canRunLocal) {
      return Stream.fromFuture(loadSlides());
    }
    // Create a StreamController to handle changes
    final controller = StreamController<List<Slide>>();

    // Watch the file for changes and emit a new list of slides when it changes
    _slidesRef.watch(events: FileSystemEvent.modify).listen((event) async {
      try {
        // Read the updated content as a string
        final content = await _slidesRef.readAsString();

        // Decode the JSON content
        final json = jsonDecode(content);

        // Map the JSON data to a List of Slide objects
        final slides = (json as List)
            .map((e) => Slide.fromMap(e as Map<String, dynamic>))
            .toList();

        // Add the updated slides to the stream
        controller.add(slides);
      } catch (e) {
        // Handle any errors by adding an error to the stream
        controller.addError(e);
        rethrow;
      }
    });

    // Close the controller when it's no longer in use
    controller.onCancel = () {
      controller.close();
    };

    return controller.stream;
  }

  Future<void> saveSlides(List<Slide> slides) async {
    final json = jsonEncode(slides.map((e) => e.toMap()).toList());

    await _slidesRef.writeAsString(json);
  }

  Future<String> loadMarkdown() async {
    return _markdownFile.readAsString();
  }

  Future<String> loadAssetAsString(String path) async {
    return _assetLoader(path);
  }

  File getAssetFile(String fileName) {
    return File(p.join(_generatedDir.path, fileName));
  }

  File getSlideThumbnail(Slide slide) {
    return File(
      p.join(_generatedDir.path, 'thumbnail_${slide.key}.png'),
    );
  }

  void startListening(FutureOr<void> Function() callback) {
    if (canRunLocal) {
      if (!_watcher.isWatching) {
        _watcher.start(callback);
      }
    }
  }

  void stopListening() => _watcher.stop();
}
