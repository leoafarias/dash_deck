import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'options_model.mapper.dart';

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

  static SlideOptions fromMap(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return SlideOptionsMapper.fromMap(map);
  }

  static final schema = Schema.object(
    {
      "title": Schema.string(),
      "style": Schema.string(),
    },
    additionalProperties: false,
  );
}
