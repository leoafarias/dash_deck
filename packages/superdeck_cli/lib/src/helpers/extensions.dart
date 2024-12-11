import 'dart:io';

import 'package:args/command_runner.dart';
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

extension CommandExtension on Command {
  /// Checks if the command-line option named [name] was parsed,
  /// safely handling null argResults.
  bool wasParsed(String name) => argResults?.wasParsed(name) ?? false;

  /// Gets the parsed command-line option named [name] as `bool`.
  bool boolArg(String name) => argResults?[name] == true;

  /// Gets the parsed command-line option named [name] as `String`,
  /// handles null and empty strings without relying on a 'null' literal.
  String? stringArg(String name) {
    final arg = argResults?[name];
    if (arg is! String || arg.isEmpty || arg == 'null') {
      return null;
    }

    return arg;
  }

  /// Gets the parsed command-line option named [name] as `int`,
  /// converting a parsed string if available.
  int? intArg(String name) {
    final value = stringArg(name);

    return (value == null) ? null : int.tryParse(value);
  }

  /// Gets the parsed command-line option named [name] as `List<String>`,
  /// and ensures a non-null, typed list is returned.
  List<String> stringsArg(String name) {
    final arg = argResults?[name];
    if (arg is List) {
      return arg.whereType<String>().toList();
    }

    return [];
  }
}
