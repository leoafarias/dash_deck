import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../models/slide_model.dart';
import '../../providers/slide_provider.dart';
import '../../providers/snapshot_provider.dart';
import '../../providers/style_provider.dart';
import '../../styles/style_spec.dart';
import 'cache_image_widget.dart';
import 'transition_widget.dart';

class SlideView<T extends Slide> extends StatelessWidget {
  const SlideView(
    this.slide, {
    super.key,
  });

  final T slide;

  @override
  Widget build(BuildContext context) {
    final slide = this.slide;

    final variantStyle = StyleProvider.of(context, slide.style);

    final isCapturing = SnapshotProvider.isCapturingOf(context);
    final duration =
        isCapturing ? Duration.zero : const Duration(milliseconds: 300);

    final backgroundWidget = slide.background != null
        ? CacheImage(
            url: slide.background!,
            fit: BoxFit.cover,
            alignment: Alignment.center,
          )
        : const SizedBox();

    return TransitionWidget(
      key: ValueKey(slide.transition),
      transition: slide.transition,
      child: SpecBuilder(
        style: variantStyle,
        builder: (context) {
          final spec = SlideSpec.of(context);
          return Builder(builder: (context) {
            return AnimatedBoxSpecWidget(
              spec: spec.outerContainer,
              duration: duration,
              child: Stack(
                children: [
                  Positioned.fill(child: backgroundWidget),
                  SlideBuilder(slide),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
