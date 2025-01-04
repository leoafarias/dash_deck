import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../components/atoms/loading_indicator.dart';
import '../common/helpers/constants.dart';

class PresentationLoaderBuilder extends StatefulWidget {
  const PresentationLoaderBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(List<Slide> slides) builder;

  @override
  State createState() => _PresentationLoaderBuilderState();
}

class _PresentationLoaderBuilderState extends State<PresentationLoaderBuilder> {
  final _deckRepository = DeckRepository(
    decoder: (String contents) => compute(jsonDecode, contents),
    assetLoader: (String path) {
      return kCanRunProcess
          ? File(path).readAsString()
          : rootBundle.loadString(path);
    },
  );

  @override
  Widget build(BuildContext context) {
    Widget buildSnapshot(
        BuildContext context, AsyncSnapshot<List<Slide>> snapshot) {
      return Stack(
        children: [
          if (snapshot.hasData) widget.builder(snapshot.requireData),
          if (snapshot.hasError)
            Center(
              child: Text('Error loading presentation ${snapshot.error}'),
            ),
          LoadingOverlay(
            isLoading: snapshot.connectionState == ConnectionState.waiting,
          ),
        ],
      );
    }

    if (kCanRunProcess) {
      return StreamBuilder(
        stream: _deckRepository.watch(),
        builder: buildSnapshot,
      );
    } else {
      return FutureBuilder(
        future: _deckRepository.loadSlides(),
        builder: buildSnapshot,
      );
    }
  }

  // return StreamBuilder(
  //     stream: _deckRepository.watch(),
  //     builder: (context, snapshot) {
  //       return Stack(
  //         children: [
  //           if (snapshot.hasData) widget.builder(snapshot.requireData),
  //           if (snapshot.hasError)
  //             Center(
  //               child: Text('Error loading presentation ${snapshot.error}'),
  //             ),
  //           LoadingOverlay(
  //             isLoading: snapshot.connectionState == ConnectionState.waiting,
  //           ),
  //         ],
  //       );
  //     });
}
