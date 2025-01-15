import 'dart:async';

import 'package:superdeck_cli/src/helpers/dart_process.dart';
import 'package:superdeck_cli/src/parsers/markdown_parser.dart';

class DartCodeTransformer implements BlockTransformer {
  const DartCodeTransformer();
  @override
  Future<String> transform(String markdown) async {
    final codeBlockRegex = RegExp('```dart\n(.*?)\n```');
    final matches = codeBlockRegex.allMatches(markdown);

    for (final match in matches) {
      final code = match.group(1)!;

      final formattedCode = await DartProcess.format(code);

      markdown =
          markdown.replaceAll(match.group(0)!, '```dart\n$formattedCode\n```');
    }

    return markdown;
  }
}
