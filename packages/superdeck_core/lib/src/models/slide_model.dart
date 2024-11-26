import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'slide_model.mapper.dart';

@MappableClass()
class Slide with SlideMappable {
  final String key;
  final SlideOptions? options;
  final String markdown;
  final List<SectionBlock> sections;
  final List<Note> notes;
  final List<Asset> assets;

  const Slide({
    required this.key,
    this.options,
    required this.markdown,
    this.sections = const [],
    this.notes = const [],
    this.assets = const [],
  });

  static final schema = Schema.object(
    {
      "key": Schema.string.required(),
      "markdown": Schema.string.required(),
      "title": Schema.string.optional(),
      'options': SlideOptions.schema.optional(),
      // 'sections': Schema.list(SectionBlock.schema).optional(),
      // 'notes': Schema.list(Note.schema).optional(),
      // 'assets': Schema.list(Asset.schema).optional(),
    },
    additionalProperties: true,
  );

  static Slide fromMap(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return SlideMapper.fromMap(map);
  }
}

@MappableClass()
class Note with NoteMappable {
  final String content;

  Note({required this.content});

  static final schema = Schema.object(
    {
      "content": Schema.string.required(),
    },
    additionalProperties: false,
  );

  static Note fromMap(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return NoteMapper.fromMap(map);
  }
}
