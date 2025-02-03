import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/superdeck_core.dart';

part 'deck_reference.mapper.dart';

@MappableRecord()
typedef DeckReference = ({
  List<Slide> slides,
  DeckConfiguration configuration,
});
