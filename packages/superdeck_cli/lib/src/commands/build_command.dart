import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/helpers/extensions.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/helpers/update_pubspec.dart';
import 'package:superdeck_cli/src/tasks/mermaid_task.dart';
import 'package:superdeck_core/superdeck_core.dart';

class BuildCommand extends Command<int> {
  bool _isRunning = false;

  BuildCommand() {
    argParser.addFlag(
      'watch',
      abbr: 'w',
      help: 'Watch for changes and build the deck',
    );
  }

  Future<void> _runPipeline(TaskPipeline pipeline) async {
    // wait wihle _isRunning is true
    while (_isRunning) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _isRunning = true;
    final progress = logger.progress('Generating slides...');
    try {
      final slides = await pipeline.run();
      progress.complete('Generated ${slides.length} slides.');
    } on Exception catch (e, stackTrace) {
      progress.fail();
      printException(e);

      logger.detail(stackTrace.toString());
    } finally {
      _isRunning = false;
    }
  }

  @override
  Future<int> run() async {
    final _pipeline = TaskPipeline(
      tasks: [MermaidConverterTask()],
      dataStore: FileSystemDataStoreImpl(SuperdeckConfig()),
    );
    final watch = boolArg('watch');

    await _runPipeline(_pipeline);

    if (watch) {
      final subscription = _pipeline.dataStore.configuration.markdownFile
          .watch(events: FileSystemEvent.modify)
          .listen((event) => _runPipeline(_pipeline));
    }

    return ExitCode.success.code;
  }

  @override
  String get description => 'Build the deck';

  @override
  String get name => 'build';
}

Future<void> prepareSuperdeck() async {
  final file = File(kPubpsecFile.path);
  final yamlContents = await file.readAsString();
  updatePubspecAssets(yamlContents);
}
