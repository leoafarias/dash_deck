import 'package:flutter/material.dart';

class SlideParts {
  const SlideParts({
    this.header,
    this.footer,
    this.background,
  });

  final PreferredSizeWidget? header;
  final PreferredSizeWidget? footer;
  final Widget? background;
}
