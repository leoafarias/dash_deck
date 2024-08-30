import 'package:flutter/material.dart';

import '../styles/style_spec.dart';

BoxConstraints calculateConstraints(Size size, SlideSpec spec) {
  // final outerContainer = spec.outerContainer;
  // final innerContainer = spec.innerContainer;
  final contentContainer = spec.contentContainer;

  double horizontalSpacing = 0.0;
  double verticalSpacing = 0.0;

  for (final container in [contentContainer]) {
    final padding = container.padding ?? EdgeInsets.zero;
    final margin = container.margin ?? EdgeInsets.zero;

    double horizontalBorder = 0.0;
    double verticalBorder = 0.0;

    if (container.decoration is BoxDecoration) {
      final border = (container.decoration as BoxDecoration).border;
      if (border != null) {
        horizontalBorder = border.dimensions.horizontal;
        verticalBorder = border.dimensions.vertical;
      }
    }

    horizontalSpacing +=
        padding.horizontal + margin.horizontal + horizontalBorder;
    verticalSpacing += padding.vertical + margin.vertical + verticalBorder;
  }

  return BoxConstraints(
    maxHeight: size.height - verticalSpacing,
    maxWidth: size.width - horizontalSpacing,
  );
}

({List<T> added, List<T> removed}) compareListChanges<T>(
  List<T> oldList,
  List<T> newList,
) {
  final added = <T>[];
  final removed = <T>[];

  final oldSet = oldList.toSet();
  final newSet = newList.toSet();

  for (final item in newList) {
    if (!oldSet.contains(item)) {
      added.add(item);
    }
  }

  for (final item in oldList) {
    if (!newSet.contains(item)) {
      removed.add(item);
    }
  }

  return (
    added: added,
    removed: removed,
  );
}

extension BuildContextExt on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isSmall => size.width < 600;

  Size get size => MediaQuery.sizeOf(this);
  bool get isMedium => size.width >= 600 && size.width < 1024;

  bool get isLarge => size.width >= 1024;

  bool get isExtraLarge => size.width >= 1440;

  bool get isMobileLandscape {
    return size.shortestSide < 600 && isLandscape;
  }

  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;

  bool get isPortrait => MediaQuery.orientationOf(this) == Orientation.portrait;

  double get width => size.width;
  double get height => size.height;
}
