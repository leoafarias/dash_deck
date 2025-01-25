import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/parsers/markdown_parser.dart';
import 'package:superdeck_cli/src/parsers/parsers/block_extractor.dart';
import 'package:superdeck_core/superdeck_core.dart';

/// Represents the context in which a slide is processed.
/// It holds the raw slide data and manages associated assets.
class TaskContext {
  /// The index of the slide in the original list.
  final int slideIndex;
  final FileSystemDataStoreImpl dataStore;

  /// The raw slide being processed.
  RawSlideMarkdown slide;

  TaskContext(this.slideIndex, this.slide, this.dataStore);
}

/// Manages the execution of a series of [SlideTask] instances to process slides.
/// It handles loading markdown content, parsing slides, executing tasks,
/// cleaning up assets, and saving the processed slides.
class TaskPipeline {
  /// List of tasks to execute for each slide.
  final List<Task> tasks;

  /// Repository for loading and saving slides.
  final FileSystemDataStoreImpl dataStore;

  const TaskPipeline({required this.tasks, required this.dataStore});

  /// Processes an individual slide by executing all tasks sequentially.
  Future<TaskContext> _processSlide(TaskContext context) async {
    for (var task in tasks) {
      try {
        await task.run(context);
      } on Exception catch (e, stackTrace) {
        // Wrap and rethrow the exception with additional context.
        Error.throwWithStackTrace(
          SDTaskException(task.name, e, context.slideIndex),
          stackTrace,
        );
      }
    }

    return context;
  }

  /// Cleans up generated files in [generatedDir] that are not present in [neededAssets].
  Future<void> _cleanupGeneratedFiles(
    Directory generatedDir,
    List<GeneratedAsset> neededAssets,
  ) async {
    final files = await _loadGeneratedFiles(generatedDir);

    final generatedAssets = {
      for (var asset in neededAssets) join(generatedDir.path, asset.path),
    };

    List<File> filesToDelete = [];
    for (var file in files) {
      if (!generatedAssets.contains(file.path)) {
        filesToDelete.add(file);
      }
    }

    for (var file in filesToDelete) {
      logger.info('Deleting generated file: ${file.path}');
      await file.delete();
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
  Future<Iterable<Slide>> run() async {
    // Load raw markdown content from the repository.
    final markdownRaw = await dataStore.getDeckMarkdown();

    // Initialize the markdown parser with necessary extractors.
    final markdownParser = MarkdownParser();

    // Parse the raw markdown into individual raw slides.
    final rawSlides = await markdownParser.parse(markdownRaw);

    // Prepare a list of futures to process each slide concurrently.
    final futures = <Future<TaskContext>>[];

    for (var i = 0; i < rawSlides.length; i++) {
      futures.add(_processSlide(TaskContext(i, rawSlides[i], dataStore)));
    }

    // Await all slide processing tasks to complete.
    final results = await Future.wait(futures);

    // Extract the processed slides from the results.
    final finalizedSlides = results.map((result) => result.slide);

    final slides = finalizedSlides.map((slide) => Slide(
          key: slide.key,
          options: SlideOptions.parse(slide.frontmatter),
          markdown: slide.content,
          sections: parseSections(slide.content),
        ));

    // Determine all assets that are still needed after processing.

    List<GeneratedAsset> thumbnailAssets = [];

    for (final slide in finalizedSlides) {
      thumbnailAssets.add(GeneratedAsset.thumbnail(slide.key));
    }

    // Clean up any generated files that are no longer needed.
    await _cleanupGeneratedFiles(
      dataStore.configuration.generatedDir,
      [...dataStore.generatedAssets, ...thumbnailAssets],
    );

    // Dispose of all tasks after processing.
    for (var task in tasks) {
      await task.dispose();
    }

    // Convert the iterable of slides to a list for saving.

    // Save the processed slides back to the repository.
    await dataStore.saveSlides(slides);

    return slides;
  }
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
  FutureOr<void> run(TaskContext context);

  /// Disposes of any resources held by the task.
  /// Override if the task holds resources that need explicit disposal.
  FutureOr<void> dispose() {
    return Future.value();
  }
}

/// Abstract class for pre-processing tasks that modify raw markdown.
abstract class PreProcessingTask extends Task {
  PreProcessingTask(super.name);

  /// Executes the pre-processing task, modifying the raw markdown.
  FutureOr<void> runPreProcessing(TaskContext context);
}

/// Abstract class for post-processing tasks that operate on finalized slides.
abstract class PostProcessingTask extends Task {
  PostProcessingTask(super.name);

  /// Executes the post-processing task, modifying the finalized slides.
  FutureOr<void> runPostProcessing(TaskContext context);
}
