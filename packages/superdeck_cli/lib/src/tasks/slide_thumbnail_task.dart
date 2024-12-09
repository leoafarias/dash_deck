import 'dart:async';

import 'package:superdeck_cli/src/generator_pipeline.dart';
import 'package:superdeck_cli/src/parsers/slide_parser.dart';

/// This task marks the thumbnail file as needed if it exists.
/// The goal is to ensure that any generated thumbnails are kept.
class SlideThumbnailTask extends Task {
  SlideThumbnailTask() : super('thumbnail');

  @override
  FutureOr<TaskContext> run(context) async {
    final asset = SlideThumbnailAssetRaw.fromSlideKey(context.slide.key);

    // Basic check just to mark asset as needed
    await context.checkAssetExists(asset);

    return context;
  }
}
