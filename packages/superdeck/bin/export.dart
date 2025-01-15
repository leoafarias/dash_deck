// bin/flatten_project.dart

import 'dart:io';

import 'package:path/path.dart' as p;

void main(List<String> args) async {
  // Configuration

  // Define directories to include (e.g., 'lib', 'bin')
  final includeDirectories = [
    'lib',

    // Add more directories as needed
  ];

  // Define file extensions to include (e.g., '.dart', '.md')
  final includeExtensions = [
    '.dart',

    // Add more extensions as needed
  ];

  // Define file extensions to exclude (e.g., '.log', '.json')
  final excludeExtensions = [
    '.g.dart',
    '.mapper.dart',

    // Add more extensions as needed
  ];

  // Define output directory and file
  final currentDir = Directory.current;
  final outputDir = Directory(p.join(currentDir.path, 'flattened'));
  final timestamp = DateTime.now()
      .toIso8601String()
      .replaceAll(':', '-')
      .replaceAll('.', '-');
  const separator = '---';
  final projectName = p.basename(currentDir.path);
  final outputFilePath = p.join(outputDir.path, '$projectName-$timestamp.txt');
  final outputFile = File(outputFilePath);

  // Create output directory if it doesn't exist
  if (!await outputDir.exists()) {
    await outputDir.create(recursive: true);
    print('Created output directory: ${outputDir.path}');
  }

  // Helper function to determine if a file should be included
  bool shouldInclude(String relativePath) {
    // Check if the file is within any of the included directories
    bool isInIncludedDir = includeDirectories.any((dir) {
      // Normalize directory path
      final normalizedDir = p.normalize(dir);
      return relativePath.startsWith('$normalizedDir/');
    });

    if (!isInIncludedDir) return false;

    // Check if the file has one of the included extensions
    String extension = p.extension(relativePath).toLowerCase();
    return includeExtensions.contains(extension) &&
        !excludeExtensions.contains(extension);
  }

  // Helper function to check if a file is a text file
  bool isTextFile(File file) {
    try {
      final bytes = file.readAsBytesSync();
      // Simple heuristic: if the file contains null bytes, it's likely binary
      if (bytes.contains(0)) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // Helper function to estimate tokens more accurately
  int estimateTokens(File file) {
    try {
      final content = file.readAsStringSync();
      final matches = RegExp(r'\w+|[^\w\s]').allMatches(content);
      int tokenCount = 0;

      for (final match in matches) {
        String token = match.group(0)!;

        // Heuristic: Assume longer tokens might split into multiple tokens
        if (token.length > 6) {
          tokenCount += (token.length / 3).ceil(); // Approximate split
        } else {
          tokenCount += 1;
        }
      }

      return tokenCount;
    } catch (e) {
      // In case of read error, return 0
      return 0;
    }
  }

  // Start writing to the output file
  final sink = outputFile.openWrite();

  // Write header
  sink.writeln('# Project: $projectName');
  sink.writeln('# Generated: ${DateTime.now()}');
  sink.writeln('');
  sink.writeln(
      '# Complete Repository Structure:\n# (showing all directories and files with token counts)\n');

  // Maps to store directory token counts and file lists
  final directoryTokenCounts = <String, int>{};
  final directoryFiles = <String, List<File>>{};

  // Traverse files in included directories
  for (var dir in includeDirectories) {
    final Directory targetDir = Directory(p.join(currentDir.path, dir));
    if (await targetDir.exists()) {
      await for (var entity
          in targetDir.list(recursive: true, followLinks: false)) {
        if (entity is File) {
          final relativePath = p
              .relative(entity.path, from: currentDir.path)
              .replaceAll('\\', '/');
          if (shouldInclude(relativePath) && isTextFile(entity)) {
            final dirPath = p.dirname(relativePath);
            final tokens = estimateTokens(entity);
            directoryTokenCounts.update(
              dirPath,
              (value) => value + tokens,
              ifAbsent: () => tokens,
            );
            directoryFiles.putIfAbsent(dirPath, () => []).add(entity);
          }
        }
      }
    } else {
      print('Directory does not exist: ${targetDir.path}');
    }
  }

  // List directories with token counts
  final sortedDirectories = directoryTokenCounts.keys.toList()..sort();
  for (var dir in sortedDirectories) {
    final depth = dir.split('/').length - 1;
    final indent = '  ' * depth;
    final displayPath = dir.isEmpty ? '.' : dir;
    final totalTokens = directoryTokenCounts[dir]!;
    sink.writeln('#$indent$displayPath/ (~$totalTokens tokens)');

    // List files in the directory
    final files = directoryFiles[dir]!
      ..sort((a, b) => a.path.compareTo(b.path));
    for (var file in files) {
      final fileName = p.basename(file.path);
      final tokens = estimateTokens(file);
      sink.writeln('#$indent  └── $fileName (~$tokens tokens)');
    }
  }

  sink.writeln('#');
  sink.writeln(separator);
  await sink.flush();

  // Gather all included files for content appending
  final allIncludedFiles = <File>[];
  for (var dirFilesList in directoryFiles.values) {
    allIncludedFiles.addAll(dirFilesList);
  }

  // Sort files by path
  allIncludedFiles.sort((a, b) => a.path.compareTo(b.path));

  // Initialize progress indicators
  final totalFiles = allIncludedFiles.length;
  int processedFiles = 0;

  // Append each file's content with separators
  for (var file in allIncludedFiles) {
    processedFiles++;
    stdout.write('\rProcessing file $processedFiles of $totalFiles');

    final relativeFilePath =
        p.relative(file.path, from: currentDir.path).replaceAll('\\', '/');
    sink.writeln(separator);
    sink.writeln(relativeFilePath);
    sink.writeln(separator);
    try {
      final content = await file.readAsString();
      sink.writeln(content);
      sink.writeln('');
    } catch (e) {
      sink.writeln('// Error reading file: $e');
    }
  }

  // Ensure the final separator is added
  sink.writeln(separator);
  await sink.close();

  print('\nProcessing complete! Output saved to: $outputFilePath');
}
