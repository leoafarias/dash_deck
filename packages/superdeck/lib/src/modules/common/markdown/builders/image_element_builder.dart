import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:mix/mix.dart';
import 'package:superdeck/src/components/molecules/block_provider.dart';

import '../../../../components/atoms/cache_image_widget.dart';
import '../../helpers/utils.dart';

class ImageElementBuilder extends MarkdownElementBuilder {
  final ImageSpec spec;

  ImageElementBuilder(this.spec);

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final src = element.attributes['src']!;
    final heroTag = element.attributes['hero'];

    final uri = Uri.parse(src);

    return Builder(builder: (context) {
      final block = BlockData.of(context);

      final contentOffset = getTotalModifierSpacing(spec);

      final totalSize = Size(
        block.size.width - contentOffset.dx,
        block.size.height - contentOffset.dy,
      );
      Widget current = AnimatedContainer(
        duration: Durations.medium1,
        constraints: BoxConstraints.tight(totalSize),
        child: CachedImage(
          uri: uri,
          targetSize: totalSize,
          spec: spec,
        ),
      );

      if (heroTag != null) {
        current = _ImageElementHero(
          tag: heroTag,
          child: current,
        );
      }

      return _ImageElementDataProvider(
        size: totalSize,
        spec: spec,
        uri: uri,
        child: current,
      );
    });
  }
}

class _ImageElementHero extends StatelessWidget {
  const _ImageElementHero({
    required this.tag,
    required this.child,
  });

  final String tag;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: child,
      flightShuttleBuilder: (
        BuildContext context,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        final fromBlock = _ImageElementDataProvider.maybeOf(fromHeroContext);
        final toBlock = _ImageElementDataProvider.maybeOf(toHeroContext);

        Widget buildImageWidget(Size size, ImageSpec spec, Uri uri) {
          return Container(
            constraints: BoxConstraints.tight(size),
            child: CachedImage(
              uri: uri,
              spec: spec,
            ),
          );
        }

        if (fromBlock == null || toBlock == null) {
          final block = fromBlock ?? toBlock;
          return buildImageWidget(
            block!.size,
            block.spec,
            block.uri,
          );
        }

        final interpolatedSize = Size.lerp(
          fromBlock.size,
          toBlock.size,
          animation.value,
        )!;

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return buildImageWidget(
              interpolatedSize,
              fromBlock.spec.lerp(toBlock.spec, animation.value),
              animation.value < 0.5 ? fromBlock.uri : toBlock.uri,
            );
          },
        );
      },
    );
  }
}

class _ImageElementDataProvider extends InheritedWidget {
  final Size size;
  final ImageSpec spec;
  final Uri uri;
  const _ImageElementDataProvider({
    required super.child,
    required this.size,
    required this.spec,
    required this.uri,
  });

  static _ImageElementDataProvider? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ImageElementDataProvider>();
  }

  @override
  bool updateShouldNotify(
    _ImageElementDataProvider oldWidget,
  ) {
    return oldWidget.size != size ||
        oldWidget.spec != spec ||
        oldWidget.uri != uri;
  }
}
