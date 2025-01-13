import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:signals/signals_flutter.dart';
import 'package:superdeck/src/modules/presentation/slide_data.dart';

import '../modules/common/helpers/extensions.dart';
import '../modules/pdf_export/pdf_export_controller.dart';
import '../modules/presentation/presentation_hooks.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  late final PdfExportController exportController;
  late final List<SlideData> slides;
  late final int currentSlideIndex;

  @override
  void initState() {
    super.initState();
    slides = useDeck.slides();
    currentSlideIndex = useDeck.currentPage() - 1;
    exportController = PdfExportController(
      slides: slides,
      initialIndex: currentSlideIndex,
    );
  }

  @override
  void dispose() {
    exportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog.fullscreen(
          child: exportController.render(),
        ),
        Positioned.fill(
          child: Container(
            color: const Color.fromARGB(255, 14, 14, 14).withOpacity(0.9),
          ),
        ),
        Watch.builder(builder: (context) {
          final inProgress = exportController.inProgress.value;
          return inProgress
              ? PdfExportBar(exportController)
              : ExportDialog(exportController);
        }),
      ],
    );
  }
}

class PdfExportBar extends StatelessWidget {
  const PdfExportBar(this.controller, {super.key});

  final PdfExportController controller;

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
          Watch.builder(
            builder: (context) {
              final isComplete = controller.isComplete.value;
              return isComplete
                  ? Icon(
                      Icons.check_circle,
                      color: context.colorScheme.primary,
                      size: 32,
                    )
                  : SizedBox(
                      height: 32,
                      width: 32,
                      child: Watch.builder(
                        builder: (context) {
                          final isBuilding = controller.isBuilding.value;
                          final progress = controller.progress.value;
                          return CircularProgressIndicator(
                            color: context.colorScheme.primary,
                            value: isBuilding ? null : progress,
                          );
                        },
                      ),
                    );
            },
          ),
          const SizedBox(width: 16.0),
          Watch.builder(
            builder: (context) => Text(controller.progressText),
          ),
        ],
      ),
    );
  }
}

class ExportDialog extends HookWidget {
  const ExportDialog(
    this.controller, {
    super.key,
  });
  final PdfExportController controller;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select export quality:'),
            const SizedBox(height: 16.0),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 10),
                    OutlinedButton(
                      child: const Text('Export'),
                      onPressed: () => controller.start(),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
