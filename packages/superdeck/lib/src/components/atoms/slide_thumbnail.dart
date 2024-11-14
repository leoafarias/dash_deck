import 'package:flutter/material.dart';
import 'package:mix/mix.dart';

import '../../modules/common/helpers/constants.dart';
import '../../modules/presentation/slide_data.dart';
import '../../modules/thumbnail/thumbnail_controller.dart';
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
  late ThumbnailController _thumbnailController;

  @override
  void initState() {
    super.initState();
    _thumbnailController = ThumbnailController()..load(widget.slide);
  }

  @override
  void dispose() {
    _thumbnailController.dispose();
    super.dispose();
  }

  void _handleAction(_PopMenuAction action) {
    switch (action) {
      case _PopMenuAction.refreshThumbnail:
        _thumbnailController.refresh(widget.slide);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: _thumbnailController,
        builder: (context, _) {
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
                    child: _thumbnailController.when(
                        data: (file) {
                          return Image(
                            gaplessPlayback: true,
                            image: getImageProvider(file.uri),
                          );
                        },
                        loading: () => const IsometricLoading(),
                        error: (error) {
                          return const Center(
                            child: Text('Error loading image'),
                          );
                        }),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: SizedBox(
                      child: _thumbnailController.isRefreshing
                          ? const LinearProgressIndicator(
                              minHeight: 3,
                              backgroundColor: Colors.transparent,
                            )
                          : null,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                      color: Colors.black.withOpacity(0.9),
                      child: Text(
                        '${widget.page}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
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
