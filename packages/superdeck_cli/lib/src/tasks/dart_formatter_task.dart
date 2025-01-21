import 'dart:async';

import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/helpers/dart_process.dart';
import 'package:superdeck_cli/src/parsers/parsers/block_parser.dart';

class DartFormatterTask extends Task {
  DartFormatterTask() : super('dart_formatter');

  @override
  Future<void> run(TaskContext context) async {
    final codeBlocks = parseFencedCode(context.slide.content);

    final dartBlocks = codeBlocks.where((e) => e.language == 'dart');

    for (final dartBlock in dartBlocks) {
      try {
        final formattedCode = await DartProcess.format(dartBlock.content);

        final updatedMarkdown = context.slide.content.replaceRange(
          dartBlock.startIndex,
          dartBlock.endIndex,
          '```dart\n$formattedCode\n```',
        );

        context.slide.content = updatedMarkdown;
      } catch (e) {
        logger.severe('Failed to format Dart code: $e');
      }
    }
  }
}
