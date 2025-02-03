import 'package:flutter/material.dart';

class AsyncSnapshotWidget<T> extends StatelessWidget {
  final AsyncSnapshot<T> snapshot;
  final Widget Function(T data) builder;

  const AsyncSnapshotWidget({
    super.key,
    required this.snapshot,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return switch (snapshot.connectionState) {
      ConnectionState.waiting =>
        const Center(child: CircularProgressIndicator()),
      ConnectionState.done => snapshot.hasError
          ? Center(child: Text('Error: ${snapshot.error}'))
          : builder(snapshot.requireData),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}
