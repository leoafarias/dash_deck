import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../../helpers/constants.dart';
import '../../helpers/layout_builder.dart';
import '../../helpers/measure_size.dart';
import '../../providers/slide_provider.dart';
import '../../superdeck.dart';
import 'cache_image_widget.dart';
import 'transition_widget.dart';

class SlideView extends StatelessWidget {
  // If SlideView is a snapshot for image generation
  final bool _isSnapshot;
  const SlideView(
    this.slide, {
    super.key,
  }) : _isSnapshot = false;

  const SlideView.snapshot(
    this.slide, {
    super.key,
  }) : _isSnapshot = true;

  final Slide slide;

  @override
  Widget build(BuildContext context) {
    final slide = this.slide;
    final variant = slide.styleVariant;
    final style = superdeckController.style.watch(context);

    final variantStyle = style.applyVariant(variant);

    final backgroundWidget = slide.background != null
        ? CacheImage(
            url: slide.background!,
            fit: BoxFit.cover,
            size: kResolution,
            alignment: Alignment.center,
          )
        : const SizedBox();

    final duration = _isSnapshot ? Duration.zero : null;

    return TransitionWidget(
      key: ValueKey(slide.transition?.copyWith(duration: duration)),
      transition: slide.transition,
      child: SpecBuilder(
        style: variantStyle,
        builder: (context) {
          final spec = SlideSpec.of(context);
          return Builder(builder: (context) {
            return AnimatedBoxSpecWidget(
              spec: spec.outerContainer,
              duration: duration ?? const Duration(milliseconds: 300),
              child: Stack(
                children: [
                  Positioned.fill(child: backgroundWidget),
                  AnimatedBoxSpecWidget(
                    spec: spec.innerContainer,
                    duration: const Duration(milliseconds: 300),
                    child: SlideProvider(
                      slide: slide,
                      spec: spec,
                      examples: superdeckController.examples.watch(context),
                      assets: superdeckController.assets.watch(context),
                      isSnapshot: _isSnapshot,
                      child: SlideConstraints(
                        (_) => switch (slide) {
                          (SimpleSlide slide) =>
                            SimpleSlideBuilder(config: slide, spec: spec),
                          (WidgetSlide slide) =>
                            WidgetSlideBuilder(config: slide, spec: spec),
                          (ImageSlide slide) =>
                            ImageSlideBuilder(config: slide, spec: spec),
                          (TwoColumnSlide slide) =>
                            TwoColumnSlideBuilder(config: slide, spec: spec),
                          (TwoColumnHeaderSlide slide) =>
                            TwoColumnHeaderSlideBuilder(
                                config: slide, spec: spec),
                          (InvalidSlide slide) =>
                            InvalidSlideBuilder(config: slide, spec: spec),
                          (_) => throw UnimplementedError(
                              'Slide config not implemented',
                            ),
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}

class SlideConstraintsProvider extends InheritedWidget {
  const SlideConstraintsProvider({
    required this.constraints,
    required super.child,
    super.key,
  });

  final BoxConstraints constraints;

  static BoxConstraints of(BuildContext context) {
    final slideConstraints =
        context.dependOnInheritedWidgetOfExactType<SlideConstraintsProvider>();
    if (slideConstraints == null) {
      throw Exception('SlideConstraints not found in context');
    }
    return slideConstraints.constraints;
  }

  @override
  bool updateShouldNotify(SlideConstraintsProvider oldWidget) {
    return oldWidget.constraints != constraints;
  }
}
