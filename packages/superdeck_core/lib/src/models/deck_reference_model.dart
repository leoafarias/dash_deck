import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/src/models/slide_model.dart';

part 'deck_reference_model.mapper.dart';

@MappableClass()
class DeckReferenceModel with DeckReferenceModelMappable {
  final List<Slide> slides;

  DeckReferenceModel({
    required this.slides,
  });

  static const fromMap = DeckReferenceModelMapper.fromMap;
  static const fromJson = DeckReferenceModelMapper.fromJson;
}
