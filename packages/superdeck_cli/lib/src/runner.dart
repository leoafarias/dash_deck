import 'dart:async';
import 'dart:io';

import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/helpers/update_pubspec.dart';
import 'package:superdeck_cli/src/tasks/build_sections_task.dart';
import 'package:superdeck_cli/src/tasks/dart_formatter_task.dart';
import 'package:superdeck_cli/src/tasks/image_cache_task.dart';
import 'package:superdeck_cli/src/tasks/mermaid_task.dart';
import 'package:superdeck_cli/src/tasks/slide_thumbnail_task.dart';
import 'package:superdeck_core/superdeck_core.dart';
import 'package:watcher/watcher.dart';

import 'generator_pipeline.dart';

String _previousMarkdownContents = '';

class SuperdeckRunner {
  SuperdeckRunner();

  Future<void> watch() async {
    await build();
    final watchingLabel = 'Watching for changes...';
    logger
      ..newLine()
      ..info(watchingLabel);
    final watcher = FileWatcher(kMarkdownFile.path);
    await for (final event in watcher.events) {
      await _onFileEvent(event, build);
      logger
        ..newLine()
        ..info('Watching for changes...');
    }
  }

  Future<void> _onFileEvent(
    WatchEvent event,
    Future<void> Function() callback,
  ) async {
    if (event.type != ChangeType.MODIFY) return;

    final newContents = await kMarkdownFile.readAsString();

    if (newContents == _previousMarkdownContents) return;

    _previousMarkdownContents = newContents;

    await callback();
  }

  Future<void> build() async {
    final progress = logger.progress('Generating slides...');

    final pipeline = TaskPipeline([
      MermaidConverterTask(),
      DartFormatterTask(),
      SlideThumbnailTask(),
      ImageCachingTask(),
      BuildSectionsTask(),
    ]);
    try {
      final slides = await pipeline.run();
      progress.complete('Generated ${slides.length} slides.');
    } on Exception catch (e, stackTrace) {
      progress.fail();
      _handleException(e);

      logger.detail(stackTrace.toString());
    }
  }

  Future<void> prepareSuperdeck() async {
    final file = File(kPubpsecFile.path);
    final yamlContents = await file.readAsString();
    updatePubspecAssets(yamlContents);
  }
}

void _handleException(Exception e) {
  if (e is SdTaskException) {
    logger
      ..err('slide: ${e.controller.index}')
      ..err('Task error: ${e.taskName}');

    _handleException(e.exception);
  } else if (e is SdFormatException) {
    logger.formatError(e);
  } else if (e is SdMarkdownParsingException) {
    final errorMessages = e.messages.join('\n');
    logger
      ..newLine()
      ..alert(
        'Slide schema validation failed',
      )
      ..newLine()
      ..err(
        'slide ${e.slideLocation}: > ${e.location} > $errorMessages',
      )
      ..newLine();
  } else {
    logger.err(e.toString());
  }
}
