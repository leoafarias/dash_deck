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
    return File(p.join(configuration.generatedDir.path, asset.fileName));
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
    return fileReader(p.join(configuration.assetDir.path, path));
  }

  @override
  Future<DeckReference> loadDeckReference() async {
    final content = await fileReader(configuration.deckFile.path);
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

  List<GeneratedAsset> get generatedAssets => [..._generatedAssets];

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

  @override
  File getGeneratedAssetFile(GeneratedAsset asset) {
    _generatedAssets.add(asset);
    return super.getGeneratedAssetFile(asset);
  }

  Future<void> saveReference(DeckReference reference) async {
    final json = prettyJson(reference.toMap());
    await configuration.deckFile.writeAsString(json);
  }

  Future<String> readDeckMarkdown() async {
    return await configuration.markdownFile.readAsString();
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
          configuration.deckFile.watch(events: FileSystemEvent.modify).listen(
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
