import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'slide_model.mapper.dart';

@MappableClass()
class Slide with SlideMappable {
  final String key;
  final SlideOptions? options;
  final String markdown;
  final List<SectionElement> sections;
  final List<String> comments;

  const Slide({
    required this.key,
    this.options,
    required this.markdown,
    this.sections = const [],
    this.comments = const [],
  });

  static final schema = Schema.object(
    {
      "key": Schema.string(),
      "markdown": Schema.string(),
      "title": Schema.string(),
      'options': SlideOptions.schema,
      'sections': Schema.list(SectionElement.schema),
      'comments': Schema.list(Schema.string()),
    },
    required: ['key', 'markdown'],
    additionalProperties: true,
  );

  static Slide parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return SlideMapper.fromMap(map);
  }

  factory Slide.noSlides() => Slide(
        key: 'empty',
        markdown: 'No slides found',
        sections: [
          SectionElement(
            blocks: [
              ContentElement(
                'No slides found',
              ),
            ],
          ),
        ],
      );
}

@MappableClass(
  hook: UnmappedPropertiesHook('args'),
)
class SlideOptions with SlideOptionsMappable {
  final String? title;
  final String? style;
  final Map<String, Object?> args;

  const SlideOptions({
    this.title,
    this.style,
    this.args = const {},
  });

  static SlideOptions parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return SlideOptionsMapper.fromMap(map);
  }

  static final schema = Schema.object(
    {
      "title": Schema.string(),
      "style": Schema.string(),
    },
    additionalProperties: true,
  );
}
