import 'dart:async';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:signals/signals_flutter.dart';

import '../../components/molecules/slide_screen.dart';
import '../common/helpers/constants.dart';
import '../presentation/slide_data.dart';
import '../thumbnail/slide_capture_service.dart';

enum PdfExportStatus {
  idle,
  capturing,
  building,
  complete,
}

class PdfExportController {
  final quality = signal(SlideCaptureQuality.good);

  final _status = signal(PdfExportStatus.idle);
  final images = listSignal<Uint8List>([]);

  late final PageController _pageController;
  final _slideCaptureService = SlideCaptureService();

  /// Create a map for keys and GlobalKey for each slide
  Map<String, GlobalKey> _slideKeys = {};

  final slides = signal(List<SlideData>.empty());

  late final isComplete =
      computed(() => status.value == PdfExportStatus.complete);
  late final inProgress = computed(() => status.value != PdfExportStatus.idle);
  late final isBuilding =
      computed(() => status.value == PdfExportStatus.building);
  late final progress =
      computed(() => images.value.length / slides.value.length);

  PdfExportController({
    required List<SlideData> slides,
    required int initialIndex,
  }) {
    this.slides.value = slides;
    _slideKeys = {for (var slide in slides) slide.key: GlobalKey()};
    _pageController = PageController(initialPage: initialIndex);
  }

  String get progressText {
    return switch (_status.value) {
      PdfExportStatus.building => 'Building PDF...',
      PdfExportStatus.complete => 'Done',
      PdfExportStatus.capturing =>
        'Exporting ${images.value.length} / ${slides.value.length}',
      PdfExportStatus.idle =>
        'Exporting ${images.value.length} / ${slides.value.length}',
    };
  }

  late final status = computed(() => _status.value);

  Future<void> _wait() async {
    await Future.delayed(Durations.short1);
  }

  void dispose() {
    _pageController.dispose();
    _slideKeys.clear();
    images.dispose();
    slides.dispose();
    status.dispose();
    isComplete.dispose();
    inProgress.dispose();
    isBuilding.dispose();
    progress.dispose();
  }

  Future<void> start() async {
    final currentPage = _pageController.page?.toInt() ?? 0;
    _status.value = PdfExportStatus.capturing;
    _pageController.jumpToPage(0);

    for (var i = 0; i < slides.value.length; i++) {
      await _convertSlide(i);
    }
    await _wait();
    _status.value = PdfExportStatus.building;
    await _wait();

    final pdf = await _buildPdf(images.value);
    await _wait();
    _pageController.jumpToPage(currentPage);

    _status.value = PdfExportStatus.complete;
    images.value = [];
    await _savePdf(pdf);
    await _wait();
    _status.value = PdfExportStatus.idle;
  }

  Widget render() {
    return PageView.builder(
      controller: _pageController,
      itemCount: slides.value.length,
      itemBuilder: (_, index) {
        final slide = slides.value[index];

        return RepaintBoundary(
          key: _slideKeys[slide.key],
          child: SlideScreen(index),
        );
      },
    );
  }

  Future<void> _convertSlide(int index) async {
    final slide = slides.value[index];
    final key = _slideKeys[slide.key]!;

    _pageController.jumpToPage(index);

    // Keep checking until key is attached to the widget
    while (!(key.currentContext?.findRenderObject()?.attached ?? false)) {
      await _wait();
    }

    final image = await _slideCaptureService.generateWithKey(
      quality: quality.value,
      key: _slideKeys[slide.key]!,
    );
    images.value = [...images.value, image];
  }

  Future<void> _savePdf(Uint8List pdf) async {
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
}

Future<Uint8List> _buildPdf(List<Uint8List> images) async {
  final pdf = pw.Document();

  for (final imageData in images) {
    // see how logn this takes per page
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
