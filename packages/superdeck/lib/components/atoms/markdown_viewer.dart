import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prism/flutter_prism.dart';
import 'package:markdown_viewer/markdown_viewer.dart';
import 'package:mix/mix.dart';

import '../../controllers/deck_controller.dart';
import '../../helpers/measure_size.dart';
import '../../helpers/syntax_highlighter.dart';
import '../../models/slide_options_model.dart';
import '../../styles/style_spec.dart';
import '../molecules/slide_view.dart';

class SlideContent extends StatelessWidget {
  const SlideContent({
    required this.content,
    required this.alignment,
    super.key,
  });

  final String content;

  final ContentAlignment alignment;

  @override
  Widget build(context) {
    final mix = MixProvider.of(context);
    final spec = SlideSpec.of(mix);
    final container = spec.contentContainer;
    final padding = container.padding ?? const EdgeInsets.all(0);
    final margin = container.margin ?? const EdgeInsets.all(0);

    //  if container.decoration is a BoxDecoration then get the border horizontal and vertical spacing
    double horizontalBorderSize = 0.0;
    double verticalBorderSize = 0.0;

    if (container.decoration is BoxDecoration) {
      final decoration = container.decoration as BoxDecoration;
      final border = decoration.border;

      if (border != null) {
        // Check if is Border or BorderDirectional and get the horizontal and vertical spacing
        if (border is Border) {
          horizontalBorderSize = border.left.width + border.right.width;
          verticalBorderSize = border.top.width + border.bottom.width;
        } else if (border is BorderDirectional) {
          horizontalBorderSize = border.start.width + border.end.width;
          verticalBorderSize = border.top.width + border.bottom.width;
        }
      }
    }

    final widthSpacing =
        padding.horizontal + margin.horizontal + horizontalBorderSize;
    final heightSpacing =
        padding.vertical + margin.vertical + verticalBorderSize;

    return SlideConstraintBuilder(builder: (context, size) {
      final maxHeight = size.height - heightSpacing;
      final maxWidth = size.width - widthSpacing;
      return Column(
        mainAxisAlignment: alignment.toMainAxisAlignment(),
        crossAxisAlignment: alignment.toCrossAxisAlignment(),
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: size.height,
              maxWidth: size.width,
            ),
            child: SingleChildScrollView(
              child: BoxSpecWidget(
                spec: spec.contentContainer,
                child: SlideConstraints(
                  constraints: BoxConstraints(
                    maxHeight: maxHeight,
                    maxWidth: maxWidth,
                  ),
                  child: Builder(builder: (context) {
                    return MarkdownViewer(
                      content,
                      enableTaskList: true,
                      enableSuperscript: false,
                      enableSubscript: false,
                      enableFootnote: false,
                      enableImageSize: true,
                      enableKbd: false,
                      syntaxExtensions: const [],
                      elementBuilders: const [],
                      imageBuilder: _imageBuilder(context),
                      onTapLink: (href, title) {
                        print({href, title});
                      },
                      highlightBuilder: _highlightBuilder(context),
                      copyIconBuilder: (bool copied) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            copied ? Icons.check : Icons.copy,
                            color: spec.code?.copyIconColor ?? Colors.grey,
                            size: 28,
                          ),
                        );
                      },
                      styleSheet: spec.toStyle(),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

Widget Function(Uri, MarkdownImageInfo) _imageBuilder(BuildContext context) {
  return (Uri uri, MarkdownImageInfo info) {
    const boxFit = BoxFit.contain;

    final constraints = SlideConstraints.of(context);

    Widget current;

    //  check if its a local path or a network path
    if (uri.scheme == 'http' || uri.scheme == 'https') {
      current = CachedNetworkImage(
        imageUrl: uri.toString(),
        fit: boxFit,
        width: info.width,
        height: info.height,
      );
    } else {
      final assets = superdeck.assets;

      final asset = assets.value.firstWhereOrNull(
        (element) => element.name == uri.toString(),
      );

      if (asset?.base64 != null) {
        current = Image.memory(
          base64Decode(asset!.base64),
          fit: boxFit,
          width: info.width,
          height: info.height,
        );
      } else {
        current = Image.asset(
          uri.toString(),
          fit: boxFit,
          width: info.width,
          height: info.height,
        );
      }
    }

    return ConstrainedBox(constraints: constraints, child: current);
  };
}

List<TextSpan> updateTextColor(
  List<TextSpan> originalSpans,
  List<int> targetLines,
  Color newColor,
) {
  // Check if the target line is within the range of the list
  if (targetLines.isEmpty) {
    return originalSpans;
  }

  // Clone the original list to avoid mutating it directly
  List<TextSpan> updatedSpans = List<TextSpan>.from(originalSpans);

  // Detect line break from the list of text spans
  // This is done by checking if the previous span is a line break
  // If it is, then the current span is the start of a new line
  int line = 1;

  for (int i = 0; i < updatedSpans.length; i++) {
    if (i > 0) {
      final currentValue = updatedSpans[i].text ?? '';

      if (currentValue.startsWith('\n')) {
        line++;
      }
    }
    final originalSpan = originalSpans[i];

    final textStyle = originalSpan.style ?? const TextStyle();

    if (targetLines.contains(line)) {
      updatedSpans[i] = TextSpan(
        text: originalSpan.text,
        children: originalSpan.children,
        recognizer: originalSpan.recognizer,
        mouseCursor: originalSpan.mouseCursor,
        onEnter: originalSpan.onEnter,
        onExit: originalSpan.onExit,
        semanticsLabel: originalSpan.semanticsLabel,
        locale: originalSpan.locale,
        spellOut: originalSpan.spellOut,
        style: textStyle.copyWith(
          backgroundColor: newColor,
        ),
      );
    }
  }

  return updatedSpans;
}

List<TextSpan> Function(String, String?, String?) _highlightBuilder(
  BuildContext context,
) {
  return (
    String text,
    String? language,
    String? infoString,
  ) {
    final prism = Prism(
      mouseCursor: SystemMouseCursors.text,
      style: Theme.of(context).brightness == Brightness.dark
          ? const PrismStyle.dark()
          : const PrismStyle(),
    );

    final spans = prism.render(text, language ?? 'plain');
    return updateTextColor(spans, parseLineNumbers(infoString ?? ''),
        Colors.white.withOpacity(0.1));
  };
}
