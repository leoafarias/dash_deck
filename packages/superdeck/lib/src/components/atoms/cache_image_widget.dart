import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mix/mix.dart';
import 'package:superdeck_core/superdeck_core.dart';

import '../../modules/common/helpers/constants.dart';
import '../../modules/common/helpers/controller.dart';
import '../../modules/deck/deck_controller.dart';

class CacheImage extends StatelessWidget {
  final Uri uri;
  final BoxFit? fit;
  final ImageSpec spec;
  final Alignment? alignment;

  const CacheImage({
    required this.uri,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.spec = const ImageSpec(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = getImageProvider(context, uri);

    return AnimatedImageSpecWidget(
      image: imageProvider,
      errorBuilder: (context, error, stackTrace) {
        // display a red background with an error message
        return Container(
          color: Colors.red,
          child: Center(
            child: Text('Error loading image: $uri'),
          ),
        );
      },
      spec: spec.copyWith(
        fit: fit,
        alignment: alignment,
      ),
    );
  }
}

class CacheDecorationImage extends StatelessWidget {
  final Uri uri;
  final BoxFit? fit;
  final ImageSpec spec;
  final Alignment? alignment;

  const CacheDecorationImage({
    required this.uri,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.spec = const ImageSpec(),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = getImageProvider(context, uri);

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: fit ?? BoxFit.cover,
          alignment: alignment ?? Alignment.center,
        ),
      ),
    );
  }
}

Size calculateImageSize(Size size, SlideAsset? asset) {
  int? cacheWidth;
  int? cacheHeight;
  //  check if height or asset is larger
  if (asset != null) {
    // cache the smallest dimension of the image
    // So set the other dimension to null
    if (asset.isPortrait) {
      cacheHeight = min(size.height, asset.height).toInt();
    } else {
      cacheWidth = min(size.width, asset.width).toInt();
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

ImageProvider getImageProvider(
  BuildContext context,
  Uri uri, {
  Size? targetSize,
}) {
  final asset = Controller.of<DeckController>(context).getImageAsset(uri);

  if (asset == null) {
    return _getProvider(uri.toString());
  }

  final provider = _getProvider(asset.path);

  final size = calculateImageSize(targetSize ?? kResolution, asset);

  return ResizeImage.resizeIfNeeded(
    size.width.toInt(),
    size.height.toInt(),
    provider,
  );
}

ImageProvider _getProvider(String url) {
  if (url.startsWith('http')) {
    return CachedNetworkImageProvider(url);
  } else {
    if (kCanRunProcess) {
      return FileImage(File(url));
    } else {
      return AssetImage(url);
    }
  }
}
