import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'slide_model.mapper.dart';

@MappableClass()
class Slide with SlideMappable {
  final String key;
  final SlideOptions? options;
  final String markdown;
  final List<SectionBlock> sections;
  final List<NoteModel> notes;
  final List<AssetModel> assets;

  const Slide({
    required this.key,
    this.options,
    required this.markdown,
    this.sections = const [],
    this.notes = const [],
    this.assets = const [],
  });

  static final schema = SchemaShape(
    {
      "key": Schema.string.required(),
      "markdown": Schema.string.required(),
      "title": Schema.string.optional(),
      'options': SlideOptions.schema.optional(),
      'sections': SchemaList(SectionBlock.schema).optional(),
      'notes': SchemaList(Schema.string).optional(),
      'assets': SchemaList(AssetModel.schema).optional(),
    },
    additionalProperties: false,
  );

  static Slide fromMap(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return SlideMapper.fromMap(map);
  }
}

@MappableClass()
class NoteModel with NoteModelMappable {
  final String content;

  NoteModel({required this.content});

  static final schema = SchemaShape(
    {
      "content": Schema.string.required(),
    },
    additionalProperties: false,
  );

  static NoteModel fromMap(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return NoteModelMapper.fromMap(map);
  }
}
