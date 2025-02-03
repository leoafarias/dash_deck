import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:superdeck/src/components/atoms/async_snapshot_widget.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../components/atoms/loading_indicator.dart';
import '../common/helpers/constants.dart';
import 'deck_controller.dart';
import 'deck_options.dart';

class _RootBundleDataStore extends LocalDataStore {
  _RootBundleDataStore(super.configuration);

  @override
  Future<String> fileReader(String path) async {
    return rootBundle.loadString(path);
  }
}

class DeckControllerBuilder extends StatelessWidget {
  final DeckOptions options;

  const DeckControllerBuilder({
    super.key,
    required this.builder,
    required this.options,
  });

  final Widget Function(DeckController controller) builder;

  Future<DeckConfiguration> _loadConfiguration() async {
    final file = DeckConfiguration.defaultFile;

    if (await file.exists()) {
      final contents = await YamlUtils.loadYamlFile(file);
      if (contents.isNotEmpty) {
        return DeckConfiguration.parse(contents);
      }
    }

    return DeckConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DeckConfiguration>(
      future: _loadConfiguration(),
      builder: (context, snapshot) {
        return AsyncSnapshotWidget(
          snapshot: snapshot,
          builder: (configuration) {
            final dataStore = kCanRunProcess
                ? FileSystemDataStore(configuration)
                : _RootBundleDataStore(configuration);
            return StreamBuilder<DeckReference>(
              stream: dataStore.loadDeckReferenceStream(),
              builder: (context, snapshot) {
                return AsyncSnapshotWidget(
                  snapshot: snapshot,
                  builder: (reference) {
                    return Stack(
                      children: [
                        _DeckControllerProvider(
                          options: options,
                          reference: snapshot.requireData,
                          builder: builder,
                          dataStore: dataStore,
                        ),
                        LoadingOverlay(
                          isLoading: snapshot.connectionState ==
                              ConnectionState.waiting,
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class _DeckControllerProvider extends StatefulWidget {
  const _DeckControllerProvider({
    required this.options,
    required this.reference,
    required this.builder,
    required this.dataStore,
  });

  final DeckOptions options;
  final DeckReference reference;
  final Widget Function(DeckController controller) builder;
  final IDataStore dataStore;
  @override
  State<_DeckControllerProvider> createState() =>
      _DeckControllerProviderState();
}

class _DeckControllerProviderState extends State<_DeckControllerProvider> {
  late final DeckController controller;

  @override
  void initState() {
    super.initState();
    controller = DeckController.build(
      slides: widget.reference.slides,
      options: widget.options,
      dataStore: widget.dataStore,
    );
  }

  @override
  void didUpdateWidget(_DeckControllerProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    final referenceChanged = widget.reference != oldWidget.reference;
    final optionsChanged = widget.options != oldWidget.options;
    if (referenceChanged || optionsChanged) {
      controller.update(
        slides: widget.reference.slides,
        options: widget.options,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return controller.provide(
      child: widget.builder(controller),
    );
  }
}
