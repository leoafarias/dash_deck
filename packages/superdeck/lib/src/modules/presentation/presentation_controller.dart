import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../../superdeck.dart';
import '../../components/molecules/slide_screen.dart';
import '../common/helpers/routes.dart';

part 'presentation_controller.mapper.dart';

@MappableClass()
class DeckConfiguration with DeckConfigurationMappable {
  final bool debug;
  final Map<String, DeckStyle> styles;
  final DeckStyle baseStyle;
  final Map<String, WidgetBuilderWithOptions> widgets;
  final FixedSlidePartWidget? header;
  final FixedSlidePartWidget? footer;
  final SlidePartWidget? background;

  const DeckConfiguration({
    this.styles = const {},
    this.baseStyle = const DeckStyle(),
    this.widgets = const {},
    this.header,
    this.footer,
    this.background,
    this.debug = false,
  });

  static const fromMap = DeckConfigurationMapper.fromMap;
}

class DeckController extends Controller {
  DeckConfiguration _configuration;
  late List<SlideData> _slides;
  bool _isMenuOpen;
  bool _showNotes;
  int _currentSlideIndex = 0;
  late GoRouter _router;

  /// Creates a [DeckController] with the given styles and examples.
  ///
  /// The [_styles] map contains named [Style] instances that can be retrieved
  /// with [getStyle]. The [_baseStyle] is merged with the default style.
  /// The [_widgets] map contains named widget builders for example slides.
  DeckController({
    DeckConfiguration? options,
    List<Slide> slides = const [],
    bool showNotes = false,
    bool isPresenterMenuOpen = false,
    int currentSlideIndex = 0,
  })  : _configuration = options ?? const DeckConfiguration(),
        _isMenuOpen = isPresenterMenuOpen,
        _showNotes = showNotes,
        _currentSlideIndex = currentSlideIndex {
    _slides = _buildSlides(_configuration, slides);
    _router = _buildRouter(_slides);

    _router.routeInformationProvider.addListener(() {
      final uri = _router.routeInformationProvider.value.uri;

      final pathParam = uri.queryParameters[SDPaths.slides.slide.id] ?? '0';
      final slideIndex = int.tryParse(pathParam) ?? 0;

      print('Slide index: $slideIndex');

      if (slideIndex != _currentSlideIndex) {
        _currentSlideIndex = slideIndex;
      }
    });
  }

  GoRouter get goRouter => _router;

  void update({
    DeckConfiguration? configuration,
    List<Slide>? slides,
    bool? showNotes,
    bool? isPresenterMenuOpen,
  }) {
    final previousSlides = _slides;
    _configuration = configuration ?? _configuration;
    if (slides != null) {
      _slides = _buildSlides(_configuration, slides);
      if (slides.length != previousSlides.length) {
        _router = _buildRouter(_slides);
        if (_currentSlideIndex >= _slides.length) {
          goToSlide(_slides.length - 1);
        }
      }
    }

    _showNotes = showNotes ?? _showNotes;
    _isMenuOpen = isPresenterMenuOpen ?? _isMenuOpen;

    notifyListeners();
  }

  late final slides = _slides;

  bool get isMenuOpen => _isMenuOpen;

  bool get isNotesShown => _showNotes;

  int get currentPage => _currentSlideIndex + 1;

  DeckConfiguration get configuration => _configuration;

  int get slideCount => _slides.length;

  SlideData get currentSlide => _slides[_currentSlideIndex];

  void goToSlide(int index) {
    if (index < 0 || index >= slideCount) return;
    if (_currentSlideIndex == index) return;

    final isForward = index > _currentSlideIndex;
    final slidePath = SDPaths.slides.slide.define(index.toString()).path;
    _currentSlideIndex = index;

    _router.go(slidePath, extra: {'replace': !isForward});
    notifyListeners();
  }

  void nextSlide() {
    goToSlide(_currentSlideIndex + 1);
  }

  void previousSlide() {
    goToSlide(_currentSlideIndex - 1);
  }

  void toggleMenu() {
    _isMenuOpen = !_isMenuOpen;
    notifyListeners();
  }

  void closeMenu() {
    _isMenuOpen = false;
    notifyListeners();
  }

  void openMenu() {
    _isMenuOpen = true;
    notifyListeners();
  }

  void toggleNotes() {
    _showNotes = !_showNotes;
    notifyListeners();
  }

  void hideNotes() {
    _showNotes = false;
    notifyListeners();
  }

  void showNotes() {
    _showNotes = true;
    notifyListeners();
  }

  double get totalPartsHeight {
    final headerHeight = _configuration.header?.height ?? 0;
    final footerHeight = _configuration.footer?.height ?? 0;

    return headerHeight + footerHeight;
  }

  List<SlideData> _buildSlides(
    DeckConfiguration configuration,
    List<Slide> slides,
  ) {
    return slides.mapIndexed((index, slide) {
      return _convertSlide(
        index,
        slide,
        configuration,
        slides.length,
      );
    }).toList();
  }

  SlideData _convertSlide(
    int slideIndex,
    Slide slide,
    DeckConfiguration configuration,
    int totalSlideCount,
  ) {
    final widgetBlocks = slide.sections
        .expand((section) => section.blocks)
        .whereType<WidgetBlock>();

    final slideWidgets = <String, WidgetBuilderWithOptions>{};

    for (final block in widgetBlocks) {
      final widgetBuilder = configuration.widgets[block.name];
      if (widgetBuilder != null) {
        slideWidgets[block.key] = widgetBuilder;
      }
    }
    return SlideData(
      slideIndex: slideIndex,
      style: _buildSlideStyle(slide.options?.style, configuration),
      slide: slide,
      header: configuration.header,
      footer: configuration.footer,
      background: configuration.background,
      widgets: slideWidgets,
      totalSlideCount: totalSlideCount,
    );
  }
}

/// Retrieves the [Style] registered with the given [name].
///
/// If no match is found, returns the default [_baseStyle].
Style _buildSlideStyle(String? name, DeckConfiguration configuration) {
  final style = configuration.baseStyle
      .build()
      .merge(configuration.styles[name]?.build());
  return configuration.debug
      ? style.applyVariant(const Variant('debug'))
      : style;
}

typedef WidgetBuilderWithOptions = Widget Function(
  BuildContext context,
  WidgetBlock options,
);

final kRootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

GoRouter _buildRouter(List<SlideData> slides) {
  return GoRouter(
    navigatorKey: kRootNavigatorKey,
    initialLocation: SDPaths.root.path,
    redirect: (context, state) => SDPaths.slides.slide.define('0').path,
    restorationScopeId: 'root',
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: kRootNavigatorKey,
        builder: (context, state, child) => AppShell(child: child),
        routes: slides.mapIndexed((index, slide) {
          return GoRoute(
            path: SDPaths.slides.slide.define(index.toString()).path,
            pageBuilder: (context, state) {
              return getPageTransition(
                SlideScreen(index),
                state,
              );
            },
          );
        }).toList(),
      ),
    ],
  );
}

CustomTransitionPage<void> getPageTransition(
  Widget child,
  GoRouterState state,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    maintainState: true,
    transitionDuration: const Duration(milliseconds: 1000),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(secondaryAnimation),
          child: child,
        ),
      );
    },
  );
}
