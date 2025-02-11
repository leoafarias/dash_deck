import 'dart:async';
import 'dart:developer';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:superdeck/src/modules/common/helpers/constants.dart';
import 'package:superdeck/src/modules/deck/slide_configuration.dart';
import 'package:universal_html/html.dart' as html;

import 'slide_capture_service.dart';

enum ExportStatus { idle, capturing, building, complete, preparing }

class ExportController extends ChangeNotifier {
  ExportController({
    required this.slides,
    required this.slideCaptureService,
    Duration waitDuration = const Duration(milliseconds: 100),
  }) : _waitDuration = waitDuration {
    // Create a PageController and build the keys for the slides.
    _pageController = PageController(initialPage: 0);
    _slideKeys = {
      for (var slide in slides) slide.key: GlobalKey(),
    };
  }

  late final PageController _pageController;
  late final Map<String, GlobalKey> _slideKeys;
  ExportStatus _exportStatus = ExportStatus.idle;
  final List<Uint8List> _images = [];

  bool _disposed = false;

  /// The list of slides to export.df
  final List<SlideConfiguration> slides;

  /// Service used to capture slides.
  final SlideCaptureService slideCaptureService;

  /// A duration used to wait between operations.
  final Duration _waitDuration;

  bool get disposed => _disposed;

  PageController get pageController => _pageController;

  GlobalKey getSlideKey(SlideConfiguration slide) => _slideKeys[slide.key]!;

  ExportStatus get exportStatus => _exportStatus;

  double get progress =>
      _slideKeys.isNotEmpty ? _images.length / _slideKeys.length : 0.0;

  String get progressText {
    return switch (_exportStatus) {
      ExportStatus.building => 'Building PDF...',
      ExportStatus.complete => 'Done',
      ExportStatus.capturing =>
        'Exporting ${_images.length} / ${_slideKeys.length}',
      ExportStatus.idle => 'Exporting ${_images.length} / ${_slideKeys.length}',
      ExportStatus.preparing => 'Preparing...',
    };
  }

  Future<void> _waitForRenderBoundaryPaint(GlobalKey key) async {
    // First, wait until the key’s context is available.
    while (key.currentContext == null) {
      await Future.delayed(const Duration(milliseconds: 10));
    }

    final repaintBoundary = key.currentContext!.findRenderObject()!;

    final isAttached = repaintBoundary.attached;

    // Now, wait until the widget is attached.
    while (!isAttached) {
      await Future.delayed(const Duration(milliseconds: 10));
    }

    // Await the end of the frame to ensure painting is complete.
    await WidgetsBinding.instance.endOfFrame;
  }

  Future<Uint8List> _captureImageWithRetry(GlobalKey key) async {
    const int maxAttempts = 3;
    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final image = await slideCaptureService.captureFromKey(
          quality:
              kIsWeb ? SlideCaptureQuality.low : SlideCaptureQuality.better,
          key: key,
        );
        return image;
      } catch (error) {
        if (attempt == maxAttempts) {
          // If we've reached the maximum number of attempts, rethrow the error.
          rethrow;
        }
        // Wait 100 milliseconds before retrying.
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
    // This line should never be reached.
    throw Exception('Failed to capture image after $maxAttempts attempts.');
  }

  Future<void> prepare() async {
    for (var i = 0; i < _slideKeys.length; i++) {
      final slide = slides[i];
      final key = _slideKeys[slide.key]!;

      // Navigate to the slide.
      await _pageController.animateToPage(
        i,
        duration: const Duration(milliseconds: 1),
        curve: Curves.linear,
      );

      await _waitForRenderBoundaryPaint(key);
    }
  }

  /// Starts the export process.
  Future<void> export() async {
    _exportStatus = ExportStatus.preparing;
    notifyListeners();

    await prepare();

    _exportStatus = ExportStatus.capturing;
    notifyListeners();

    for (var i = 0; i < _slideKeys.length; i++) {
      final slide = slides[i];
      final key = _slideKeys[slide.key]!;

      // Navigate to the slide.
      await _pageController.animateToPage(
        i,
        duration: const Duration(milliseconds: 1),
        curve: Curves.linear,
      );

      await _waitForRenderBoundaryPaint(key);

      if (disposed) return;

      // Capture the slide as an image.
      final image = await _captureImageWithRetry(key);

      if (disposed) return;
      _images.add(image);
      notifyListeners();
    }

    _exportStatus = ExportStatus.building;
    notifyListeners();
    await Future.delayed(_waitDuration);

    if (disposed) return;

    // Build the PDF from the captured images.
    final pdf = await compute(_buildPdf, [..._images]);

    if (disposed) return;

    // Restore the original page.

    notifyListeners();

    await _savePdf(pdf);

    // Reset state.
    _exportStatus = ExportStatus.complete;
    _images.clear();
    notifyListeners();
  }

  /// Saves the generated PDF file.
  Future<void> _savePdf(Uint8List pdf) async {
    try {
      if (kIsWeb) {
        // Create a Blob from the PDF bytes
        final blob = html.Blob([pdf], 'application/pdf');

        // Create a URL for the Blob
        final url = html.Url.createObjectUrlFromBlob(blob);

        html.AnchorElement(href: url)
          ..setAttribute('download', 'superdeck.pdf')
          ..click();

        return;
      }
      log('Saving pdf');
      final result = await FileSaver.instance.saveAs(
        name: 'superdeck',
        bytes: pdf,
        ext: 'pdf',
        mimeType: MimeType.pdf,
      );
      log('Save result: $result');
    } catch (e) {
      log('Error saving pdf: $e');
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _pageController.dispose();
    super.dispose();
  }
}

Future<Uint8List> _buildPdf(List<Uint8List> images) async {
  final pdf = pw.Document();

  for (final imageData in images) {
    final image = pw.MemoryImage(imageData);

    final pdfImage = pw.Image(
      image,
      width: kResolution.width,
      height: kResolution.height,
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat(
          kResolution.width,
          kResolution.height,
        ),
        build: (pw.Context context) {
          return pw.Center(
            child: pdfImage,
          );
        },
      ),
    );
  }

  return await pdf.save();
}
