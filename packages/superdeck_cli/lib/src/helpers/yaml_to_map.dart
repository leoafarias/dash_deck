import 'package:superdeck_cli/src/helpers/short_hash_id.dart';
import 'package:superdeck_core/superdeck_core.dart';

final _frontMatterRegex = RegExp(r'---([\s\S]*?)---');

({String content, String key, Map<String, dynamic> options}) parseSlideMarkdown(
  String slideContents,
) {
  final frontMatter =
      _frontMatterRegex.firstMatch(slideContents)?.group(1) ?? '';
  final options = convertYamlToMap(frontMatter);

  final content = slideContents
      .substring(_frontMatterRegex.matchAsPrefix(slideContents)?.end ?? 0)
      .trim();

  return (
    content: content,
    options: options,
    key: shortHashId(slideContents),
  );
}
