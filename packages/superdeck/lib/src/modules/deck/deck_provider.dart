import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:superdeck/src/modules/common/helpers/provider.dart';
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

class DeckProviderBuilder extends StatefulWidget {
  final DeckOptions options;
  const DeckProviderBuilder({
    super.key,
    required this.builder,
    required this.options,
  });

  final Widget Function(DeckConfiguration configuration) builder;

  @override
  State createState() => _DeckProviderBuilderState();
}

class _DeckProviderBuilderState extends State<DeckProviderBuilder> {
  final _dataStore = kCanRunProcess ? _fileSystemDataStore : _localDataStore;

  Widget _buildSnapshot(
    BuildContext context,
    AsyncSnapshot<List<Slide>> snapshot,
  ) {
    Widget current;
    if (snapshot.hasData) {
      final configuration = DeckConfiguration.build(
        slides: snapshot.requireData,
        options: widget.options,
      );
      current = Provider(
        value: configuration,
        child: widget.builder(configuration),
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
    if (_dataStore is FileSystemDataStoreImpl) {
      return StreamBuilder(
        stream: _dataStore.watchSlides(),
        builder: _buildSnapshot,
      );
    } else {
      return FutureBuilder(
        future: _dataStore.loadSlides(),
        builder: _buildSnapshot,
      );
    }
  }
}
