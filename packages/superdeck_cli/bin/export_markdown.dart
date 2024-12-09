import 'dart:io';

import 'package:path/path.dart' as path;

void main(List<String> arguments) {
  final sourceDir = 'lib/src';
  final outputDir = 'exports';
  final outputFile = path.join(outputDir, 'all_code.md');

  final directory = Directory(sourceDir);
  if (!directory.existsSync()) {
    print('Error: Source directory "$sourceDir" does not exist');
    exit(1);
  }

  // Create output directory if it doesn't exist
  final outDir = Directory(outputDir);
  if (!outDir.existsSync()) {
    outDir.createSync();
  }

  try {
    final StringBuffer markdown = StringBuffer();

    // Process each .dart file
    directory.listSync(recursive: true).forEach((entity) {
      if (entity is File && entity.path.endsWith('.dart')) {
        final content = entity.readAsStringSync();
        final relativePath =
            path.relative(entity.path, from: directory.parent.path);

        // Append to the markdown buffer
        markdown.writeln('# $relativePath\n');
        markdown.writeln('```dart');
        markdown.writeln(content);
        markdown.writeln('```\n');
      }
    });

    // Write everything to a single markdown file
    File(outputFile).writeAsStringSync(markdown.toString());

    print('Successfully created markdown file at $outputFile');
  } catch (e) {
    print('Error during conversion: $e');
    exit(1);
  }
}
