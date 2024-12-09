import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_core/superdeck_core.dart';

class SdMarkdownParsingException implements Exception {
  final SchemaValidationException exception;
  final int slideLocation;

  SdMarkdownParsingException(this.exception, this.slideLocation);

  String get location => exception.result.path.join(' | ');

  List<String> get messages {
    return exception.result.errors.map((e) => e.message).toList();
  }
}

class SdTaskException implements Exception {
  final int slideIndex;
  final String taskName;
  final TaskContext controller;
  final Exception exception;

  SdTaskException(
    this.taskName,
    this.controller,
    this.exception,
    this.slideIndex,
  );

  String get message {
    return 'Error running task on slide $slideIndex';
  }

  @override
  String toString() => message;
}

class SdFormatException implements Exception {
  final String message;
  final int? offset;
  final String source;

  SdFormatException(
    this.message, [
    this.source = '',
    this.offset,
  ]);

  int? get lineNumber {
    return source.substring(0, offset).split('\n').length;
  }

  String? get lineContent {
    return source.split('\n')[lineNumber! - 1];
  }

  int? get columnNumber {
    final lines = source.split('\n');
    int totalOffset = 0;

    for (int i = 0; i < lineNumber! - 1; i++) {
      // +1 for the newline character
      totalOffset += lines[i].length + 1;
    }

    // Convert zero-based index to one-based
    return offset! - totalOffset + 1;
  }

  @override
  String toString() {
    return message;
  }
}
