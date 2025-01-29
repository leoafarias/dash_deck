import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:mix/mix.dart';

import '../../../../components/molecules/block_provider.dart';
import '../../helpers/utils.dart';
import '../markdown_helpers.dart';

String _transformLineBreaks(String text) => text.replaceAll('<br>', '\n');

class _TextElementDataProvider extends InheritedWidget {
  final String text;
  final TextSpec spec;
  final Size size;
  const _TextElementDataProvider({
    required super.child,
    required this.text,
    required this.spec,
    required this.size,
  });

  static _TextElementDataProvider of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_TextElementDataProvider>()!;
  }

  @override
  bool updateShouldNotify(
    _TextElementDataProvider oldWidget,
  ) {
    return oldWidget.text != text ||
        oldWidget.spec != spec ||
        oldWidget.size != size;
  }
}

class TextElementBuilder extends MarkdownElementBuilder {
  final TextSpec? spec;
  TextElementBuilder(this.spec);
  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    final (:tag, :content) = getTagAndContent(text.text);

    Widget current = TextSpecWidget(
      _transformLineBreaks(content),
      spec: spec,
    );

    if (tag != null) {
      current = _TextElementHero(
        tag: tag,
        child: current,
      );
    }

    return Builder(builder: (context) {
      final block = BlockData.of(context);
      final contentOffset = getTotalModifierSpacing(spec ?? const TextSpec());
      return _TextElementDataProvider(
        text: _transformLineBreaks(content),
        spec: spec ?? const TextSpec(),
        size: (block.size - contentOffset) as Size,
        child: current,
      );
    });
  }
}

class _TextElementHero extends StatelessWidget {
  const _TextElementHero({
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
        final fromBlock = _TextElementDataProvider.of(fromHeroContext);
        final toBlock = _TextElementDataProvider.of(toHeroContext);

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return TextSpecWidget(
              lerpString(fromBlock.text, toBlock.text, animation.value),
              spec: fromBlock.spec.lerp(toBlock.spec, animation.value),
            );
          },
        );
      },
    );
  }
}
