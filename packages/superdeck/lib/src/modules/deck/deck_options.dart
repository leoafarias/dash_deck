import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/widgets.dart';

import '../common/styles/style.dart';
import '../slide/slide_parts.dart';

part 'deck_options.mapper.dart';

@MappableClass()
class DeckOptions with DeckOptionsMappable {
  final DeckStyle baseStyle;
  final Map<String, DeckStyle> styles;
  final Map<String, WidgetBlockBuilder> widgets;
  final SlideParts parts;
  final bool debug;

  const DeckOptions({
    this.baseStyle = const DeckStyle(),
    this.styles = const <String, DeckStyle>{},
    this.widgets = const <String, WidgetBlockBuilder>{},
    this.parts = const SlideParts(),
    this.debug = false,
  });
}

typedef WidgetBlockBuilder = Widget Function(
  Map<String, dynamic> args,
);
