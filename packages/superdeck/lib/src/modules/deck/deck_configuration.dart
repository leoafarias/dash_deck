import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/widgets.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../common/helpers/provider.dart';
import '../common/styles/style.dart';
import 'deck_options.dart';
import 'slide_configuration.dart';

part 'deck_configuration.mapper.dart';

@MappableClass()
class DeckConfiguration with DeckConfigurationMappable {
  final DeckOptions options;
  final List<SlideConfiguration> slides;

  DeckConfiguration({
    required this.options,
    required this.slides,
  });

  factory DeckConfiguration.build({
    required List<Slide> slides,
    required DeckOptions options,
  }) {
    return DeckConfiguration(
      options: options,
      slides: _buildSlides(
        slides: slides,
        options: options,
      ),
    );
  }

  static DeckConfiguration of(BuildContext context) {
    return InheritedData.of<DeckConfiguration>(context);
  }

  static Widget captureAsExporting(BuildContext context, Widget child) {
    final configuration = of(context);
    final newConfiguration = configuration.copyWith(
      slides: configuration.slides.map((slide) {
        return slide.copyWith(
          isExporting: true,
        );
      }).toList(),
    );
    return InheritedData(
      data: newConfiguration,
      child: child,
    );
  }
}

List<SlideConfiguration> _buildSlides({
  required List<Slide> slides,
  required DeckOptions options,
}) {
  return slides.mapIndexed((index, slide) {
    return _convertSlide(
      slideIndex: index,
      slide: slide,
      options: options,
    );
  }).toList();
}

SlideConfiguration _convertSlide({
  required int slideIndex,
  required Slide slide,
  required DeckOptions options,
}) {
  final widgetBlocks = slide.sections
      .expand((section) => section.blocks)
      .whereType<WidgetBlock>();

  final slideWidgets = <String, WidgetBuilderWithOptions>{};

  for (final block in widgetBlocks) {
    final widgetBuilder = options.widgets[block.type];
    if (widgetBuilder != null) {
      slideWidgets[block.name] = widgetBuilder;
    }
  }
  return SlideConfiguration(
    slideIndex: slideIndex,
    style: _buildSlideConfigurationStyle(
      name: slide.options?.style,
      baseStyle: options.baseStyle,
      styles: options.styles,
      debug: options.debug,
    ),
    slide: slide,
    debug: options.debug,
    parts: options.parts,
    widgets: slideWidgets,
  );
}

/// Retrieves the [Style] registered with the given [name].
///
/// If no match is found, returns the default [_baseStyle].
Style _buildSlideConfigurationStyle({
  required String? name,
  required DeckStyle baseStyle,
  required Map<String, DeckStyle> styles,
  required bool debug,
}) {
  final style = baseStyle.build().merge(styles[name]?.build());
  return debug ? style.applyVariant(const Variant('debug')) : style;
}

typedef WidgetBuilderWithOptions = Widget Function(
  BuildContext context,
  WidgetBlock options,
);
