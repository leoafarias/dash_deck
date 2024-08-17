import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../models/options_model.dart';
import '../../providers/snapshot_provider.dart';
import '../../styles/style_spec.dart';
import '../atoms/markdown_viewer.dart';

class SlideContent extends StatelessWidget {
  const SlideContent({
    required this.content,
    required this.options,
    super.key,
  });

  final String content;

  final ContentOptions? options;

  @override
  Widget build(context) {
    final alignment = options?.align ?? ContentAlignment.center;
    final spec = SlideSpec.of(context);
    final isCapturing = SnapshotProvider.isCapturingOf(context);

    Widget child = AnimatedMarkdownViewer(
      content: content,
      spec: spec,
      duration: Durations.medium1,
    );

    if (!isCapturing) {
      child = SingleChildScrollView(
        child: child,
      );
    } else {
      child = Wrap(
        clipBehavior: Clip.hardEdge,
        children: [
          child,
        ],
      );
    }
    return AnimatedBoxSpecWidget(
      duration: const Duration(milliseconds: 300),
      spec: spec.contentContainer.copyWith(
        alignment: alignment.toAlignment(),
      ),
      child: child,
    );
  }
}
