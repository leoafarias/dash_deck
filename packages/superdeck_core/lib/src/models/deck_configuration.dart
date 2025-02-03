import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:path/path.dart' as p;

import '../helpers/mappers.dart';
import '../schema/schema.dart';

part 'deck_configuration.mapper.dart';

@MappableClass(includeCustomMappers: [DirectoryMapper(), FileMapper()])
class DeckConfiguration with DeckConfigurationMappable {
  late final Directory assetDir;
  late final File deckFile;
  late final Directory generatedDir;
  late final File markdownFile;

  DeckConfiguration({
    Directory? assetDir,
    File? deckFile,
    Directory? generatedDir,
    File? markdownFile,
  }) {
    this.assetDir = assetDir ?? Directory(p.join('.superdeck'));
    this.deckFile = deckFile ?? File(p.join(this.assetDir.path, 'slides.json'));
    this.generatedDir = generatedDir ??
        Directory(
          p.join(this.assetDir.path, 'generated'),
        );
    this.markdownFile = markdownFile ?? File('slides.md');
  }

  static DeckConfiguration parse(Map<String, dynamic> map) {
    schema.validateOrThrow(map);
    return DeckConfigurationMapper.fromMap(map);
  }

  static final schema = Schema.object(
    {
      'assetDir': Schema.string(),
      'deckFile': Schema.string(),
      'generatedDir': Schema.string(),
      'markdownFile': Schema.string(),
    },
  );

  static File get defaultFile => File('superdeck.yaml');
}
