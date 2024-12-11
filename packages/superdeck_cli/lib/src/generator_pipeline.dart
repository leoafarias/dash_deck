import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/parsers/markdown_parser.dart';
import 'package:superdeck_cli/src/parsers/section_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

class TaskContext {
  RawSlide slide;

  final List<LocalAsset> _assetsUsed = [];

  TaskContext(this.slide);

  Future<void> writeAsset(LocalAsset asset, List<int> bytes) async {
    await File(asset.path).writeAsBytes(bytes);
    _assetsUsed.add(asset);
  }

  Future<bool> checkAssetExists(LocalAsset asset) async {
    if (await File(asset.path).exists()) {
      _assetsUsed.add(asset);

      return true;
    }

    return false;
  }

  Slide buildSlide() {
    return Slide(
      key: slide.key,
      options: SlideOptions.fromMap(slide.options),
      markdown: slide.markdown,
      sections: parseSections(slide.markdown),
      comments: slide.comments,
      assets: _assetsUsed,
    );
  }
}

class TaskPipeline {
  final List<Task> tasks;
  final repository = DeckRepository();

  TaskPipeline(this.tasks);

  Future<TaskContext> _runEachSlide(
    int slideIndex,
    TaskContext context,
  ) async {
    for (var task in tasks) {
      try {
        await task.run(context);
      } on Exception catch (e, stackTrace) {
        Error.throwWithStackTrace(
          SDTaskException(task.name, e, slideIndex),
          stackTrace,
        );
      }
    }

    return context;
  }

  Future<List<Slide>> run() async {
    final markdownRaw = await repository.loadMarkdown();

    final slides = MarkdownParser.parse(markdownRaw);

    final futures = <Future<TaskContext>>[];

    for (var i = 0; i < slides.length; i++) {
      futures.add(_runEachSlide(i, TaskContext(slides[i])));
    }

    final contexts = await Future.wait(futures);

    final finalizedSlides = contexts.map((context) => context.buildSlide());

    final neededAssets = finalizedSlides.expand((slide) => slide.assets);

    await _cleanupGeneratedFiles(repository.generatedDir, neededAssets);

    for (var task in tasks) {
      await task.dispose();
    }

    final newSlides = finalizedSlides.toList();

    await repository.saveSlides(newSlides);

    return newSlides;
  }
}

Future<void> _cleanupGeneratedFiles(
  Directory generatedDir,
  Iterable<LocalAsset> assets,
) async {
  final files = await _loadGeneratedFiles(generatedDir);
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

  late final logger = Logger('Task: $name');

  Task(this.name);

  FutureOr<void> run(TaskContext context);

  // Dispose or anything here
  FutureOr<void> dispose() {
    return Future.value();
  }
}

Future<List<File>> _loadGeneratedFiles(Directory generatedDir) async {
  final files = <File>[];

  await for (var entity in generatedDir.list()) {
    if (entity is File) {
      files.add(entity);
    }
  }

  return files;
}
