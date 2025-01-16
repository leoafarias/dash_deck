import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:superdeck_core/src/models/block_model.dart';

class FileMapper extends SimpleMapper<File> {
  const FileMapper();

  @override
  File decode(Object value) {
    return File(value as String);
  }

  @override
  String encode(File self) {
    return self.path;
  }
}

class DurationMapper extends SimpleMapper<Duration> {
  const DurationMapper();

  @override
  Duration decode(Object value) {
    return Duration(milliseconds: value as int);
  }

  @override
  int encode(Duration self) {
    return self.inMilliseconds;
  }
}

class NullIfEmptyBlock extends SimpleMapper<LayoutElement> {
  const NullIfEmptyBlock();

  @override
  LayoutElement decode(dynamic value) {
    return LayoutElementMapper.fromMap(value);
  }

  @override
  dynamic encode(LayoutElement self) {
    final map = self.toMap();
    if (map.isEmpty) {
      return null;
    }
    return map;
  }
}
