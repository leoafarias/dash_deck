import 'dart:async';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:superdeck/src/components/atoms/slide_view.dart';
import 'package:superdeck/src/modules/thumbnail/slide_capture_service.dart';

import '../modules/deck/deck_configuration.dart';

enum _ExportStatus { idle, capturing, building, complete }

class ExportScreen extends HookWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve slides and current slide index using custom hooks or context
    final slides = DeckConfiguration.of(context).slides;
    final currentSlideIndex = useState(0);

    // Initialize PageController with the initial index
    final pageController =
        usePageController(initialPage: currentSlideIndex.value);

    // Create a map of GlobalKeys for each slide using useMemo
    final slideKeys = useMemoized(
      () => {for (var slide in slides) slide.key: GlobalKey()},
      [slides],
    );

    // Manage export status using useState
    final exportStatus = useState<_ExportStatus>(_ExportStatus.idle);

    // Manage captured images using useState
    final images = useState<List<Uint8List>>([]);

    // Manage progress text using useMemo based on export status and images
    final progressText = useMemoized(
      () => switch (exportStatus.value) {
        _ExportStatus.building => 'Building PDF...',
        _ExportStatus.complete => 'Done',
        _ExportStatus.capturing =>
          'Exporting ${images.value.length} / ${slides.length}',
        _ExportStatus.idle =>
          'Exporting ${images.value.length} / ${slides.length}',
      },
      [exportStatus.value, images.value.length, slides.length],
    );

    // Initialize SlideCaptureService
    final slideCaptureService = useMemoized(() => SlideCaptureService(), []);

    // Function to wait for a short duration
    Future<void> waitShort() async {
      await Future.delayed(Durations.short1);
    }

    // Function to capture a single slide
    Future<void> captureSlide(int index) async {
      final slide = slides[index];
      final key = slideKeys[slide.key]!;

      // Navigate to the slide's page
      pageController.jumpToPage(index);

      // Wait until the slide's RenderObject is attached
      while (!(key.currentContext?.findRenderObject()?.attached ?? false)) {
        await waitShort();
      }

      // Capture the slide as an image
      final image = await slideCaptureService.generateWithKey(
        quality: SlideCaptureQuality.best, // Adjust as needed
        key: key,
      );

      // Update images list
      images.value = [...images.value, image];
    }

    // Function to build PDF from images
    Future<Uint8List> buildPdf(List<Uint8List> images) async {
      // Implement your PDF building logic here
      // This is a placeholder implementation
      // You can use packages like pdf or printing
      return Uint8List(0);
    }

    // Function to save the PDF file
    Future<void> savePdf(Uint8List pdf) async {
      try {
        final result = await FileSaver.instance.saveFile(
          name: 'superdeck',
          bytes: pdf,
          ext: 'pdf',
          mimeType: MimeType.pdf,
        );
        print('Save as result: $result');
      } catch (e) {
        print('Error saving pdf: $e');
      }
    }

    // Effect to start the export process when the widget is first built
    useEffect(() {
      Future<void> startExport() async {
        final currentPage = pageController.page?.toInt() ?? 0;
        exportStatus.value = _ExportStatus.capturing;

        // Start capturing each slide
        for (var i = 0; i < slides.length; i++) {
          await captureSlide(i);
        }

        // Update status to building PDF
        exportStatus.value = _ExportStatus.building;
        await waitShort();

        // Build the PDF
        final pdf = await buildPdf(images.value);
        await waitShort();

        // Navigate back to the original page
        pageController.jumpToPage(currentPage);

        // Update status to complete
        exportStatus.value = _ExportStatus.complete;
        images.value = [];
        await savePdf(pdf);
        await waitShort();

        // Reset status to idle
        exportStatus.value = _ExportStatus.idle;
      }

      // Start the export process
      startExport();

      return null; // No cleanup needed
    }, [slides, pageController, slideKeys, slideCaptureService]);

    return Column(
      children: [
        PageView.builder(
          controller: pageController,
          itemCount: slides.length,
          itemBuilder: (context, index) {
            final slide = slides[index];
            return RepaintBoundary(
              key: slideKeys[slide.key],
              child: SlideView(slide),
            );
          },
        ),
        _PdfExportBar(
          status: exportStatus.value,
          progress: images.value.length / slides.length,
          progressText: progressText,
        ),
      ],
    );
  }
}

class _PdfExportBar extends StatelessWidget {
  const _PdfExportBar({
    super.key,
    required this.status,
    required this.progress,
    required this.progressText,
  });

  final _ExportStatus status;
  final double progress;
  final String progressText;

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
          status == _ExportStatus.complete
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
                    value: status == _ExportStatus.building ? null : progress,
                  ),
                ),
          const SizedBox(width: 16.0),
          Text(
            progressText,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
