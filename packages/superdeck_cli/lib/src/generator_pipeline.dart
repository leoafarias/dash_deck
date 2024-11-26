import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:image/image.dart' as img;
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;
import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/parsers/slide_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

typedef PipelineResult = ({
  List<Slide> slides,
  List<Asset> neededAssets,
});

class TaskContext {
  final int index;
  Slide slide;
  List<Asset> assets;

  TaskContext({
    required this.slide,
    required this.index,
    required this.assets,
  });

  final List<Asset> _neededAssets = [];

  bool assetExists(String assetName) {
    for (var element in assets) {
      print('Checking asset: ${element.path}');
    }
    final asset = assets.firstWhereOrNull(
      (element) => element.path.contains(assetName),
    );

    if (asset == null) {
      return false;
    }

    _neededAssets.add(asset);

    return true;
  }

  Future<void> saveAsAsset(File file, [String? reference]) async {
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

  Slide finalize() {
    return slide.copyWith(
      assets: _neededAssets,
    );
  }
}

class TaskPipeline {
  final List<Task> tasks;
  final repository = DeckRepository(canRunLocal: true);

  TaskPipeline(
    this.tasks,
  );

  Future<TaskContext> _runEachSlide(
    TaskContext context,
  ) async {
    for (var task in tasks) {
      try {
        await task.run(context);
      } on Exception catch (e) {
        throw SdTaskException(task.name, context, e);
      }
    }

    return context;
  }

  Future<List<Slide>> run() async {
    final markdownRaw = await repository.loadMarkdown();

    // final loadedReference = SuperDeckReference.loadYaml(kReferenceFileYaml);
    final savedSlides = await repository.loadSlides();

    final slides = parseSlides(markdownRaw);
    final assets = savedSlides
        .map((e) => e.assets)
        .expand((e) => e)
        .toList()
        .where((element) => File(element.path).existsSync())
        .toList();

    final futures = <Future<TaskContext>>[];

    for (var i = 0; i < slides.length; i++) {
      final controller = TaskContext(
        index: i,
        slide: slides[i],
        assets: assets,
      );
      futures.add(_runEachSlide(controller));
    }

    final contexts = await Future.wait(futures);

    final finalizedSlides = contexts.map((context) => context.finalize());

    final neededAssets = finalizedSlides.expand((slide) => slide.assets);

    await _cleanupGeneratedFiles(neededAssets);

    for (var task in tasks) {
      await task.dispose();
    }

    final newSlides = finalizedSlides.toList();

    await repository.saveSlides(newSlides);

    return newSlides;
  }
}

Future<void> _cleanupGeneratedFiles(Iterable<Asset> assets) async {
  final files = await _loadGeneratedFiles();
  final neededPaths = assets.map((asset) => asset.path).toSet();

  for (var file in files) {
    if (!neededPaths.contains(file.path)) {
      if (await file.exists()) {
        await file.delete();
      }
    }
  }
}

abstract class Task {
  final String name;
  final repository = DeckRepository(canRunLocal: true);
  Task(this.name);

  FutureOr<void> run(TaskContext context);

  late final logger = Logger('Task: $name');

  Future<String> dartProcess(String code) async {
    final process = await Process.start('dart', ['format', '--fix'],
        mode: ProcessStartMode.inheritStdio);

    process.stdin.writeln(code);
    process.stdin.close();

    final output = await process.stdout.transform(utf8.decoder).join();
    final error = await process.stderr.transform(utf8.decoder).join();

    if (error.isNotEmpty) {
      throw Exception('Error formatting dart code: $error');
    }

    return output;
  }

  File buildAssetFile(String assetName, String extension) {
    if (p.extension(assetName).isNotEmpty) {
      throw Exception('Asset name should not have an extension');
    }

    if (!extension.startsWith('.')) {
      extension = '.$extension';
    }
    final updatedFileName = ('${name}_$assetName$extension');
    return File(p.join(kGeneratedAssetsDir.path, updatedFileName));
  }

  // Dispose or anything here
  FutureOr<void> dispose() {}
}

Future<List<File>> _loadGeneratedFiles() async {
  final files = <File>[];

  await for (var entity in kGeneratedAssetsDir.list()) {
    if (entity is File) {
      files.add(entity);
    }
  }

  return files;
}
