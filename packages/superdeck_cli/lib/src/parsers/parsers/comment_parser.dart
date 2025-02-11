import 'dart:convert';

import 'package:petitparser/petitparser.dart';
import 'package:superdeck_cli/src/parsers/parsers/base_parser.dart';
import 'package:superdeck_cli/src/parsers/parsers/grammar_definitions.dart';

class CommentParser extends BaseParser<List<String>> {
  const CommentParser();

  @override
  List<String> parse(String content) {
    final htmlCommentParser = HtmlCommentDefinition().build<String>();
    final lines = LineSplitter().convert(content);
    final comments = <String>[];
    for (var line in lines) {
      final comment = htmlCommentParser.parse(line);

      if (comment is Success) {
        comments.add(comment.value);
      }
    }

    return comments;
  }
}
