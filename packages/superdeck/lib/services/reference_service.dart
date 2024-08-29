import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:superdeck_core/superdeck_core.dart';

import '../helpers/constants.dart';
import '../helpers/watcher.dart';

final _assetDir = Directory(p.join('.superdeck'));
final _slideRef = File(p.join(_assetDir.path, 'slides.json'));
final _generatedDir = Directory(p.join(_assetDir.path, 'generated'));
final _markdown = File('slides.md');

class ReferenceService {
  final _watcher = FileWatcher(_slideRef);
  ReferenceService();

  Future<String> loadString(String path) async {
    if (kCanRunProcess) {
      return File(path).readAsString();
    } else {
      return rootBundle.loadString(path);
    }
  }

  Future<String> loadMarkdown() async {
    return _markdown.readAsString();
  }

  // Future<ByteData> loadBytes(String path) async {
  //   if (kCanRunProcess) {
  //     final bytes = await File(path).readAsBytes();
  //     return ByteData.view(Uint8List.fromList(bytes).buffer);
  //   } else {
  //     return await rootBundle.load(path);
  //   }
  // }

  Future<void> saveMarkdown(String data) async {
    await _markdown.writeAsString(data);
  }

  File getAssetFile(String fileName) {
    return File(p.join(_generatedDir.path, fileName));
  }

  void listen(FutureOr<void> Function() callback) {
    if (kCanRunProcess) {
      if (!_watcher.isWatching) {
        _watcher.start(callback);
      }
    }
  }

  void stop() => _watcher.stop();

  Future<ReferenceDto> loadReference() async {
    final slidesJson = await loadString(_slideRef.path);
    try {
      return compute(ReferenceDto.fromJson, slidesJson);
    } catch (e) {
      log('Error loading deck: $e');
      return const ReferenceDto.empty();
    }
  }
}
