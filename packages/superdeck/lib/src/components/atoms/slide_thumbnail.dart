import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:signals/signals_flutter.dart';
import 'package:superdeck/src/modules/thumbnail/slide_capture_service.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/constants.dart';
import '../../modules/presentation/slide_data.dart';
import 'cache_image_widget.dart';
import 'loading_indicator.dart';

enum _PopMenuAction {
  refreshThumbnail(
    'Refresh Thumbnail',
    Icons.refresh,
  );

  const _PopMenuAction(this.label, this.icon);

  final String label;
  final IconData icon;
}

class SlideThumbnail extends StatefulWidget {
  final VoidCallback onTap;
  final bool selected;
  final SlideData slide;
  final int page;

  const SlideThumbnail({
    super.key,
    required this.selected,
    required this.onTap,
    required this.slide,
    required this.page,
  });

  @override
  State<SlideThumbnail> createState() => _SlideThumbnailState();
}

class _SlideThumbnailState extends State<SlideThumbnail> {
  final _slideCaptureService = SlideCaptureService();
  late final _thumbnailGeneration = futureSignal(_load);

  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _thumbnailGeneration.dispose();
    super.dispose();
  }

  File _getThumbnailFile(SlideData slide) {
    final asset = SlideThumbnailAsset.fromSlideKey(slide.data.key);
    return File(asset.path);
  }

  /// Generates the thumbnail for the given [slide].
  ///
  /// If [force] is true, it regenerates the thumbnail even if it already exists.
  Future<File> _generateThumbnail(
    SlideData slide, {
    bool force = false,
  }) async {
    final thumbnailFile = _getThumbnailFile(slide);

    if (await thumbnailFile.exists() && !force) {
      return thumbnailFile;
    }

    final imageData = await _slideCaptureService.generate(slide: slide);

    return await thumbnailFile.writeAsBytes(imageData, flush: true);
  }

  Future<void> _handleAction(_PopMenuAction action) async {
    switch (action) {
      case _PopMenuAction.refreshThumbnail:
        final thumbnailFile = _getThumbnailFile(widget.slide);

        if (await thumbnailFile.exists()) {
          await thumbnailFile.delete();
        }
        await _thumbnailGeneration.refresh();
    }
  }

  Future<File> _load() async {
    return kCanRunProcess
        ? await _generateThumbnail(widget.slide)
        : _getThumbnailFile(widget.slide);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onSecondaryTapDown: (details) {
        _showOverlayMenu(context, details, _handleAction);
      },
      child: _PreviewContainer(
        selected: widget.selected,
        child: Stack(
          children: [
            AspectRatio(
                aspectRatio: kAspectRatio,
                child: Watch.builder(builder: (context) {
                  return _thumbnailGeneration.value.map(
                    data: (file) => Image(
                      gaplessPlayback: true,
                      image: getImageProvider(file.uri),
                    ),
                    loading: () => const IsometricLoading(),
                    error: (error) => const Center(
                      child: Text('Error loading image'),
                    ),
                  );
                })),
          ],
        ),
      ),
    );
  }
}

class _PreviewContainer extends StatelessWidget {
  final Widget child;
  final bool selected;

  const _PreviewContainer({
    required this.selected,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final style = Style(
      $box.color.grey(),
      $box.margin.all(8),
      $box.border.width(2),
      $box.shadow(
        blurRadius: 4,
        spreadRadius: 1,
      ),
      selected ? $box.wrap.scale(1.05) : $box.wrap.scale(1),
      selected ? $box.wrap.opacity(1) : $box.wrap.opacity(0.5),
      selected ? $box.border.color.cyan() : $box.border.color.transparent(),
    ).animate();

    return Box(
      style: style,
      child: AspectRatio(aspectRatio: kAspectRatio, child: child),
    );
  }
}

void _showOverlayMenu(
  BuildContext context,
  TapDownDetails details,
  void Function(_PopMenuAction) handleAction,
) {
  final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  menuItem(_PopMenuAction action) => PopupMenuItem(
        value: action,
        onTap: () => handleAction(action),
        mouseCursor: SystemMouseCursors.click,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(action.icon),
            const SizedBox(width: 8),
            Text(action.label),
          ],
        ),
      );

  showMenu(
    context: context,
    menuPadding: EdgeInsets.zero,
    items: [
      menuItem(_PopMenuAction.refreshThumbnail),
    ],
    position: RelativeRect.fromSize(
      details.globalPosition & Size.zero,
      overlay.size,
    ),
  );
}
