import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'options_model.mapper.dart';

sealed class Options {
  final String? style;

  const Options({
    this.style,
  });

  static final schema = Schema.object(
    {
      "style": Schema.string.optional(),
    },
  );
}

@MappableClass(
  hook: UnmappedPropertiesHook('args'),
)
class SlideOptions extends Options with SlideOptionsMappable {
  final String? title;
  final Map<String, Object?> args;

  const SlideOptions({
    this.title,
    super.style,
    this.args = const {},
  });

  static SlideOptions fromMap(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return SlideOptionsMapper.fromMap(map);
  }

  static final schema = Options.schema.extend(
    {
      "title": Schema.string,
    },
    additionalProperties: true,
  );
}

// @MappableClass()
// class DeckOptions extends Options with DeckOptionsMappable {
//   final bool cacheRemoteAssets;

//   const DeckOptions({
//     required super.style,
//     this.cacheRemoteAssets = false,
//   });

//   static DeckOptions fromMap(Map<String, dynamic> map) {
//     schema.validateOrThrow(map);
//     return DeckOptionsMapper.fromMap(map);
//   }

//   static final schema = Options.schema.extend(
//     {
//       "cache_remote_assets": Schema.boolean.optional(),
//     },
//   );
// }
