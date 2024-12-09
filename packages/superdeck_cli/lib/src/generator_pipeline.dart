import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/parsers/markdown_parser.dart';
import 'package:superdeck_cli/src/parsers/slide_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

class TaskContext {
  SlideRaw slide;

  TaskContext(
    this.slide,
  );

  final List<AssetRaw> _assetsUsed = [];

  Future<void> writeAsset(AssetRaw asset, List<int> bytes) async {
    await File(asset.path).writeAsBytes(bytes);
    _assetsUsed.add(asset);
  }

  Future<bool> checkAssetExists(AssetRaw asset) async {
    if (await File(asset.path).exists()) {
      _assetsUsed.add(asset);
      return true;
    }
    return false;
  }

  Future<Slide> buildSlide() async {
    return SlideConverter.convert(slide, _assetsUsed);
  }
}

class TaskPipeline {
  final List<Task> tasks;
  final repository = DeckRepository(canRunLocal: true);

  TaskPipeline(this.tasks);

  Future<TaskContext> _runEachSlide(
    int slideIndex,
    TaskContext context,
  ) async {
    for (var task in tasks) {
      try {
        await task.run(context);
      } on Exception catch (e) {
        throw SdTaskException(task.name, context, e, slideIndex);
      }
    }

    return context;
  }

  Future<List<Slide>> run() async {
    final markdownRaw = await repository.loadMarkdown();

    final slides = MarkdownParser.parse(markdownRaw);

    final futures = <Future<TaskContext>>[];

    for (var i = 0; i < slides.length; i++) {
      futures.add(_runEachSlide(
        i,
        TaskContext(slides[i]),
      ));
    }

    final contexts = await Future.wait(futures);

    final finalizedSlides = await Future.wait(contexts.map(
      (context) => context.buildSlide(),
    ));

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
  final repository = DeckRepository();
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
