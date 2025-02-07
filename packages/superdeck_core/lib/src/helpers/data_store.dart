// deck_repository.dart (After)

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:superdeck_core/superdeck_core.dart';

abstract interface class IDataStore {
  final DeckConfiguration configuration;

  IDataStore(this.configuration);

  Future<void> initialize();

  Future<DeckReference> loadDeckReference();

  Stream<DeckReference> loadDeckReferenceStream();

  File getGeneratedAssetFile(GeneratedAsset asset) {
    return File(p.join(configuration.assetsDir.path, asset.fileName));
  }

  Future<String> readAssetByPath(String path);
}

class LocalDataStore extends IDataStore {
  LocalDataStore(super.configuration);

  Future<String> fileReader(String path) async {
    return File(path).readAsString();
  }

  @override
  Future<void> initialize() async {}

  @override
  Future<String> readAssetByPath(String path) async {
    return fileReader(path);
  }

  @override
  Future<DeckReference> loadDeckReference() async {
    final content = await fileReader(configuration.deckJson.path);
    return DeckReferenceMapper.fromJson(content);
  }

  @override
  Stream<DeckReference> loadDeckReferenceStream() {
    return Stream.fromFuture(loadDeckReference());
  }
}

class FileSystemDataStore extends LocalDataStore {
  FileSystemDataStore(super.configuration);

  final List<GeneratedAsset> _generatedAssets = [];

  @override
  Future<void> initialize() async {
    if (!await configuration.assetsDir.exists()) {
      await configuration.assetsDir.create(recursive: true);
    }

    if (!await configuration.deckJson.exists()) {
      await configuration.deckJson.writeAsString('{}');
    }

    if (!await configuration.slidesFile.exists()) {
      await configuration.slidesFile.writeAsString('');
    }

    await super.initialize();
  }

  @override
  File getGeneratedAssetFile(GeneratedAsset asset) {
    _generatedAssets.add(asset);
    return super.getGeneratedAssetFile(asset);
  }

  Future<void> saveReferences(
    DeckReference reference,
  ) async {
    // Save deck reference
    final deckJson = prettyJson(reference.toMap());
    await configuration.deckJson.writeAsString(deckJson);

    // Generate the asset references for each slide thumbnail
    final thumbnails =
        reference.slides.map((slide) => GeneratedAsset.thumbnail(slide.key));

    // Combine thumbnail and generated assets
    final allAssets = [
      ...thumbnails,
      ..._generatedAssets,
    ];

// Map asset references to their corresponding file paths
    final assetFiles = allAssets.map(
        (asset) => File(p.join(configuration.assetsDir.path, asset.fileName)));

    final assetsRef = GeneratedAssetsReference(
      lastModified: DateTime.now(),
      files: assetFiles.toList(),
    );

    // Save the assets reference
    final assetsJson = prettyJson(assetsRef.toMap());
    await configuration.assetsRefJson.writeAsString(assetsJson);

    await _cleanupGeneratedAssets(assetsRef);
  }

  Future<String> readDeckMarkdown() async {
    return await configuration.slidesFile.readAsString();
  }

  Future<void> _cleanupGeneratedAssets(
    GeneratedAssetsReference assetsReference,
  ) async {
    final existingFiles = await configuration.assetsDir
        .list(recursive: true)
        .where((e) => e is File)
        .map((e) => e as File)
        .toList();

    final referencedFiles =
        assetsReference.files.map((file) => file.path).toSet();

    await Future.forEach(existingFiles, (File file) async {
      if (!referencedFiles.contains(file.path)) {
        await file.delete();
      }
    });
  }

  @override
  Stream<DeckReference> loadDeckReferenceStream() async* {
    // Emit the current reference immediately.
    yield await loadDeckReference();

    // For each file modification event, emit a new deck reference.
    await for (final _
        in configuration.deckJson.watch(events: FileSystemEvent.modify)) {
      yield await loadDeckReference();
    }
  }
}
