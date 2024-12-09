// lib/slide_parser.dart

import 'package:collection/collection.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:superdeck_cli/src/parsers/section_parser.dart';
import 'package:superdeck_core/superdeck_core.dart';

enum AssetType {
  png,
  jpeg,
  gif,
  webp,
  svg;

  static AssetType? tryParse(String value) {
    final extension = value.toLowerCase();

    if (extension == 'jpg') {
      return AssetType.jpeg;
    }
    return AssetType.values.firstWhereOrNull((e) => e.name == extension);
  }

  static AssetType parse(String value) {
    final assetType = tryParse(value);
    if (assetType == null) {
      throw Exception('Invalid asset type: $value');
    }
    return assetType;
  }
}

sealed class AssetRaw {
  final String key;
  final String _fileName;
  final AssetType _extension;

  AssetRaw({
    required this.key,
    required String fileName,
    required AssetType extension,
  })  : _fileName = fileName,
        _extension = extension;

  String get path =>
      p.join(kGeneratedAssetsDir.path, '$_fileName.${_extension.name}');

  Future<Asset> decode() async {
    final image = await img.decodeImageFile(path);

    if (image == null) {
      throw Exception('Image could not be decoded');
    }

    return Asset(
      path: path,
      width: image.width,
      height: image.height,
      reference: key,
    );
  }
}

class SlideThumbnailAssetRaw extends AssetRaw {
  SlideThumbnailAssetRaw._({
    required super.key,
    required super.fileName,
    required super.extension,
  });

  factory SlideThumbnailAssetRaw.fromSlideKey(String slideKey) {
    return SlideThumbnailAssetRaw._(
      key: slideKey,
      fileName: 'thumbnail_$slideKey',
      extension: AssetType.png,
    );
  }
}

class CachedRemoteAssetRaw extends AssetRaw {
  CachedRemoteAssetRaw._({
    required super.key,
    required super.fileName,
    required super.extension,
  });

  factory CachedRemoteAssetRaw.fromUrl(String url) {
    return CachedRemoteAssetRaw._(
      key: url,
      fileName: assetHash(url),
      extension: AssetType.png,
    );
  }
}

sealed class MermaidAssetRaw extends AssetRaw {
  MermaidAssetRaw({
    required super.key,
    required super.fileName,
    required super.extension,
  });
}

class MermaidImageAssetRaw extends MermaidAssetRaw {
  MermaidImageAssetRaw._({
    required super.key,
    required super.fileName,
    required super.extension,
  });

  factory MermaidImageAssetRaw.fromSyntax(String mermaidSyntax) {
    final key = assetHash(mermaidSyntax);
    return MermaidImageAssetRaw._(
      key: key,
      fileName: key,
      extension: AssetType.png,
    );
  }
}

class MermaidSvgAssetRaw extends MermaidAssetRaw {
  MermaidSvgAssetRaw._({
    required super.key,
    required super.fileName,
    required super.extension,
  });

  factory MermaidSvgAssetRaw.fromSyntax(String mermaidSyntax) {
    final key = assetHash(mermaidSyntax);
    return MermaidSvgAssetRaw._(
      key: key,
      fileName: key,
      extension: AssetType.svg,
    );
  }
}

class SlideRaw {
  final String key;
  final String markdown;
  final Map<String, dynamic> frontMatter;

  SlideRaw({
    required this.key,
    required this.markdown,
    required this.frontMatter,
  });

  SlideRaw updateMarkdown(
    String markdown,
  ) {
    return SlideRaw(
      key: key,
      markdown: markdown,
      frontMatter: frontMatter,
    );
  }
}

class SlideConverter {
  static Future<Slide> convert(
    SlideRaw slideRaw,
    List<AssetRaw> assetsRaw,
  ) async {
    final regexComments = RegExp(r'<!--(.*?)-->', dotAll: true);

    final notes = <Note>[];
    final comments = regexComments.allMatches(slideRaw.markdown);

    final assetsDecodingFuture = <Future<Asset>>[];

    for (final assetRaw in assetsRaw) {
      assetsDecodingFuture.add(assetRaw.decode());
    }

    final assets = await Future.wait(assetsDecodingFuture);

    for (final comment in comments) {
      final note = {
        'content': comment.group(1)?.trim(),
      };
      Note.schema.validateOrThrow(note);
      notes.add(Note.fromMap(note));
    }

    // Whole content of the match
    return Slide.parse({
      'options': slideRaw.frontMatter,
      'markdown': slideRaw.markdown,
      'key': slideRaw.key,
    }).copyWith(
      notes: notes,
      assets: assets,
      sections: parseSections(slideRaw.markdown),
    );
  }
}
