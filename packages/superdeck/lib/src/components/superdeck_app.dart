import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../modules/common/helpers/controller.dart';
import '../modules/common/helpers/theme.dart';
import '../modules/common/initializer_provider.dart';
import '../modules/common/styles/style.dart';
import '../modules/presentation/presentation_controller.dart';
import '../modules/presentation/presentation_loader.dart';
import '../modules/slide/slide_parts.dart';

class SuperDeckApp extends StatelessWidget {
  const SuperDeckApp({
    super.key,
    this.baseStyle,
    this.styles = const <String, DeckStyle>{},
    this.widgets = const <String, WidgetBuilderWithOptions>{},
    this.header,
    this.footer,
    this.background,
  });

  final DeckStyle? baseStyle;
  final Map<String, WidgetBuilderWithOptions> widgets;
  final Map<String, DeckStyle> styles;
  final FixedSlidePartWidget? header;
  final FixedSlidePartWidget? footer;
  final SlidePartWidget? background;

  static Future<void> initialize() async {
    await initializeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PresentationLoaderBuilder(
      builder: (data) {
        return SuperDeckProvider(
          slides: data,
          config: DeckConfiguration(
            baseStyle: baseStyle ?? const DeckStyle(),
            styles: styles,
            widgets: widgets,
            header: header,
            footer: footer,
            background: background,
          ),
        );
      },
    );
  }
}

class SuperDeckProvider extends StatefulWidget {
  const SuperDeckProvider({
    super.key,
    this.slides = const [],
    required this.config,
  });

  final List<Slide> slides;
  final DeckConfiguration config;

  @override
  State<SuperDeckProvider> createState() => _SuperDeckProviderState();
}

class _SuperDeckProviderState extends State<SuperDeckProvider> {
  late final DeckController _presentation;

  @override
  void initState() {
    super.initState();

    _presentation = DeckController(
      options: widget.config,
      slides: widget.slides,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _presentation.dispose();
  }

  @override
  void didUpdateWidget(SuperDeckProvider oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!listEquals(
          widget.slides,
          oldWidget.slides,
        ) ||
        widget.config != oldWidget.config) {
      _presentation.update(
        slides: widget.slides,
        configuration: widget.config,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      data: _presentation,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Superdeck',
        routerConfig: _presentation.goRouter,
        theme: theme,
      ),
    );
  }
}
