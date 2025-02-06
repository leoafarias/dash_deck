import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';
import 'package:superdeck_cli/src/helpers/extensions.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';
import 'package:superdeck_cli/src/helpers/update_pubspec.dart';
import 'package:superdeck_cli/src/tasks/dart_formatter_task.dart';
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
    final configFile = DeckConfiguration.defaultFile;
    DeckConfiguration deckConfig;
    if (!await configFile.exists()) {
      deckConfig = DeckConfiguration();
    } else {
      final yamlConfig = await YamlUtils.loadYamlFile(configFile);
      deckConfig = DeckConfiguration.parse(yamlConfig);
    }

    final _pipeline = TaskPipeline(
      tasks: [MermaidConverterTask(), DartFormatterTask()],
      configuration: deckConfig,
      store: FileSystemDataStore(deckConfig),
    );
    final watch = boolArg('watch');

    await _runPipeline(_pipeline);

    if (watch) {
      final subscription = _pipeline.store.configuration.slidesMarkdown
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
