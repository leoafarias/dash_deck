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
    required DeckConfiguration configuration,
    required this.builder,
  }) : _configuration = configuration;

  final DeckConfiguration _configuration;

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
      slides: widget._configuration.slides,
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

    if (widget._configuration != oldWidget._configuration) {
      final slidesChanged = listEquals(
        widget._configuration.slides,
        oldWidget._configuration.slides,
      );
      if (slidesChanged) {
        _navigationController.updateSlides(
          widget._configuration.slides,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InheritedData(
      data: _navigationController,
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
