import 'dart:async';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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

class PdfExportController extends ChangeNotifier {
  SlideCaptureQuality _quality = SlideCaptureQuality.good;
  PdfExportStatus _status = PdfExportStatus.idle;
  List<Uint8List> _images = [];
  late final PageController _pageController;

  /// Create a map for keys and GlobalKey for each slide
  Map<String, GlobalKey> _slideKeys = {};

  late final List<SlideData> _slides;

  bool get isComplete => _status == PdfExportStatus.complete;

  PdfExportController({
    required List<SlideData> slides,
    required int initialIndex,
  }) : _slides = slides {
    _slideKeys = {for (var slide in _slides) slide.key: GlobalKey()};
    _pageController = PageController(initialPage: initialIndex);
  }

  bool get inProgress => _status != PdfExportStatus.idle;

  bool get isBuilding => _status == PdfExportStatus.building;

  double get progress => _images.length / _slides.length;

  String get progressText {
    if (isBuilding) {
      return 'Building PDF...';
    }
    return isComplete
        ? 'Done'
        : 'Exporting ${_images.length} / ${_slides.length}';
  }

  SlideCaptureQuality get quality => _quality;

  set quality(SlideCaptureQuality quality) {
    if (_quality == quality) return;
    _quality = quality;
    notifyListeners();
  }

  PdfExportStatus get status => _status;

  Future<void> _wait() async {
    await Future.delayed(Durations.short1);
  }

  Future<void> start() async {
    final currentPage = _pageController.page?.toInt() ?? 0;
    _status = PdfExportStatus.capturing;
    _pageController.jumpToPage(0);
    notifyListeners();

    for (var i = 0; i < _slides.length; i++) {
      await _convertSlide(i);
    }
    await _wait();
    _status = PdfExportStatus.building;
    notifyListeners();
    await _wait();

    final pdf = await _buildPdf(_images);
    await _wait();
    _pageController.jumpToPage(currentPage);

    _status = PdfExportStatus.complete;
    _images = [];
    notifyListeners();
    await _savePdf(pdf);
    await _wait();
    _status = PdfExportStatus.idle;
    notifyListeners();
  }

  Future<void> _convertSlide(int index) async {
    final slide = _slides[index];
    final key = _slideKeys[slide.key]!;

    _pageController.jumpToPage(index);

    // Keep checking until key is attached to the widget
    while (!(key.currentContext?.findRenderObject()?.attached ?? false)) {
      await _wait();
    }

    final image = await SlideCaptureService.instance.generateWithKey(
      quality: _quality,
      key: _slideKeys[slide.key]!,
    );
    _images = [..._images, image];
    notifyListeners();
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

  Widget render() {
    return PageView.builder(
      controller: _pageController,
      itemCount: _slides.length,
      itemBuilder: (_, index) {
        final slide = _slides[index];

        return RepaintBoundary(
          key: _slideKeys[slide.key],
          child: SlideScreen(index),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}

PdfExportController usePdfExportController({
  required List<SlideData> slides,
  required int slideIndex,
}) {
  return use(_PdfExportControllerHook(
    slides: slides,
    initialSlideIndex: slideIndex,
  ));
}

class _PdfExportControllerHook extends Hook<PdfExportController> {
  const _PdfExportControllerHook({
    required this.slides,
    required this.initialSlideIndex,
  });

  final List<SlideData> slides;
  final int initialSlideIndex;

  @override
  _PdfExportControllerHookState createState() =>
      _PdfExportControllerHookState();
}

class _PdfExportControllerHookState
    extends HookState<PdfExportController, _PdfExportControllerHook> {
  late PdfExportController controller;

  void _attachController({bool update = false}) {
    if (update) {
      controller.dispose();
    }
    controller = PdfExportController(
      slides: hook.slides,
      initialIndex: hook.initialSlideIndex,
    );

    controller.addListener(() {
      setState(() {});
    });

    if (update) {
      setState(() {});
    }
  }

  @override
  void initHook() {
    super.initHook();

    _attachController();
  }

  @override
  void didUpdateHook(_PdfExportControllerHook oldHook) {
    super.didUpdateHook(oldHook);
    if (oldHook.slides != hook.slides) {
      _attachController(update: true);
    }
  }

  @override
  PdfExportController build(BuildContext context) {
    return controller;
  }

  @override
  void dispose() {
    controller.dispose();
  }
}
