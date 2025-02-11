import 'package:flutter/material.dart';
import 'package:superdeck/src/modules/common/helpers/constants.dart';
import 'package:superdeck/src/modules/common/helpers/provider.dart';
import 'package:superdeck/src/modules/deck/deck_controller.dart';
import 'package:superdeck/src/modules/export/slide_capture_service.dart';

import '../components/atoms/slide_view.dart';
import '../modules/deck/slide_configuration.dart';
import '../modules/export/export_controller.dart';

class ExportDialogScreen extends StatefulWidget {
  const ExportDialogScreen({super.key, required this.slides});

  final List<SlideConfiguration> slides;

  @override
  State<ExportDialogScreen> createState() => _ExportDialogScreenState();

  static void show(BuildContext context) {
    final deckController = DeckController.of(context);
    showDialog(
      context: context,
      builder: (context) => ExportDialogScreen(slides: deckController.slides),
    );
  }
}

class _ExportDialogScreenState extends State<ExportDialogScreen> {
  late ExportController _exportController;

  @override
  void initState() {
    super.initState();
    _setupExportController();
  }

  void _setupExportController() {
    _exportController = ExportController(
      slides: widget.slides,
      slideCaptureService: SlideCaptureService(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => _handleExport());
  }

  Future<void> _handleExport() async {
    try {
      await _exportController.export();
    } finally {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void didUpdateWidget(ExportDialogScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.slides != widget.slides) {
      _exportController.dispose();
      _setupExportController();
    }
  }

  @override
  void dispose() {
    _exportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0),
      child: SizedBox.fromSize(
        size: kResolution,
        child: ListenableBuilder(
            listenable: _exportController,
            builder: (context, _) {
              return Stack(
                children: [
                  PageView.builder(
                    controller: _exportController.pageController,
                    itemCount: _exportController.slides.length,
                    itemBuilder: (context, index) {
                      // Set to exporting true
                      final slide = _exportController.slides[index].copyWith(
                        isExporting: true,
                        debug: false,
                      );

                      return RepaintBoundary(
                        key: _exportController.getSlideKey(slide),
                        child: InheritedData(
                          data: slide,
                          child: SlideView(slide),
                        ),
                      );
                    },
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Colors.black,
                      child: Align(
                        alignment: Alignment.center,
                        child: _PdfExportBar(
                          exportController: _exportController,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}

class _PdfExportBar extends StatelessWidget {
  const _PdfExportBar({
    required this.exportController,
  });

  final ExportController exportController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          exportController.exportStatus == ExportStatus.complete
              ? Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 32,
                )
              : SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                    value:
                        exportController.exportStatus == ExportStatus.building
                            ? null
                            : exportController.progress,
                  ),
                ),
          const SizedBox(width: 16.0),
          Text(
            exportController.progressText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
