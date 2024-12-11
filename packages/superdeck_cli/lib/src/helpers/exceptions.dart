// ignore_for_file: avoid-duplicate-cascades

import 'package:source_span/source_span.dart';
import 'package:superdeck_cli/src/helpers/logger.dart';

sealed class SDException implements Exception {}

class SDTaskException implements SDException {
  final int slideIndex;
  final String taskName;

  final Exception exception;

  const SDTaskException(this.taskName, this.exception, this.slideIndex);

  String get message {
    return 'Error running task on slide $slideIndex';
  }

  @override
  String toString() => message;
}

class SDFormatException extends SourceSpanFormatException {
  SDFormatException(super.message, super.span, [super.source]);
}

void printException(Exception e) {
  if (e is SDTaskException) {
    logger
      ..err('slide: ${e.slideIndex}')
      ..err('Task error: ${e.taskName}');

    printException(e.exception);
  } else if (e is SDFormatException) {
    logger.formatError(e);
  } else {
    logger.err(e.toString());
  }
}
