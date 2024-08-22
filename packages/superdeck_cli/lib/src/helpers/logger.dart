import 'package:mason_logger/mason_logger.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';

final logger = Logger(
  // Optionally, specify a log level (defaults to Level.info).
  level: Level.info,
  // Optionally, specify a custom `LogTheme` to override log styles.
  theme: LogTheme(),
);

extension LoggerX on Logger {
  void formatError(SDFormatException exception) {
    final message = exception.message;
    final source = exception.source;

    final arrow = _createArrow(exception.columnNumber ?? 0);

    final splitLines = source.split('\n');

    // Get the longes line
    final longestLine = splitLines.fold<int>(0, (prev, element) {
      return element.length > prev ? element.length : prev;
    });

    String padline(String line) {
      return '  ' + line.padRight(longestLine + 2);
    }

    // Print the error message with the source code
    newLine();
    alert('Formatting Error:');
    newLine();
    err('$message on line ${exception.lineNumber}, column ${exception.columnNumber}');
    newLine();
    _formatCodeBlock(padline(''));

    final exceptionLineNumber = exception.lineNumber ?? 0;

    // Calculate only 4 lines before and after the error line
    final start = (exceptionLineNumber - 5).clamp(0, splitLines.length);
    final end = (exceptionLineNumber + 5).clamp(0, splitLines.length);

    for (int i = 0; i < splitLines.length; i++) {
      final lineNumber = i + 1;
      final currentLineContent = splitLines[i];
      final isErrorLine = lineNumber == exception.lineNumber;

      if (lineNumber < start || lineNumber > end) {
        continue;
      }

      if (isErrorLine) {
        info(padline(currentLineContent), style: _highlightLine);
        info(padline(arrow), style: _highlightLine);
      } else {
        _formatCodeBlock(padline(currentLineContent));
      }
    }
  }

  void _formatCodeBlock(String message) {
    info(message, style: _formatErrorStyle);
  }

  void newLine() => info('');
}

String _createArrow(int column) {
  return ' ' * (column - 1) + '^';
}

String? _formatErrorStyle(String? m) {
  return backgroundLightGray.wrap(styleBold.wrap(black.wrap(m)));
}

String? _highlightLine(String? m) {
  return backgroundRed.wrap(styleBold.wrap(black.wrap(m)));
}
