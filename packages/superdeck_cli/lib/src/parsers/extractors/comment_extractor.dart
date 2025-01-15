abstract class ICommentExtractor {
  List<String> parseComments(String content);
}

class HtmlCommentExtractor implements ICommentExtractor {
  static final _commentRegex = RegExp(r'<!--(.*?)-->', dotAll: true);
  const HtmlCommentExtractor();
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
