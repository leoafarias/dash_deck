abstract class NotesExtractor {
  List<String> extract(String content);
}

class HtmlCommentExtractorImpl implements NotesExtractor {
  static final _commentRegex = RegExp(r'<!--(.*?)-->', dotAll: true);
  const HtmlCommentExtractorImpl();
  @override
  List<String> extract(String content) {
    final matches = _commentRegex.allMatches(content);

    return matches
        .map((m) => m.group(1)?.trim())
        .where((c) => c != null && c.isNotEmpty)
        .cast<String>()
        .toList();
  }
}
