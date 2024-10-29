import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../../superdeck.dart';
import '../common/helpers/async_value.dart';
import 'deck_service.dart';

bool _isDebug = false;

class DeckController extends Controller {
  final _referenceService = DeckReferenceService();
  Map<String, DeckStyle> _styles = {};
  Map<String, WidgetBuilderWithOptions> _widgets = {};

  DeckStyle _baseStyle = DeckStyle();
  FixedSlidePart? _header;
  FixedSlidePart? _footer;
  SlidePart? _background;
  late List<SlideData> _slides = [];

  AsyncValue<ReferenceDto> asyncData = const AsyncValue.loading();

  /// Creates a [DeckController] with the given styles and examples.
  ///
  /// The [_styles] map contains named [Style] instances that can be retrieved
  /// with [getStyle]. The [_baseStyle] is merged with the default style.
  /// The [_widgets] map contains named widget builders for example slides.
  DeckController({
    required Map<String, DeckStyle> styles,
    required DeckStyle baseStyle,
    required Map<String, WidgetBuilderWithOptions> widgets,
    FixedSlidePart? header,
    FixedSlidePart? footer,
    SlidePart? background,
  })  : _footer = footer,
        _header = header,
        _background = background,
        _styles = styles,
        _baseStyle = baseStyle,
        _widgets = widgets {
    loadReferences();

    _referenceService.listen(loadReferences);
  }

  void update({
    DeckStyle? baseStyle,
    Map<String, DeckStyle>? styles,
    Map<String, WidgetBuilderWithOptions>? examples,
    FixedSlidePart? header,
    FixedSlidePart? footer,
    SlidePart? background,
  }) {
    bool hasChanged = false;

    if (baseStyle != null && _baseStyle != baseStyle) {
      _baseStyle = baseStyle;
      hasChanged = true;
    }

    if (header != null && _header != header) {
      _header = header;
      hasChanged = true;
    }

    if (footer != null && _footer != footer) {
      _footer = footer;
      hasChanged = true;
    }

    if (styles != null && _styles != styles) {
      _styles = styles;
      hasChanged = true;
    }

    if (examples != null && _widgets != examples) {
      _widgets = examples;
      hasChanged = true;
    }

    if (background != null && _background != background) {
      _background = background;
      hasChanged = true;
    }

    if (hasChanged) {
      notifyListeners();
    }
  }

  double get totalPartsHeight {
    final headerHeight = _header?.height ?? 0;
    final footerHeight = _footer?.height ?? 0;

    return headerHeight + footerHeight;
  }

  /// Whether reference data is currently being loaded.
  bool get isLoading => asyncData.isLoading;

  /// Whether reference data is being refreshed after a change.
  bool get isRefreshing => asyncData.isRefreshing;

  /// Whether an error occurred while loading reference data.
  bool get hasError => asyncData.hasError;

  /// Whether reference data has been successfully loaded.
  bool get hasData => _slides.isNotEmpty;

  /// The list of slides in the loaded reference data.
  List<SlideData> get slides => _slides;

  /// Retrieves the [Style] registered with the given [name].
  ///
  /// If no match is found, returns the default [_baseStyle].
  Style _buildSlideStyle(String? name) {
    final style = _baseStyle.build().merge(_styles[name]?.build());
    return _isDebug ? style.applyVariant(const Variant('debug')) : style;
  }

  /// Retrieves the [WidgetBuilderWithOptions] registered with the given [name].
  ///
  /// If no match is found, returns null.
  WidgetBuilderWithOptions? getWidget(String name) {
    return _widgets[name];
  }

  Future<void> loadReferences() async {
    try {
      asyncData = asyncData.copyWith(status: AsyncStatus.loading);
      notifyListeners();
      final data = await _referenceService.loadReference();
      asyncData = asyncData.copyWith(
        status: AsyncStatus.sucess,
        data: data,
      );

      final slides = <SlideData>[];
      for (var i = 0; i < data.slides.length; i++) {
        final slide = data.slides[i];
        final slideStyle = slide.options?.style;
        final configuration = SlideData(
          slide: slide,
          slideIndex: i,
          header: _header,
          footer: _footer,
          background: _background,
          style: _buildSlideStyle(slideStyle),
        );

        slides.add(configuration);
      }
      _slides = slides;
    } catch (error, stackTrace) {
      asyncData = AsyncValue.error(error, stackTrace);
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();

    _referenceService.stop();
  }
}

typedef WidgetBuilderWithOptions = Widget Function(
  BuildContext context,
  WidgetBlock options,
);
