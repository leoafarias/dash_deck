import 'dart:io';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/constants.dart';

ImageProvider getImageProvider(Uri uri) {
  switch (uri.scheme) {
    case 'http':
    case 'https':
      return CachedNetworkImageProvider(uri.toString());
    default:
      if (kCanRunProcess) {
        return FileImage(File.fromUri(uri));
      } else {
        return AssetImage(uri.path);
      }
  }
}

class CachedImage extends StatelessWidget {
  final Uri uri;

  final Size? targetSize;

  final ImageSpec spec;

  const CachedImage({
    super.key,
    this.targetSize,
    required this.uri,
    this.spec = const ImageSpec(),
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = getImageProvider(uri);

    return AnimatedImageSpecWidget(
      image: imageProvider,
      spec: spec,
      // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
      //   return Container(
      //     padding: const EdgeInsets.all(0),
      //     constraints: BoxConstraints.loose(imageSize ?? size),
      //     decoration: BoxDecoration(
      //       color: Colors.green,
      //       image: DecorationImage(
      //         image: imageProvider,
      //         fit: widget.spec.fit,
      //         alignment: widget.spec.alignment ?? Alignment.center,
      //       ),
      //     ),
      //   );
      // },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.red,
          child: Center(
            child: Text('Error loading image: $uri '),
          ),
        );
      },
    );
  }
}

Size _calculateImageSize(Size size, Asset? asset) {
  int? cacheWidth;
  int? cacheHeight;
  //  check if height or asset is larger
  if (asset != null) {
    // cache the smallest dimension of the image
    // So set the other dimension to null
    if (asset.isPortrait) {
      cacheHeight = math.min(size.height, asset.height).toInt();
    } else {
      cacheWidth = math.min(size.width, asset.width).toInt();
    }
  } else {
    // If no asset is available, set both cacheWidth and cacheHeight
    final ifHeightIsBigger = size.height > size.width;

// cache the smallest
    if (ifHeightIsBigger) {
      cacheWidth = size.width.toInt();
    } else {
      cacheHeight = size.height.toInt();
    }
  }

  return Size(
    cacheWidth?.toDouble() ?? size.width,
    cacheHeight?.toDouble() ?? size.height,
  );
}
