import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../components/atoms/loading_indicator.dart';
import '../common/helpers/constants.dart';
import 'deck_configuration.dart';
import 'deck_options.dart';

final _localDataStore = LocalAssetDataStoreImpl(
  SuperdeckConfig(),
  fileReader: rootBundle.loadString,
);
final _fileSystemDataStore = FileSystemDataStoreImpl(SuperdeckConfig());

class DeckControllerBuilder extends StatelessWidget {
  final DeckOptions options;
  const DeckControllerBuilder({
    super.key,
    required this.builder,
    required this.options,
  });

  final Widget Function(DeckController controller) builder;

  Widget _buildSnapshot(
    BuildContext context,
    AsyncSnapshot<List<Slide>> snapshot,
  ) {
    Widget current;
    if (snapshot.hasData) {
      current = _DeckControllerProvider(
        options: options,
        slides: snapshot.requireData,
        builder: builder,
      );
    } else if (snapshot.hasError) {
      current = Center(
        child: Text('Error loading presentation ${snapshot.error}'),
      );
    } else {
      current = const SizedBox.shrink();
    }
    return Stack(
      children: [
        current,
        LoadingOverlay(
          isLoading: snapshot.connectionState == ConnectionState.waiting,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dataStore = kCanRunProcess ? _fileSystemDataStore : _localDataStore;
    if (dataStore is FileSystemDataStoreImpl) {
      return StreamBuilder(
        stream: dataStore.watchSlides(),
        builder: _buildSnapshot,
      );
    } else {
      return FutureBuilder(
        future: dataStore.loadSlides(),
        builder: _buildSnapshot,
      );
    }
  }
}

class _DeckControllerProvider extends StatefulWidget {
  const _DeckControllerProvider({
    required this.options,
    required this.slides,
    required this.builder,
  });

  final DeckOptions options;
  final List<Slide> slides;
  final Widget Function(DeckController controller) builder;
  @override
  State<_DeckControllerProvider> createState() =>
      _DeckControllerProviderState();
}

class _DeckControllerProviderState extends State<_DeckControllerProvider> {
  late final DeckController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DeckController.build(
      slides: widget.slides,
      options: widget.options,
    );
  }

  @override
  void didUpdateWidget(_DeckControllerProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    final slidesChanged = listEquals(
      widget.slides,
      oldWidget.slides,
    );
    final optionsChanged = widget.options != oldWidget.options;
    if (slidesChanged || optionsChanged) {
      _controller.update(
        slides: widget.slides,
        options: widget.options,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.provide(
      child: widget.builder(_controller),
    );
  }
}
