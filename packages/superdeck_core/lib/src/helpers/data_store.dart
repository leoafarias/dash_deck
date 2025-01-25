// deck_repository.dart (After)

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:superdeck_core/superdeck_core.dart';

class SuperdeckConfig {
  late final Directory assetDir;
  late final File deckFile;
  late final Directory generatedDir;
  late final File markdownFile;

  SuperdeckConfig({
    Directory? assetDir,
    File? deckFile,
    Directory? generatedDir,
    File? markdownFile,
  }) {
    this.assetDir = assetDir ?? Directory(p.join('.superdeck'));
    this.deckFile = deckFile ?? File(p.join(this.assetDir.path, 'slides.json'));
    this.generatedDir =
        generatedDir ?? Directory(p.join(this.assetDir.path, 'generated'));
    this.markdownFile = markdownFile ?? File('slides.md');
  }
}

abstract interface class DataStore {
  final SuperdeckConfig configuration;

  DataStore(this.configuration);

  Future<void> initialize();

  Future<List<Slide>> loadSlides();

  Future<String> getDeckMarkdown();

  Future<String> readAssetByPath(String path);
}

class LocalAssetDataStoreImpl extends DataStore {
  late final Future<String> Function(String path) fileReader;
  LocalAssetDataStoreImpl(
    super.configuration, {
    Future<String> Function(String path)? fileReader,
  }) {
    this.fileReader = fileReader ?? _fileReader;
  }

  static Future<String> _fileReader(String path) {
    return File(path).readAsString();
  }

  @override
  Future<void> initialize() async {}

  @override
  Future<String> readAssetByPath(String path) async {
    return fileReader(p.join(configuration.assetDir.path, path));
  }

  @override
  Future<List<Slide>> loadSlides() async {
    final content = await fileReader(configuration.deckFile.path);
    final slidesJson = await jsonDecode(content);

    if (slidesJson is! List) {
      return [];
    }

    final slides = <Slide>[];
    for (final slide in slidesJson) {
      try {
        slides.add(Slide.parse(slide));
      } catch (e) {
        // Could log a warning about invalid slide data
        // Skipping invalid slides might be acceptable, or you can fail fast
      }
    }

    return slides;
  }

  @override
  Future<String> getDeckMarkdown() {
    return configuration.markdownFile.readAsString();
  }
}

class FileSystemDataStoreImpl extends LocalAssetDataStoreImpl {
  FileSystemDataStoreImpl(super.configuration, {super.fileReader});

  StreamController<List<Slide>>? _controller;

  final List<GeneratedAsset> _generatedAssets = [];

  List<GeneratedAsset> get generatedAssets => _generatedAssets;

  @override
  Future<void> initialize() async {
    if (!await configuration.generatedDir.exists()) {
      await configuration.generatedDir.create(recursive: true);
    }

    if (!await configuration.deckFile.exists()) {
      await configuration.deckFile.writeAsString('[]');
    }

    if (!await configuration.markdownFile.exists()) {
      await configuration.markdownFile.writeAsString('');
    }

    await super.initialize();
  }

  Future<File> getAssetFile(GeneratedAsset asset) async {
    _generatedAssets.add(asset);
    return File(
      p.join(configuration.generatedDir.path, asset.path),
    );
  }

  Future<void> saveSlides(Iterable<Slide> slides) async {
    final json = prettyJson(slides.map((e) => e.toMap()).toList());
    await configuration.deckFile.writeAsString(json);
  }

  Stream<List<Slide>> watchSlides() {
    // stop previous watch
    // if it exists
    _controller?.close();

    final controller = StreamController<List<Slide>>();

    _controller = controller;

    loadSlides().then((slides) {
      controller.add(slides);
    });

    // Listen for file modifications
    final subscription =
        configuration.deckFile.watch(events: FileSystemEvent.modify).listen(
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

  void stopWatch() {
    _controller?.close();
    _controller = null;
  }
}
