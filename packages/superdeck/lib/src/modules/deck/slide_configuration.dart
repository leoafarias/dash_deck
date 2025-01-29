import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../common/helpers/provider.dart';
import '../slide/slide_parts.dart';
import 'deck_configuration.dart';

part 'slide_configuration.mapper.dart';

@MappableClass()
class SlideConfiguration with SlideConfigurationMappable {
  final int slideIndex;
  final Style style;
  final Slide _slide;
  final bool debug;
  final SlideParts parts;
  final Map<String, WidgetBuilderWithOptions> widgets;

  SlideConfiguration({
    required this.slideIndex,
    required this.style,
    required Slide slide,
    this.debug = false,
    required this.parts,
    this.widgets = const {},
  }) : _slide = slide;

  double get totalPartsHeight {
    final headerHeight = parts.header?.preferredSize.height ?? 0;
    final footerHeight = parts.footer?.preferredSize.height ?? 0;

    return headerHeight + footerHeight;
  }

  SlideOptions get options => _slide.options ?? const SlideOptions();

  String get key => _slide.key;

  Slide get data => _slide;

  List<SectionElement> get sections => _slide.sections;

  List<String> get comments => _slide.comments;

  String get markdown => _slide.markdown;

  WidgetBuilderWithOptions? getWidget(String name) {
    return widgets[name];
  }

  static SlideConfiguration of(BuildContext context) {
    return Provider.ofType<SlideConfiguration>(context);
  }
}
