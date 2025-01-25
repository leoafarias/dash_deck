import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:mix/mix.dart';

import '../../../../superdeck.dart';
import '../../../components/atoms/cache_image_widget.dart';
import '../helpers/syntax_highlighter.dart';
import '../helpers/utils.dart';
import 'alert_block_syntax.dart';

class SpecMarkdownBuilders {
  final SlideSpec spec;

  SpecMarkdownBuilders(this.spec);

  final List<md.BlockSyntax> blockSyntaxes = [
    const CustomHeaderSyntax(),
    const AlertBlockSyntax(),
  ];

  final List<md.InlineSyntax> inlineSyntaxes = [
    CustomImageSyntax(),
  ];

  late final builders = <String, MarkdownElementBuilder>{
    'h1': TextBuilder(spec.h1),
    'h2': TextBuilder(spec.h2),
    'h3': TextBuilder(spec.h3),
    'h4': TextBuilder(spec.h4),
    'h5': TextBuilder(spec.h5),
    'h6': TextBuilder(spec.h6),
    'alert': AlertElementBuilder(spec.alert),
    'p': TextBuilder(spec.p),
    'code': CodeElementBuilder(spec.code),
    'img': ImageElementBuilder(spec.image),
    'li': TextBuilder(spec.list?.text),
  };

  Map<String, MarkdownPaddingBuilder> get paddingBuilders {
    return _kBlockTags.fold(
      <String, MarkdownPaddingBuilder>{},
      (map, tag) => map..[tag] = _ZeroPaddingBuilder(),
    );
  }

  Widget Function(bool) get checkboxBuilder {
    return (bool checked) {
      final icon = checked ? Icons.check_box : Icons.check_box_outline_blank;
      return IconSpecWidget(icon, spec: spec.checkbox?.icon);
    };
  }

  Widget Function(MarkdownBulletParameters params) get bulletBuilder {
    return (parameters) {
      final contents = switch (parameters.style) {
        BulletStyle.unorderedList => '•',
        BulletStyle.orderedList => '${parameters.index + 1}.',
      };
      return TextSpecWidget(spec: spec.list?.bullet, contents);
    };
  }
}

class _ZeroPaddingBuilder extends MarkdownPaddingBuilder {
  @override
  EdgeInsets getPadding() => EdgeInsets.zero;
}

String _transformLineBreaks(String text) => text.replaceAll('<br>', '\n');

class TextBuilder extends MarkdownElementBuilder {
  final TextSpec? spec;
  TextBuilder(this.spec);
  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    final (:tag, :content) = _getTagAndContent(text.text);

    Widget current = TextSpecWidget(
      _transformLineBreaks(content),
      spec: spec,
    );

    if (tag != null) {
      current = Hero(
        flightShuttleBuilder: _heroFlightShuttleBuilder,
        tag: tag,
        child: current,
      );
    }

    return Builder(builder: (context) {
      final block = Provider.ofType<BlockData>(context);
      final contentOffset = getTotalModifierSpacing(spec ?? const TextSpec());
      return Provider(
        value: _TextElementData(
          text: _transformLineBreaks(content),
          spec: spec ?? const TextSpec(),
          size: (block.size - contentOffset) as Size,
        ),
        child: current,
      );
    });
  }

  Widget _heroFlightShuttleBuilder(
    BuildContext context,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    final fromBlock = Provider.ofType<_TextElementData>(fromHeroContext);
    final toBlock = Provider.ofType<_TextElementData>(toHeroContext);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return TextSpecWidget(
          _lerpString(fromBlock.text, toBlock.text, animation.value),
          spec: fromBlock.spec.lerp(toBlock.spec, animation.value),
        );
      },
    );
  }
}

class _TextElementData {
  final String text;
  final TextSpec spec;
  final Size size;

  const _TextElementData({
    required this.text,
    required this.spec,
    required this.size,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _TextElementData &&
        other.text == text &&
        other.spec == spec &&
        other.size == size;
  }

  @override
  int get hashCode => text.hashCode ^ spec.hashCode ^ size.hashCode;
}

class ImageElementBuilder extends MarkdownElementBuilder {
  final ImageSpec spec;

  ImageElementBuilder(this.spec);

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final src = element.attributes['src']!;
    final heroTag = element.attributes['hero'];

    final uri = Uri.parse(src);

    return Builder(builder: (context) {
      final block = Provider.ofType<BlockData>(context);

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
          spec: spec,
        ),
      );

      if (heroTag != null) {
        current = Hero(
          tag: heroTag,
          flightShuttleBuilder: _heroFlightShuttleBuilder,
          child: current,
        );
      }

      return Provider(
        value: _ImageElementData(
          size: totalSize,
          spec: spec,
          uri: uri,
        ),
        child: current,
      );
    });
  }

  Widget _heroFlightShuttleBuilder(
    BuildContext context,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    final fromBlock = Provider.maybeTypeOf<_ImageElementData>(fromHeroContext);
    final toBlock = Provider.maybeTypeOf<_ImageElementData>(toHeroContext);

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
  }
}

class _ImageElementData {
  final ImageSpec spec;
  final Size size;
  final Uri uri;

