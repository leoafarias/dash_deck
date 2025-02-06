import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck/src/modules/thumbnail/slide_capture_service.dart';

import '../../modules/common/helpers/constants.dart';
import '../../modules/deck/deck_controller.dart';
import '../../modules/deck/slide_configuration.dart';
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
  final bool selected;
  final SlideConfiguration slideConfig;

  const SlideThumbnail({
    super.key,
    required this.selected,
    required this.slideConfig,
  });

  @override
  State<SlideThumbnail> createState() => _SlideThumbnailState();
}

class _SlideThumbnailState extends State<SlideThumbnail> {
  final _slideCaptureService = SlideCaptureService();

  /// Generates the thumbnail for the given [slide].
  ///
  /// If [force] is true, it regenerates the thumbnail even if it already exists.
  Future<File> _generateThumbnail({
    required SlideConfiguration slide,
    required DeckController controller,
    bool force = false,
  }) async {
    final thumbnailFile = controller.getSlideThumbnailFile(slide);

    final isValid =
        await thumbnailFile.exists() && (await thumbnailFile.length()) > 0;

    if (isValid && !force) {
      return thumbnailFile;
    }

    final imageData = await _slideCaptureService.generate(slide: slide);

    await thumbnailFile.writeAsBytes(imageData, flush: true);

    final fileLength = await thumbnailFile.length();

    if (fileLength == 0) {
      await thumbnailFile.delete();
      return _generateThumbnail(
        slide: slide,
        controller: controller,
        force: true,
      );
    }

    return thumbnailFile;
  }

  // Future<void> _handleAction(_PopMenuAction action) async {
  //   switch (action) {
  //     case _PopMenuAction.refreshThumbnail:
  //       final thumbnailFile = _getThumbnailFile(widget.slide);

  //       if (await thumbnailFile.exists()) {
  //         await thumbnailFile.delete();
  //       }
  //       await _thumbnailGeneration.refresh();
  //   }
  // }

  Future<File> _load(BuildContext context) async {
    final controller = DeckController.of(context);
    return kCanRunProcess
        ? await _generateThumbnail(
            slide: widget.slideConfig,
            controller: controller,
          )
        : controller.getSlideThumbnailFile(widget.slideConfig);
  }

  @override
  Widget build(BuildContext context) {
    return _PreviewContainer(
      selected: widget.selected,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: kAspectRatio,
            child: FutureBuilder(
              future: _load(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image(
                    gaplessPlayback: true,
                    image: getImageProvider(snapshot.requireData.uri),
                  );
                }
                return const IsometricLoading();
              },
            ),
          ),
        ],
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
      child: child,
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
