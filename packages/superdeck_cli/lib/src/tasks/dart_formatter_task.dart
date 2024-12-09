import 'dart:async';

import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/helpers/dart_process.dart';

class DartFormatterTask extends Task {
  DartFormatterTask() : super('dart_formatter');

  @override
  FutureOr<void> run(context) async {
    final formattedMarkdown = _formatDartCodeBlocks(context);

    context.slide = context.slide.updateMarkdown(formattedMarkdown);
  }

  String _formatDartCodeBlocks(
    TaskContext controller,
  ) {
    final codeBlockRegex = RegExp('```dart\n(.*?)\n```');
    final markdown = controller.slide.markdown;
    return markdown.replaceAllMapped(codeBlockRegex, (match) {
      final code = match.group(1)!;

      final formattedCode = DartProcess.format(code);

      return '```dart\n$formattedCode\n```';
    });
  }
}