  const _ImageElementData({
    required this.size,
    required this.spec,
    required this.uri,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ImageElementData &&
        other.spec == spec &&
        other.size == size &&
        other.uri == uri;
  }

  @override
  int get hashCode => spec.hashCode ^ size.hashCode ^ uri.hashCode;
}

({
  String? tag,
  String content,
}) _getTagAndContent(String text) {
  text = text.trim();
  final regExp = RegExp(r'{\.(.*?)}');

  final match = regExp.firstMatch(text);

  final tag = match?.group(1);

  String content = text.replaceAll(regExp, '').trim();
  // TODO: Remove this for code element after
  content = content.replaceAll('```', '');

  return (
    tag: tag,
    content: content,
  );
}

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
    final tagAndContent = _getTagAndContent(element.textContent);
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
      codeWidget = Hero(
        tag: heroTag,
        flightShuttleBuilder: _heroFlightShuttleBuilder,
        child: codeWidget,
      );
    }

    // Provide _CodeElementData for Hero animations
    return Builder(builder: (context) {
      final block = Provider.ofType<BlockData>(context);

      final codeOffset = getTotalModifierSpacing(spec);

      final totalSize = Size(
        block.size.width - codeOffset.dx,
        block.size.height - codeOffset.dy,
      );

      return Provider(
        value: _CodeElementData(
          text: tagAndContent.content.trim(),
          language: language,
          spec: spec,
          size: totalSize,
        ),
        child: codeWidget,
      );
    });
  }

  Widget _heroFlightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    final fromBlock = Provider.maybeTypeOf<_CodeElementData>(fromHeroContext);
    final toBlock =
        Provider.maybeTypeOf<_CodeElementData>(toHeroContext) ?? fromBlock;

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

        final interpolatedText = _lerpString(
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
  }
}

class _CodeElementData {
  final String text;
  final MarkdownCodeblockSpec spec;
  final Size size;
  final String language;

  const _CodeElementData({
    required this.text,
    required this.spec,
    required this.size,
    required this.language,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _CodeElementData &&
        other.text == text &&
        other.spec == spec &&
        other.size == size &&
        other.language == language;
  }

  @override
  int get hashCode =>
      text.hashCode ^ spec.hashCode ^ size.hashCode ^ language.hashCode;
}

final _kBlockTags = <String>[
  'p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', //
  'ul', 'ol', 'li', 'blockquote', //
  'pre', 'ol', 'ul', 'hr', 'table', //
  'thead', 'tbody', 'tr', 'section'
];

class CustomHeaderSyntax extends md.HeaderSyntax {
  const CustomHeaderSyntax();

  @override
  md.Node parse(md.BlockParser parser) {
    final element = super.parse(parser) as md.Element;

    final tag = _getTagAndContent(parser.lines.first.content).tag;
    if (tag != null) {
      element.attributes['hero'] = tag;
    }
    return element;
  }
}

class CustomImageSyntax extends md.InlineSyntax {
  CustomImageSyntax() : super(_pattern);

  static const String _pattern = r'!\[(.*?)\]\((.*?)\)(?:\s*\{\.([^\}]+)\})?';

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final altText = match.group(1)!;
    final url = match.group(2)!;
    final tag = match.group(3);

    final element = md.Element.empty('img');
    element.attributes['src'] = url;
    element.attributes['alt'] = altText;

    if (tag != null) {
      element.attributes['hero'] = tag;
    }

    parser.addNode(element);
    return true;
  }
}

String _lerpString(String start, String end, double t) {
  // Clamp t between 0 and 1
  t = t.clamp(0.0, 1.0);

  final commonPrefixLen = start.commonPrefixLength(end);
  final startSuffix = start.substring(commonPrefixLen);
  final endSuffix = end.substring(commonPrefixLen);

  final result = StringBuffer();
  result.write(end.substring(0, commonPrefixLen));

  if (t <= 0.5) {
    final progress = t / 0.5;
    final startLength = startSuffix.length;
    final numCharsToShow = ((1 - progress) * startLength).round();
    if (numCharsToShow > 0) {
      result.write(startSuffix.substring(0, numCharsToShow));
    }
  } else {
    final progress = (t - 0.5) / 0.5;
    final endLength = endSuffix.length;
    final numCharsToShow = (progress * endLength).round();
    if (numCharsToShow > 0) {
      result.write(endSuffix.substring(0, numCharsToShow));
    }
  }

  return result.toString();
}

List<TextSpan> _lerpTextSpans(
  List<TextSpan> start,
  List<TextSpan> end,
  double t,
) {
  final maxLines = math.max(start.length, end.length);
  List<TextSpan> interpolatedSpans = [];

  for (int i = 0; i < maxLines; i++) {
    final startSpan = i < start.length ? start[i] : const TextSpan(text: '');
    final endSpan = i < end.length ? end[i] : const TextSpan(text: '');

    if (startSpan.text == null && endSpan.text == null) {
      // if chilrens are not null recursive
      if (startSpan.children != null && endSpan.children != null) {
        if (startSpan.children!.isEmpty && endSpan.children!.isEmpty) {
          continue;
        }
        final children = _lerpTextSpans(
          startSpan.children! as List<TextSpan>,
          endSpan.children! as List<TextSpan>,
          t,
        );
        final interpolatedSpan = TextSpan(
          children: children,
          style: TextStyle.lerp(startSpan.style, endSpan.style, t),
        );
        interpolatedSpans.add(interpolatedSpan);
        continue;
      }
    }

    final interpolatedText =
        _lerpString(startSpan.text ?? '', endSpan.text ?? '', t);
    final interpolatedStyle = TextStyle.lerp(startSpan.style, endSpan.style, t);

    final interpolatedSpan =
        TextSpan(text: interpolatedText, style: interpolatedStyle);

    interpolatedSpans.add(interpolatedSpan);
  }

  return interpolatedSpans;
}

extension on String {
  int commonPrefixLength(String other) {
    final len = math.min(length, other.length);
    for (int i = 0; i < len; i++) {
      if (this[i] != other[i]) {
        return i;
      }
    }
    return len;
  }
}
