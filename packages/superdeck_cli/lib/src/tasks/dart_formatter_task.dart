import 'dart:async';

import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/helpers/dart_process.dart';

class DartFormatterTask extends Task {
  DartFormatterTask() : super('dart_formatter');

  Future<String> _formatDartCodeBlocks(TaskContext controller) async {
    final codeBlockRegex = RegExp('```dart\n(.*?)\n```');
    var markdown = controller.slide.markdown;

    final matches = codeBlockRegex.allMatches(markdown);

    for (final match in matches) {
      final code = match.group(1)!;

      final formattedCode = await DartProcess.format(code);

      markdown =
          markdown.replaceAll(match.group(0)!, '```dart\n$formattedCode\n```');
    }

    return markdown;
  }

  @override
  FutureOr<void> run(TaskContext context) async {
    final formattedMarkdown = await _formatDartCodeBlocks(context);

    context.slide.markdown = formattedMarkdown;
  }
}
