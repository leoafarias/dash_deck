import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck/src/components/molecules/block_provider.dart';
import 'package:superdeck/src/modules/common/helpers/utils.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/converters.dart';
import '../../modules/common/helpers/provider.dart';
import '../../modules/common/styles/style_spec.dart';
import '../../modules/deck/slide_configuration.dart';
import '../atoms/cache_image_widget.dart';
import '../atoms/markdown_viewer.dart';
import '../organisms/webview_wrapper.dart';

class SectionBlockWidget extends StatelessWidget {
  const SectionBlockWidget({
    super.key,
    required this.section,
    required this.size,
  });

  final SectionBlock section;
  final Size size;

  Positioned _renderDebugInfo(Block block, Size size) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );
    final label = '''
@${block.type}
${size.width.toStringAsFixed(2)} x ${size.height.toStringAsFixed(2)}''';

    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        color: Colors.cyan,
        padding: const EdgeInsets.all(8),
        child: Text(label, style: textStyle),
      ),
    );
  }

  @override
  Widget build(context) {
    final blockLeftOffset = List.filled(section.blocks.length, 0.0);
    double cumulativeLeftOffset = 0;
    final widthPerFlex = size.width / section.totalBlockFlex;
    // get index
    for (var index = 0; index < section.blocks.length; index++) {
      final block = section.blocks[index];
      final blockWidth = widthPerFlex * block.flex;
      blockLeftOffset[index] = cumulativeLeftOffset;
      cumulativeLeftOffset = cumulativeLeftOffset + blockWidth;
    }

    final configuration = SlideConfiguration.of(context);

    return Stack(
      children: section.blocks.mapIndexed((index, block) {
        final widthPercentage = block.flex / section.totalBlockFlex;

        final blockSize = Size(
          size.width * widthPercentage,
          size.height,
        );

        return Positioned(
          left: blockLeftOffset[index],
          top: 0,
          width: blockSize.width,
          height: blockSize.height,
          child: Stack(
            children: [
              switch (block) {
                ImageBlock b => _ImageBlockWidget(
                    block: b,
                    size: blockSize,
                    configuration: configuration,
                  ),
                WidgetBlock b => _WidgetBlockWidget(
                    block: b,
                    size: blockSize,
                    configuration: configuration,
                  ),
                DartPadBlock b => _DartPadBlockWidget(
                    block: b,
                    size: blockSize,
                    configuration: configuration,
                  ),
                ColumnBlock b => ColumnBlockWidget(
                    block: b,
                    size: blockSize,
                    configuration: configuration,
                  ),
                _ => const SizedBox.shrink(),
              },
              if (configuration.debug) _renderDebugInfo(block, blockSize),
            ],
          ),
        );
      }).toList(),
    );
  }
}

abstract class _BlockWidget<T extends Block> extends StatefulWidget {
  const _BlockWidget({
    super.key,
    required this.block,
    required this.size,
    required this.configuration,
  });

  Widget build(BuildContext context, BlockData<T> data);

  final T block;
  final Size size;
  final SlideConfiguration configuration;
  @override
  State<_BlockWidget<T>> createState() => _BlockWidgetState<T>();
}

class _BlockWidgetState<T extends Block> extends State<_BlockWidget<T>> {
  @override
  Widget build(context) {
    final style = widget.configuration.style.applyVariant(
      Variant(widget.block.type),
    );

    return SpecBuilder(
        style: style,
        builder: (context) {
          final spec = SlideSpec.of(context);

          final blockOffset = calculateBlockOffset(spec.blockContainer);

          final blockData = BlockData(
            block: widget.block,
            spec: spec,
            size: Size(
              widget.size.width - blockOffset.dx,
              widget.size.height - blockOffset.dy,
            ),
          );

          Widget current = InheritedData(
            data: blockData,
            child: spec.blockContainer(
              child: widget.build(context, blockData),
            ),
          );

          if (widget.block.scrollable && !widget.configuration.isExporting) {
            current = SingleChildScrollView(
              child: current,
            );
          } else {
            current = Wrap(
              clipBehavior: Clip.hardEdge,
              children: [current],
            );
          }

          final decoration = widget.configuration.debug
              ? BoxDecoration(
                  border: Border.all(
                    color: Colors.cyan,
                    width: 2,
                  ),
                )
              : null;

          return Container(
            decoration: decoration,
            child: ConstrainedBox(
              constraints: BoxConstraints.loose(widget.size),
              child: Stack(
                children: [
                  Align(
                    alignment: ConverterHelper.toAlignment(
                      blockData.block.align,
                    ),
                    child: current,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ColumnBlockWidget extends _BlockWidget<ColumnBlock> {
  const ColumnBlockWidget({
    super.key,
    required super.block,
    required super.size,
    required super.configuration,
  });

  @override
  Widget build(context, data) {
    return MarkdownViewer(
      content: data.block.content,
      spec: data.spec,
    );
  }
}

class _ImageBlockWidget extends _BlockWidget<ImageBlock> {
  const _ImageBlockWidget({
    super.key,
    required super.block,
    required super.size,
    required super.configuration,
  });

  @override
  Widget build(context, data) {
    final alignment = data.block.align ?? ContentAlignment.center;
    final imageFit = data.block.fit ?? ImageFit.cover;
    final spec = data.spec;

    return CachedImage(
      uri: Uri.parse(data.block.asset.fileName),
      spec: spec.image.copyWith(
        fit: ConverterHelper.toBoxFit(imageFit),
        alignment: ConverterHelper.toAlignment(alignment),
      ),
    );
  }
}

class _WidgetBlockWidget extends _BlockWidget<WidgetBlock> {
  const _WidgetBlockWidget({
    super.key,
    required super.block,
    required super.size,
    required super.configuration,
  });

  @override
  Widget build(context, data) {
    final slide = SlideConfiguration.of(context);

    final widgetBuilder = slide.getWidget(data.block.type);

    if (widgetBuilder == null) {
      return Container(
        color: Colors.red,
        child: Center(
          child: Text('Widget not found: ${data.block.type}'),
        ),
      );
    }

    return Builder(
      builder: (context) {
        try {
          return SizedBox(
            height: data.size.height,
            child: widgetBuilder(context, data.block),
          );
        } catch (e) {
          return Container(
            color: Colors.red,
            child: Center(
              child: Text('Error building widget: ${data.block.type}\n$e'),
            ),
          );
        }
      },
    );
  }
}

class _DartPadBlockWidget extends _BlockWidget<DartPadBlock> {
  const _DartPadBlockWidget({
    super.key,
    required super.block,
    required super.size,
    required super.configuration,
  });

  @override
  Widget build(context, data) {
    final DartPadBlock(:id, :theme, :embed) = data.block;

    final themeName = theme?.name ?? DartPadTheme.dark.name;

    if (kDebugMode) {
      return SizedBox(
        height: data.size.height,
        width: data.size.width,
        child: const Text('DartPadBlockWidget'),
      );
    }

    return SizedBox(
      height: data.size.height,
      width: data.size.width,
      child: WebViewWrapper(
        url: 'https://dartpad.dev/?id=$id&theme=$themeName&embed=$embed',
      ),
    );
  }
}
