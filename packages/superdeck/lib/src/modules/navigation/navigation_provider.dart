import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../common/helpers/provider.dart';
import '../deck/deck_configuration.dart';
import 'navigation_controller.dart';

class NavigationProviderBuilder extends StatefulWidget {
  final Widget Function(GoRouter router) builder;
  const NavigationProviderBuilder({
    super.key,
    required this.configuration,
    required this.builder,
  });

  final DeckConfiguration configuration;

  @override
  State<NavigationProviderBuilder> createState() =>
      _NavigationProviderBuilderState();
}

class _NavigationProviderBuilderState extends State<NavigationProviderBuilder> {
  late final NavigationController _navigationController;

  @override
  void initState() {
    super.initState();

    _navigationController = NavigationController(
      slides: widget.configuration.slides,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _navigationController.dispose();
  }

  @override
  void didUpdateWidget(NavigationProviderBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.configuration != oldWidget.configuration) {
      final slidesChanged = listEquals(
        widget.configuration.slides,
        oldWidget.configuration.slides,
      );
      if (slidesChanged) {
        _navigationController.updateSlides(
          widget.configuration.slides,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      value: _navigationController,
      child: ListenableBuilder(
        listenable: _navigationController,
        builder: (context, _) {
          return widget.builder(
            _navigationController.router,
          );
        },
      ),
    );
  }
}
