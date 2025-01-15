abstract class CommentExtractor {
  List<String> parseComments(String content);
}

class HtmlCommentExtractorImpl implements CommentExtractor {
  static final _commentRegex = RegExp(r'<!--(.*?)-->', dotAll: true);
  const HtmlCommentExtractorImpl();
  @override
  List<String> parseComments(String content) {
    final matches = _commentRegex.allMatches(content);

    return matches
        .map((m) => m.group(1)?.trim())
        .where((c) => c != null && c.isNotEmpty)
        .cast<String>()
        .toList();
  }
}
