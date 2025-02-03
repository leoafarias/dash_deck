import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/widgets.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../common/styles/style.dart';
import '../slide/slide_parts.dart';
import 'deck_controller.dart';

part 'deck_options.mapper.dart';

@MappableClass()
class DeckOptions with DeckOptionsMappable {
  final DeckStyle baseStyle;
  final Map<String, DeckStyle> styles;
  final Map<String, WidgetBuilderWithOptions> widgets;
  final SlideParts parts;
  final bool debug;

  const DeckOptions({
    this.baseStyle = const DeckStyle(),
    this.styles = const <String, DeckStyle>{},
    this.widgets = const <String, WidgetBuilderWithOptions>{},
    this.parts = const SlideParts(),
    this.debug = false,
  });
}
