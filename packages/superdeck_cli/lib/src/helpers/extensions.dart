import 'dart:io';

import 'package:superdeck_core/superdeck_core.dart';
import 'package:yaml_writer/yaml_writer.dart';

extension FileExt on File {
  Future<void> ensureWrite(String content) async {
    if (!await exists()) {
      await create(recursive: true);
    }

    await writeAsString(content);
  }

  Future<void> ensureExists() async {
    if (!await exists()) {
      await create(recursive: true);
    }
  }
}

extension DirectoryExt on Directory {
  Future<void> ensureExists() async {
    if (!await exists()) {
      await create(recursive: true);
    }
  }
}

extension SlideX on Slide {
  String toMarkdown() {
    final buffer = StringBuffer();

    final options = this.options?.toMap();

    buffer.writeln('---');
    if (options != null && options.isNotEmpty) {
      buffer.write(YamlWriter().write(options));
    }
    buffer.writeln('---');

    buffer.writeln(markdown);

    return buffer.toString();
  }
}
