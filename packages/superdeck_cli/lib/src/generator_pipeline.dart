import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:superdeck_cli/src/parsers/extractors/block_extractor.dart';
import 'package:superdeck_cli/src/parsers/extractors/comment_extractor.dart';
import 'package:superdeck_cli/src/parsers/extractors/front_matter_extractor.dart';
import 'package:superdeck_cli/src/parsers/markdown_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

/// Represents the context in which a slide is processed.
/// It holds the raw slide data and manages associated assets.
class SlideProcessingContext {
  /// The index of the slide in the original list.
  final int slideIndex;

  /// The raw slide being processed.
  Slide slide;

  /// List of assets used during processing.
  final List<LocalAsset> _assetsUsed = [];

  SlideProcessingContext(this.slideIndex, this.slide);

  /// Writes an asset to the specified path and tracks its usage.
  Future<void> writeAsset(LocalAsset asset, List<int> bytes) async {
    await File(asset.path).writeAsBytes(bytes);
    _assetsUsed.add(asset);
  }

  /// Checks if an asset exists at the specified path.
  /// If it exists, tracks its usage.
  Future<bool> assetExists(LocalAsset asset) async {
    if (await File(asset.path).exists()) {
      _assetsUsed.add(asset);

      return true;
    }

    return false;
  }
}

/// Abstract base class representing a generic task in the pipeline.
/// Each task should implement the [run] method to perform its specific operation.
abstract class SlideTask {
  /// Name of the task, used for logging and identification.
  final String name;

  /// Logger instance for the task.
  late final Logger logger = Logger('SlideTask: $name');

  SlideTask(this.name);

  /// Executes the task using the provided [SlideProcessingContext].
  Future<void> run(SlideProcessingContext context);

  /// Disposes of any resources held by the task.
  /// Override if the task holds resources that need explicit disposal.
  Future<void> dispose() async {
    // Default implementation does nothing.
  }
}

/// Manages the execution of a series of [SlideTask] instances to process slides.
/// It handles loading markdown content, parsing slides, executing tasks,
/// cleaning up assets, and saving the processed slides.
class SlideProcessingPipeline {
  final int slideIndex;

  /// List of tasks to execute for each slide.
  final List<SlideTask> tasks;

  /// Repository for loading and saving slides.
  final DeckRepository repository = DeckRepository();

  SlideProcessingPipeline(this.slideIndex, this.tasks);

  /// Processes an individual slide by executing all tasks sequentially.
  Future<TaskProcessingResult> _processSlide(
    SlideProcessingContext context,
  ) async {
    for (var task in tasks) {
      try {
        await task.run(context);
      } on Exception catch (e, stackTrace) {
        // Wrap and rethrow the exception with additional context.
        Error.throwWithStackTrace(
          SDTaskException(task.name, e, slideIndex),
          stackTrace,
        );
      }
    }

    return TaskProcessingResult(context);
  }

  /// Cleans up generated files in [generatedDir] that are not present in [neededAssets].
  Future<void> _cleanupGeneratedFiles(
    Directory generatedDir,
    Set<LocalAsset> neededAssets,
  ) async {
    final files = await _loadGeneratedFiles(generatedDir);
    final neededPaths = neededAssets.map((asset) => asset.path).toSet();

    for (var file in files) {
      if (!neededPaths.contains(file.path)) {
        if (await file.exists()) {
          await file.delete();
        }
      }
    }
  }

  /// Loads all generated files from [generatedDir].
  Future<List<File>> _loadGeneratedFiles(Directory generatedDir) async {
    final files = <File>[];

    await for (var entity in generatedDir.list()) {
      if (entity is File) {
        files.add(entity);
      }
    }

    return files;
  }

  /// Runs the entire pipeline:
  /// 1. Loads raw markdown content.
  /// 2. Parses it into raw slides.
  /// 3. Executes each task for every slide.
  /// 4. Cleans up unneeded generated files.
  /// 5. Saves the processed slides.
  Future<List<Slide>> run() async {
    // Load raw markdown content from the repository.
    final markdownRaw = await repository.loadMarkdown();

    // Initialize the markdown parser with necessary extractors.
    final markdownParser = MarkdownParser(
      frontmatterExtractor: YamlFrontmatterExtractor(),
      commentExtractor: HtmlCommentExtractor(),
      blockExtractor: BlockExtractor(registry: BlockExtractorRegistry()),
    );

    // Parse the raw markdown into individual raw slides.
    final rawSlides = markdownParser.parse(markdownRaw);

    // Prepare a list of futures to process each slide concurrently.
    final futures = <Future<TaskProcessingResult>>[];

    for (var i = 0; i < rawSlides.length; i++) {
      futures.add(_processSlide(SlideProcessingContext(i, rawSlides[i])));
    }

    // Await all slide processing tasks to complete.
    final results = await Future.wait(futures);

    // Extract the processed slides from the results.
    final finalizedSlides = results.map((result) => result.context.slide);

    // Determine all assets that are still needed after processing.
    final neededAssets =
        finalizedSlides.expand((slide) => slide.assets).toSet();

    // Clean up any generated files that are no longer needed.
    await _cleanupGeneratedFiles(repository.generatedDir, neededAssets);

    // Dispose of all tasks after processing.
    for (var task in tasks) {
      await task.dispose();
    }

    // Convert the iterable of slides to a list for saving.
    final newSlides = finalizedSlides.toList();

    // Save the processed slides back to the repository.
    await repository.saveSlides(newSlides);

    return newSlides;
  }
}

/// Represents the result of processing a single slide.
class TaskProcessingResult {
  /// The context after processing the slide.
  final SlideProcessingContext context;

  const TaskProcessingResult(this.context);
}

/// Custom exception for errors that occur during task execution.
class SDTaskException implements Exception {
  /// Name of the task where the error occurred.
  final String taskName;

  /// The original exception that was thrown.
  final Exception originalException;

  /// Index of the slide being processed when the error occurred.
  final int slideIndex;

  const SDTaskException(this.taskName, this.originalException, this.slideIndex);

  @override
  String toString() {
    return 'Error in task "$taskName" at slide index $slideIndex: $originalException';
  }
}

/// Abstract class representing a generic task in the slide processing pipeline.
/// Each concrete task should implement the [run] method to perform its specific operation.
abstract class Task {
  /// Name of the task, used for logging and identification.
  final String name;

  /// Logger instance for the task.
  late final Logger logger = Logger('Task: $name');

  Task(this.name);

  /// Executes the task using the provided [TaskContext].
  FutureOr<void> run(SlideProcessingContext context);

  /// Disposes of any resources held by the task.
  /// Override if the task holds resources that need explicit disposal.
  FutureOr<void> dispose() {
    return Future.value();
  }
}
