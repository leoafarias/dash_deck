import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/constants.dart';
import '../../modules/common/helpers/controller.dart';
import '../../modules/common/helpers/converters.dart';
import '../../modules/common/helpers/utils.dart';
import '../../modules/common/styles/style_spec.dart';
import '../../modules/presentation/slide_data.dart';
import '../../modules/thumbnail/slide_capture_provider.dart';
import '../atoms/cache_image_widget.dart';
import '../atoms/markdown_viewer.dart';
import '../organisms/webview_wrapper.dart';

class BlockData {
  BlockData({
    required this.spec,
    required this.block,
    required this.size,
  });

  final SlideSpec spec;
  final ColumnBlock block;
  final Size size;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BlockData &&
        other.spec == spec &&
        other.block == block &&
        other.size == size;
  }

  @override
  int get hashCode => spec.hashCode ^ block.hashCode ^ size.hashCode;
}

class SectionBlockWidget extends StatelessWidget {
  const SectionBlockWidget(
    this.section, {
    super.key,
    required this.heightPercentage,
  });

  final SectionBlock section;
  final double heightPercentage;

  @override
  Widget build(context) {
    final slide = Provider.of<SlideData>(context);

    final children = section.blocks.map((block) {
      final flex = block.flex ?? 1;
      final alignment = ConverterHelper.toRowAlignment(
        block.align ?? ContentAlignment.center,
      );
      final totalFlex =
          section.blocks.map((b) => b.flex ?? 1).reduce((a, b) => a + b);

      final widthPercentage = flex / totalFlex;

      return Expanded(
        flex: flex,
        child: SpecBuilder(
          style: slide.style.applyVariant(Variant(block.type.name)),
          builder: (context) {
            final spec = SlideSpec.of(context);

            final size = Size(
              kResolution.width * widthPercentage,
              kResolution.height * heightPercentage,
            );

            final sizeOffset = getSizeWithoutSpacing(spec.blockContainer);

            return spec.blockContainer(
              child: Provider(
                data: BlockData(
                  block: block,
                  spec: spec,
                  size: (size - sizeOffset) as Size,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: alignment.$2,
                              mainAxisAlignment: alignment.$1,
                              children: [
                                switch (block) {
                                  ImageBlock block => _ImageBlockWidget(block),
                                  WidgetBlock block =>
                                    _WidgetBlockWidget(block),
                                  DartPadBlock block =>
                                    _DartPadBlockWidget(block),
                                  ColumnBlock block => ColumnBlockWidget(block),
                                },
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: crossAxis,
      children: children,
    );
  }
}

abstract class _BlockWidget<T extends ColumnBlock> extends StatelessWidget {
  const _BlockWidget(
    this.block, {
    super.key,
  });

  final T block;
}

class ColumnBlockWidget extends _BlockWidget<ColumnBlock> {
  const ColumnBlockWidget(super.block, {super.key});

  @override
  Widget build(context) {
    final content = block.content;

    final blockData = Provider.of<BlockData>(context);
    final capturing =
        Provider.maybeOf<CapturingData>(context)?.isCapturing == true;

    Widget current = MarkdownViewer(
      content: content,
      spec: SlideSpec.of(context),
    );

    if (capturing) {
      current = Wrap(
        clipBehavior: Clip.hardEdge,
        children: [current],
      );
    } else {
      current = SingleChildScrollView(
        child: current,
      );
    }

    return ConstrainedBox(
      constraints: BoxConstraints.loose(
        blockData.size - const Offset(0, 0) as Size,
      ),
      child: current,
    );
  }
}

class _ImageBlockWidget extends _BlockWidget<ImageBlock> {
  const _ImageBlockWidget(super.block);

  @override
  Widget build(context) {
    final options = block;

    final alignment = options.align ?? ContentAlignment.center;
    final imageFit = options.fit ?? ImageFit.cover;
    final spec = SlideSpec.of(context);

    return CachedImage(
      uri: Uri.parse(options.src),
      spec: spec.image.copyWith(
        fit: ConverterHelper.toBoxFit(imageFit),
        alignment: ConverterHelper.toAlignment(alignment),
      ),
    );
  }
}

class _WidgetBlockWidget extends _BlockWidget<WidgetBlock> {
  const _WidgetBlockWidget(super.block);

  @override
  Widget build(context) {
    final slide = Provider.of<SlideData>(context);
    final blockData = Provider.of<BlockData>(context);

    final widgetBuilder = slide.getWidget(block.name);

    if (widgetBuilder == null) {
      return Container(
        color: Colors.red,
        child: Center(
          child: Text('Widget not found: ${block.name}'),
        ),
      );
    }

    return Builder(
      builder: (context) {
        try {
          return SizedBox(
            height: blockData.size.height,
            child: widgetBuilder(context, block),
          );
        } catch (e) {
          return Container(
            color: Colors.red,
            child: Center(
              child: Text('Error building widget: ${block.type}\n$e'),
            ),
          );
        }
      },
    );
  }
}

class _DartPadBlockWidget extends _BlockWidget<DartPadBlock> {
  const _DartPadBlockWidget(super.block);

  @override
  Widget build(context) {
    final DartPadBlock(:id, :theme, :embed) = block;

    final themeName = theme?.name ?? DartPadTheme.dark.name;

    return WebViewWrapper(
      url: 'https://dartpad.dev/?id=$id&theme=$themeName&embed=$embed',
    );
  }
}
