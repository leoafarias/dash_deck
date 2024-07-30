import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:superdeck/helpers/utils.dart';
import 'package:superdeck/superdeck.dart';

void main() {
  group('AssetFileType', () {
    test('parse should return correct enum value', () {
      expect(AssetFileType.parse('png'), AssetFileType.png);
      expect(AssetFileType.parse('jpg'), AssetFileType.jpg);
      expect(AssetFileType.parse('jpeg'), AssetFileType.jpeg);
      expect(AssetFileType.parse('gif'), AssetFileType.gif);
      expect(AssetFileType.parse('webp'), AssetFileType.webp);
    });

    test('parse should throw exception for invalid value', () {
      expect(() => AssetFileType.parse('invalid'), throwsException);
    });

    test('tryParse should return correct enum value', () {
      expect(AssetFileType.tryParse('png'), AssetFileType.png);
      expect(AssetFileType.tryParse('jpg'), AssetFileType.jpg);
      expect(AssetFileType.tryParse('jpeg'), AssetFileType.jpeg);
      expect(AssetFileType.tryParse('gif'), AssetFileType.gif);
      expect(AssetFileType.tryParse('webp'), AssetFileType.webp);
    });

    test('tryParse should return null for invalid value', () {
      expect(AssetFileType.tryParse('invalid'), isNull);
    });

    test('isPng should return true for png', () {
      expect(AssetFileType.png.isPng(), isTrue);
    });

    test('isJpg should return true for jpg and jpeg', () {
      expect(AssetFileType.jpg.isJpg(), isTrue);
      expect(AssetFileType.jpeg.isJpg(), isTrue);
    });

    test('isGif should return true for gif', () {
      expect(AssetFileType.gif.isGif(), isTrue);
    });
  });

  group('SlideAssetType', () {
    test('parse should return correct enum value', () {
      expect(SlideAssetType.parse('cached'), SlideAssetType.cached);
      expect(SlideAssetType.parse('thumb'), SlideAssetType.thumb);
      expect(SlideAssetType.parse('mermaid'), SlideAssetType.mermaid);
    });

    test('parse should throw exception for invalid value', () {
      expect(() => SlideAssetType.parse('invalid'), throwsException);
    });

    test('tryParse should return correct enum value', () {
      expect(SlideAssetType.tryParse('cached'), SlideAssetType.cached);
      expect(SlideAssetType.tryParse('thumb'), SlideAssetType.thumb);
      expect(SlideAssetType.tryParse('mermaid'), SlideAssetType.mermaid);
    });

    test('tryParse should return null for invalid value', () {
      expect(SlideAssetType.tryParse('invalid'), isNull);
    });
  });

  group('SlideAsset', () {
    late SlideAsset asset;
    late File file;
    late Size dimensions;

    setUp(() {
      file = File('test.png');
      dimensions = const Size(800, 600);
      asset = SlideAsset(file: file, dimensions: dimensions);
    });

    test('extension should return correct file extension', () {
      expect(asset.extension, '.png');
    });

    test('isPortrait should return true when height is greater than width', () {
      expect(asset.isPortrait, isFalse);
    });

    test('isLandscape should return true when width is greater than height',
        () {
      dimensions = const Size(1200, 800);
      asset = SlideAsset(file: file, dimensions: dimensions);
      expect(asset.isLandscape, isTrue);
    });

    test('thumbnail should return correct file path', () {
      final slide = SimpleSlide(
          contentOptions: const ContentOptions(), raw: '', data: '');
      final thumbnailFile = SlideAsset.thumbnail(slide);
      expect(thumbnailFile.path, endsWith('${slide.hashKey}.png'));
    });

    test('cached should return correct file path', () {
      const uri = 'https://example.com/image.png';
      final cachedFile = SlideAsset.cached(uri);
      expect(cachedFile.path, endsWith('${shortHashId(uri)}.png'));
    });

    test('mermaid should return correct file path', () {
      const mermaidSyntax = 'graph TD; A-->B;';
      final mermaidFile = SlideAsset.mermaid(mermaidSyntax);
      expect(mermaidFile.path, endsWith('${shortHashId(mermaidSyntax)}.png'));
    });
  });
}
