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
    return File(p.join(configuration.generatedAssetsDir.path, asset.fileName));
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
    if (!await configuration.generatedAssetsDir.exists()) {
      await configuration.generatedAssetsDir.create(recursive: true);
    }

    if (!await configuration.deckJson.exists()) {
      await configuration.deckJson.writeAsString('{}');
    }

    if (!await configuration.slidesMarkdown.exists()) {
      await configuration.slidesMarkdown.writeAsString('');
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
    final deckJson = prettyJson(reference.toMap());
    await configuration.deckJson.writeAsString(deckJson);

    final thumbnails =
        reference.slides.map((slide) => GeneratedAsset.thumbnail(slide.key));

    final assets = [
      ...thumbnails,
      ..._generatedAssets,
    ];

    final files = assets.map((asset) =>
        File(p.join(configuration.generatedAssetsDir.path, asset.fileName)));

    final assetsRef = GeneratedAssetsReference(
      lastModified: DateTime.now(),
      files: files.toList(),
    );

    final assetsJson = prettyJson(assetsRef.toMap());

    await configuration.generatedAssetsRefJson.writeAsString(assetsJson);

    await _cleanupGeneratedAssets(assetsRef);
  }

  Future<String> readDeckMarkdown() async {
    return await configuration.slidesMarkdown.readAsString();
  }

  Future<void> _cleanupGeneratedAssets(
    GeneratedAssetsReference assetsReference,
  ) async {
    final existingFiles = await configuration.generatedAssetsDir
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
  Stream<DeckReference> loadDeckReferenceStream() {
    return Stream<DeckReference>.multi((controller) async {
      // Emit the current reference immediately
      try {
        final reference = await loadDeckReference();
        controller.add(reference);
      } catch (e) {
        controller.addError(e);
      }

      // Listen for file modifications
      final subscription =
          configuration.deckJson.watch(events: FileSystemEvent.modify).listen(
        (event) async {
          try {
            final reference = await loadDeckReference();
            controller.add(reference);
          } catch (e) {
            controller.addError(e);
          }
        },
        onError: controller.addError,
      );

      // Ensure the subscription is cancelled when there are no listeners.
      controller.onCancel = () async {
        await subscription.cancel();
      };
    });
  }
}
