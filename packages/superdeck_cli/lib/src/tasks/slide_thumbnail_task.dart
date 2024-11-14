import 'dart:async';

import 'package:superdeck_cli/src/generator_pipeline.dart';

/// This task marks the thumbnail file as needed if it exists.
/// The goal is to ensure that any generated thumbnails are kept.
class SlideThumbnailTask extends Task {
  SlideThumbnailTask() : super('thumbnail');

  @override
  FutureOr<TaskContext> run(context) async {
    final file = repository.getSlideThumbnail(context.slide);

    if (await file.exists()) {
      await context.saveAsAsset(file);
    }
    return context;
  }
}
