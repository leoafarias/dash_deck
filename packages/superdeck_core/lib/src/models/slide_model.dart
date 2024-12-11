import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'slide_model.mapper.dart';

@MappableClass()
class Slide with SlideMappable {
  final String key;
  final SlideOptions? options;
  final String markdown;
  final List<SectionBlock> sections;
  final List<String> comments;
  final List<LocalAsset> assets;

  const Slide({
    required this.key,
    this.options,
    required this.markdown,
    this.sections = const [],
    this.comments = const [],
    this.assets = const [],
  });

  static final schema = Schema.object(
    {
      "key": Schema.string(),
      "markdown": Schema.string(),
      "title": Schema.string(),
      'options': SlideOptions.schema,
      'sections': Schema.list(SectionBlock.schema),
      'comments': Schema.list(Schema.string()),
      'assets': Schema.list(LocalAsset.typeSchema),
    },
    required: ['key', 'markdown'],
    additionalProperties: true,
  );

  static Slide parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return SlideMapper.fromMap(map);
  }
}
