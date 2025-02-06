import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:path/path.dart' as p;

import '../helpers/mappers.dart';
import '../schema/schema.dart';

part 'deck_configuration.mapper.dart';

@MappableClass(
  includeCustomMappers: [
    DirectoryMapper(),
    FileMapper(),
  ],
)
class DeckConfiguration with DeckConfigurationMappable {
  late final Directory _superdeckDir;
  late final File deckJson;
  late final Directory generatedAssetsDir;
  late final File slidesMarkdown;
  late final File generatedAssetsRefJson;

  DeckConfiguration({
    File? slidesMarkdown,
  }) {
    _superdeckDir = Directory(p.join('.superdeck'));
    deckJson = File(p.join(_superdeckDir.path, 'superdeck.json'));
    generatedAssetsDir = Directory(p.join(_superdeckDir.path, 'assets'));
    this.slidesMarkdown = slidesMarkdown ?? File('slides.md');
    generatedAssetsRefJson =
        File(p.join(_superdeckDir.path, 'generated_assets.json'));
  }

  static DeckConfiguration parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return DeckConfigurationMapper.fromMap(map);
  }

  static final schema = Schema.object(
    {
      'slidesMarkdown': Schema.string(),
    },
  );

  static File get defaultFile => File('superdeck.yaml');
}
