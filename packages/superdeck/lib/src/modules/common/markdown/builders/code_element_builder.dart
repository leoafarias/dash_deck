import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:mix/mix.dart';
import 'package:superdeck/src/components/molecules/block_provider.dart';

import '../../../../../superdeck.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../helpers/utils.dart';
import '../markdown_helpers.dart';

class CodeElementBuilder extends MarkdownElementBuilder {
  final MarkdownCodeblockSpec? spec;

  CodeElementBuilder(this.spec);

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final spec = this.spec ?? const MarkdownCodeblockSpec();
    // Extract language from the class attribute, default to 'dart'
    var language = 'dart';
    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      if (lg.startsWith('language-')) {
        language = lg.substring(9);
      }
    }

    // Extract hero tag if present
    final tagAndContent = getTagAndContent(element.textContent);
    final heroTag = tagAndContent.tag;

    final spans = SyntaxHighlight.render(
      tagAndContent.content.trim(),
      language,
    );

    // Build the code widget
    Widget codeWidget = Row(
      children: [
        Expanded(
          child: BoxSpecWidget(
            spec: spec.container,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: spans.map((span) {
                return RichText(
                  text: TextSpan(
                    style: spec.textStyle,
                    children: [span],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );

    // If a hero tag is present, wrap the widget in a Hero
    if (heroTag != null) {
      codeWidget = _CodeElementHero(
        tag: heroTag,
        child: codeWidget,
      );
    }

    // Provide _CodeElementData for Hero animations
    return Builder(builder: (context) {
      final blockData = BlockData.of(context);

      final codeOffset = getTotalModifierSpacing(spec);

      final totalSize = Size(
        blockData.size.width - codeOffset.dx,
        blockData.size.height - codeOffset.dy,
      );

      return _CodeElementDataProvider(
        text: tagAndContent.content.trim(),
        language: language,
        spec: spec,
        size: totalSize,
        child: codeWidget,
      );
    });
  }
}

class _CodeElementHero extends StatelessWidget {
  const _CodeElementHero({
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
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        final fromBlock = _CodeElementDataProvider.maybeOf(fromHeroContext);
        final toBlock =
            _CodeElementDataProvider.maybeOf(toHeroContext) ?? fromBlock;

        Widget buildCodeWidget(
          Size size,
          MarkdownCodeblockSpec spec,
          List<TextSpan> spans,
        ) {
          return Wrap(
            clipBehavior: Clip.hardEdge,
            children: [
              SizedBox.fromSize(
                size: size,
                child: BoxSpecWidget(
                  spec: spec.container,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: spans.map((span) {
                      return RichText(
                        text: TextSpan(
                          style: spec.textStyle,
                          children: [span],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        }

        if (toBlock == null || fromBlock == null) {
          final block = fromBlock ?? toBlock;
          return buildCodeWidget(
            block!.size,
            block.spec,
            SyntaxHighlight.render(block.text, block.language),
          );
        }

        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            final interpolatedSpec = fromBlock.spec.lerp(
              toBlock.spec,
              animation.value,
            );
            final interpolatedSize = Size.lerp(
              fromBlock.size,
              toBlock.size,
              animation.value,
            )!;

            final interpolatedText = lerpString(
              fromBlock.text,
              toBlock.text,
              animation.value,
            );

            final spans = SyntaxHighlight.render(
              interpolatedText,
              toBlock.language,
            );

            return buildCodeWidget(interpolatedSize, interpolatedSpec, spans);
          },
        );
      },
    );
  }
}

class _CodeElementDataProvider extends InheritedWidget {
  final String text;
  final String language;
  final MarkdownCodeblockSpec spec;
  final Size size;
  const _CodeElementDataProvider({
    required super.child,
    required this.text,
    required this.language,
    required this.spec,
    required this.size,
  });

  static _CodeElementDataProvider? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_CodeElementDataProvider>();
  }

  @override
  bool updateShouldNotify(
    _CodeElementDataProvider oldWidget,
  ) {
    return oldWidget.text != text ||
        oldWidget.language != language ||
        oldWidget.spec != spec ||
        oldWidget.size != size;
  }
}
