// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_model.dart';

class SlideConfigMapper extends ClassMapperBase<SlideConfig> {
  SlideConfigMapper._();

  static SlideConfigMapper? _instance;
  static SlideConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideConfigMapper._());
      SimpleSlideConfigMapper.ensureInitialized();
      ImageSlideConfigMapper.ensureInitialized();
      TwoColumnSlideConfigMapper.ensureInitialized();
      TwoColumnHeaderSlideConfigMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SlideConfig';

  static String _$id(SlideConfig v) => v.id;
  static const Field<SlideConfig, String> _f$id = Field('id', _$id);
  static String? _$background(SlideConfig v) => v.background;
  static const Field<SlideConfig, String> _f$background =
      Field('background', _$background, opt: true);
  static String _$content(SlideConfig v) => v.content;
  static const Field<SlideConfig, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static ContentAlignment _$contentAlignment(SlideConfig v) =>
      v.contentAlignment;
  static const Field<SlideConfig, ContentAlignment> _f$contentAlignment = Field(
      'contentAlignment', _$contentAlignment,
      opt: true, def: ContentAlignment.centerLeft);

  @override
  final MappableFields<SlideConfig> fields = const {
    #id: _f$id,
    #background: _f$background,
    #content: _f$content,
    #contentAlignment: _f$contentAlignment,
  };

  static SlideConfig _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('SlideConfig');
  }

  @override
  final Function instantiate = _instantiate;

  static SlideConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideConfig>(map);
  }

  static SlideConfig fromJson(String json) {
    return ensureInitialized().decodeJson<SlideConfig>(json);
  }
}

mixin SlideConfigMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SlideConfigCopyWith<SlideConfig, SlideConfig, SlideConfig> get copyWith;
}

abstract class SlideConfigCopyWith<$R, $In extends SlideConfig, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? background, String? content});
  SlideConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SimpleSlideConfigMapper extends ClassMapperBase<SimpleSlideConfig> {
  SimpleSlideConfigMapper._();

  static SimpleSlideConfigMapper? _instance;
  static SimpleSlideConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SimpleSlideConfigMapper._());
      SlideConfigMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SimpleSlideConfig';

  static String _$id(SimpleSlideConfig v) => v.id;
  static const Field<SimpleSlideConfig, String> _f$id = Field('id', _$id);
  static String? _$background(SimpleSlideConfig v) => v.background;
  static const Field<SimpleSlideConfig, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(SimpleSlideConfig v) =>
      v.contentAlignment;
  static const Field<SimpleSlideConfig, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment,
          opt: true, def: ContentAlignment.centerLeft);
  static String _$content(SimpleSlideConfig v) => v.content;
  static const Field<SimpleSlideConfig, String> _f$content =
      Field('content', _$content, opt: true, def: '');

  @override
  final MappableFields<SimpleSlideConfig> fields = const {
    #id: _f$id,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
  };

  static SimpleSlideConfig _instantiate(DecodingData data) {
    return SimpleSlideConfig(
        id: data.dec(_f$id),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static SimpleSlideConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SimpleSlideConfig>(map);
  }

  static SimpleSlideConfig fromJson(String json) {
    return ensureInitialized().decodeJson<SimpleSlideConfig>(json);
  }
}

mixin SimpleSlideConfigMappable {
  String toJson() {
    return SimpleSlideConfigMapper.ensureInitialized()
        .encodeJson<SimpleSlideConfig>(this as SimpleSlideConfig);
  }

  Map<String, dynamic> toMap() {
    return SimpleSlideConfigMapper.ensureInitialized()
        .encodeMap<SimpleSlideConfig>(this as SimpleSlideConfig);
  }

  SimpleSlideConfigCopyWith<SimpleSlideConfig, SimpleSlideConfig,
          SimpleSlideConfig>
      get copyWith => _SimpleSlideConfigCopyWithImpl(
          this as SimpleSlideConfig, $identity, $identity);
  @override
  String toString() {
    return SimpleSlideConfigMapper.ensureInitialized()
        .stringifyValue(this as SimpleSlideConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            SimpleSlideConfigMapper.ensureInitialized()
                .isValueEqual(this as SimpleSlideConfig, other));
  }

  @override
  int get hashCode {
    return SimpleSlideConfigMapper.ensureInitialized()
        .hashValue(this as SimpleSlideConfig);
  }
}

extension SimpleSlideConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SimpleSlideConfig, $Out> {
  SimpleSlideConfigCopyWith<$R, SimpleSlideConfig, $Out>
      get $asSimpleSlideConfig =>
          $base.as((v, t, t2) => _SimpleSlideConfigCopyWithImpl(v, t, t2));
}

abstract class SimpleSlideConfigCopyWith<$R, $In extends SimpleSlideConfig,
    $Out> implements SlideConfigCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? background,
      ContentAlignment? contentAlignment,
      String? content});
  SimpleSlideConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SimpleSlideConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SimpleSlideConfig, $Out>
    implements SimpleSlideConfigCopyWith<$R, SimpleSlideConfig, $Out> {
  _SimpleSlideConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SimpleSlideConfig> $mapper =
      SimpleSlideConfigMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          Object? background = $none,
          ContentAlignment? contentAlignment,
          String? content}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (background != $none) #background: background,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (content != null) #content: content
      }));
  @override
  SimpleSlideConfig $make(CopyWithData data) => SimpleSlideConfig(
      id: data.get(#id, or: $value.id),
      background: data.get(#background, or: $value.background),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      content: data.get(#content, or: $value.content));

  @override
  SimpleSlideConfigCopyWith<$R2, SimpleSlideConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SimpleSlideConfigCopyWithImpl($value, $cast, t);
}

class ImageSlideConfigMapper extends ClassMapperBase<ImageSlideConfig> {
  ImageSlideConfigMapper._();

  static ImageSlideConfigMapper? _instance;
  static ImageSlideConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageSlideConfigMapper._());
      SlideConfigMapper.ensureInitialized();
      ImageFitMapper.ensureInitialized();
      ImagePositionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageSlideConfig';

  static String _$id(ImageSlideConfig v) => v.id;
  static const Field<ImageSlideConfig, String> _f$id = Field('id', _$id);
  static ImageFit _$imageFit(ImageSlideConfig v) => v.imageFit;
  static const Field<ImageSlideConfig, ImageFit> _f$imageFit =
      Field('imageFit', _$imageFit, opt: true, def: ImageFit.cover);
  static String _$image(ImageSlideConfig v) => v.image;
  static const Field<ImageSlideConfig, String> _f$image =
      Field('image', _$image, opt: true, def: '');
  static ImagePosition _$imagePosition(ImageSlideConfig v) => v.imagePosition;
  static const Field<ImageSlideConfig, ImagePosition> _f$imagePosition = Field(
      'imagePosition', _$imagePosition,
      opt: true, def: ImagePosition.left);
  static String? _$background(ImageSlideConfig v) => v.background;
  static const Field<ImageSlideConfig, String> _f$background =
      Field('background', _$background, opt: true);
  static String _$content(ImageSlideConfig v) => v.content;
  static const Field<ImageSlideConfig, String> _f$content =
      Field('content', _$content, opt: true, def: '');
  static ContentAlignment _$contentAlignment(ImageSlideConfig v) =>
      v.contentAlignment;
  static const Field<ImageSlideConfig, ContentAlignment> _f$contentAlignment =
      Field('contentAlignment', _$contentAlignment, mode: FieldMode.member);

  @override
  final MappableFields<ImageSlideConfig> fields = const {
    #id: _f$id,
    #imageFit: _f$imageFit,
    #image: _f$image,
    #imagePosition: _f$imagePosition,
    #background: _f$background,
    #content: _f$content,
    #contentAlignment: _f$contentAlignment,
  };

  static ImageSlideConfig _instantiate(DecodingData data) {
    return ImageSlideConfig(
        id: data.dec(_f$id),
        imageFit: data.dec(_f$imageFit),
        image: data.dec(_f$image),
        imagePosition: data.dec(_f$imagePosition),
        background: data.dec(_f$background),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageSlideConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageSlideConfig>(map);
  }

  static ImageSlideConfig fromJson(String json) {
    return ensureInitialized().decodeJson<ImageSlideConfig>(json);
  }
}

mixin ImageSlideConfigMappable {
  String toJson() {
    return ImageSlideConfigMapper.ensureInitialized()
        .encodeJson<ImageSlideConfig>(this as ImageSlideConfig);
  }

  Map<String, dynamic> toMap() {
    return ImageSlideConfigMapper.ensureInitialized()
        .encodeMap<ImageSlideConfig>(this as ImageSlideConfig);
  }

  ImageSlideConfigCopyWith<ImageSlideConfig, ImageSlideConfig, ImageSlideConfig>
      get copyWith => _ImageSlideConfigCopyWithImpl(
          this as ImageSlideConfig, $identity, $identity);
  @override
  String toString() {
    return ImageSlideConfigMapper.ensureInitialized()
        .stringifyValue(this as ImageSlideConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ImageSlideConfigMapper.ensureInitialized()
                .isValueEqual(this as ImageSlideConfig, other));
  }

  @override
  int get hashCode {
    return ImageSlideConfigMapper.ensureInitialized()
        .hashValue(this as ImageSlideConfig);
  }
}

extension ImageSlideConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageSlideConfig, $Out> {
  ImageSlideConfigCopyWith<$R, ImageSlideConfig, $Out>
      get $asImageSlideConfig =>
          $base.as((v, t, t2) => _ImageSlideConfigCopyWithImpl(v, t, t2));
}

abstract class ImageSlideConfigCopyWith<$R, $In extends ImageSlideConfig, $Out>
    implements SlideConfigCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      ImageFit? imageFit,
      String? image,
      ImagePosition? imagePosition,
      String? background,
      String? content});
  ImageSlideConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ImageSlideConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageSlideConfig, $Out>
    implements ImageSlideConfigCopyWith<$R, ImageSlideConfig, $Out> {
  _ImageSlideConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageSlideConfig> $mapper =
      ImageSlideConfigMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          ImageFit? imageFit,
          String? image,
          ImagePosition? imagePosition,
          Object? background = $none,
          String? content}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (imageFit != null) #imageFit: imageFit,
        if (image != null) #image: image,
        if (imagePosition != null) #imagePosition: imagePosition,
        if (background != $none) #background: background,
        if (content != null) #content: content
      }));
  @override
  ImageSlideConfig $make(CopyWithData data) => ImageSlideConfig(
      id: data.get(#id, or: $value.id),
      imageFit: data.get(#imageFit, or: $value.imageFit),
      image: data.get(#image, or: $value.image),
      imagePosition: data.get(#imagePosition, or: $value.imagePosition),
      background: data.get(#background, or: $value.background),
      content: data.get(#content, or: $value.content));

  @override
  ImageSlideConfigCopyWith<$R2, ImageSlideConfig, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageSlideConfigCopyWithImpl($value, $cast, t);
}

class TwoColumnSlideConfigMapper extends ClassMapperBase<TwoColumnSlideConfig> {
  TwoColumnSlideConfigMapper._();

  static TwoColumnSlideConfigMapper? _instance;
  static TwoColumnSlideConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TwoColumnSlideConfigMapper._());
      SlideConfigMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TwoColumnSlideConfig';

  static String _$id(TwoColumnSlideConfig v) => v.id;
  static const Field<TwoColumnSlideConfig, String> _f$id = Field('id', _$id);
  static String? _$background(TwoColumnSlideConfig v) => v.background;
  static const Field<TwoColumnSlideConfig, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(TwoColumnSlideConfig v) =>
      v.contentAlignment;
  static const Field<TwoColumnSlideConfig, ContentAlignment>
      _f$contentAlignment = Field('contentAlignment', _$contentAlignment,
          opt: true, def: ContentAlignment.centerLeft);
  static String _$content(TwoColumnSlideConfig v) => v.content;
  static const Field<TwoColumnSlideConfig, String> _f$content =
      Field('content', _$content, opt: true, def: '');

  @override
  final MappableFields<TwoColumnSlideConfig> fields = const {
    #id: _f$id,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
  };

  static TwoColumnSlideConfig _instantiate(DecodingData data) {
    return TwoColumnSlideConfig(
        id: data.dec(_f$id),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static TwoColumnSlideConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TwoColumnSlideConfig>(map);
  }

  static TwoColumnSlideConfig fromJson(String json) {
    return ensureInitialized().decodeJson<TwoColumnSlideConfig>(json);
  }
}

mixin TwoColumnSlideConfigMappable {
  String toJson() {
    return TwoColumnSlideConfigMapper.ensureInitialized()
        .encodeJson<TwoColumnSlideConfig>(this as TwoColumnSlideConfig);
  }

  Map<String, dynamic> toMap() {
    return TwoColumnSlideConfigMapper.ensureInitialized()
        .encodeMap<TwoColumnSlideConfig>(this as TwoColumnSlideConfig);
  }

  TwoColumnSlideConfigCopyWith<TwoColumnSlideConfig, TwoColumnSlideConfig,
          TwoColumnSlideConfig>
      get copyWith => _TwoColumnSlideConfigCopyWithImpl(
          this as TwoColumnSlideConfig, $identity, $identity);
  @override
  String toString() {
    return TwoColumnSlideConfigMapper.ensureInitialized()
        .stringifyValue(this as TwoColumnSlideConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TwoColumnSlideConfigMapper.ensureInitialized()
                .isValueEqual(this as TwoColumnSlideConfig, other));
  }

  @override
  int get hashCode {
    return TwoColumnSlideConfigMapper.ensureInitialized()
        .hashValue(this as TwoColumnSlideConfig);
  }
}

extension TwoColumnSlideConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TwoColumnSlideConfig, $Out> {
  TwoColumnSlideConfigCopyWith<$R, TwoColumnSlideConfig, $Out>
      get $asTwoColumnSlideConfig =>
          $base.as((v, t, t2) => _TwoColumnSlideConfigCopyWithImpl(v, t, t2));
}

abstract class TwoColumnSlideConfigCopyWith<
    $R,
    $In extends TwoColumnSlideConfig,
    $Out> implements SlideConfigCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? background,
      ContentAlignment? contentAlignment,
      String? content});
  TwoColumnSlideConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TwoColumnSlideConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TwoColumnSlideConfig, $Out>
    implements TwoColumnSlideConfigCopyWith<$R, TwoColumnSlideConfig, $Out> {
  _TwoColumnSlideConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TwoColumnSlideConfig> $mapper =
      TwoColumnSlideConfigMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          Object? background = $none,
          ContentAlignment? contentAlignment,
          String? content}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (background != $none) #background: background,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (content != null) #content: content
      }));
  @override
  TwoColumnSlideConfig $make(CopyWithData data) => TwoColumnSlideConfig(
      id: data.get(#id, or: $value.id),
      background: data.get(#background, or: $value.background),
      contentAlignment:
          data.get(#contentAlignment, or: $value.contentAlignment),
      content: data.get(#content, or: $value.content));

  @override
  TwoColumnSlideConfigCopyWith<$R2, TwoColumnSlideConfig, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TwoColumnSlideConfigCopyWithImpl($value, $cast, t);
}

class TwoColumnHeaderSlideConfigMapper
    extends ClassMapperBase<TwoColumnHeaderSlideConfig> {
  TwoColumnHeaderSlideConfigMapper._();

  static TwoColumnHeaderSlideConfigMapper? _instance;
  static TwoColumnHeaderSlideConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = TwoColumnHeaderSlideConfigMapper._());
      SlideConfigMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TwoColumnHeaderSlideConfig';

  static String _$id(TwoColumnHeaderSlideConfig v) => v.id;
  static const Field<TwoColumnHeaderSlideConfig, String> _f$id =
      Field('id', _$id);
  static String? _$background(TwoColumnHeaderSlideConfig v) => v.background;
  static const Field<TwoColumnHeaderSlideConfig, String> _f$background =
      Field('background', _$background, opt: true);
  static ContentAlignment _$contentAlignment(TwoColumnHeaderSlideConfig v) =>
      v.contentAlignment;
  static const Field<TwoColumnHeaderSlideConfig, ContentAlignment>
      _f$contentAlignment = Field('contentAlignment', _$contentAlignment,
          opt: true, def: ContentAlignment.centerLeft);
  static String _$content(TwoColumnHeaderSlideConfig v) => v.content;
  static const Field<TwoColumnHeaderSlideConfig, String> _f$content =
      Field('content', _$content, opt: true, def: '');

  @override
  final MappableFields<TwoColumnHeaderSlideConfig> fields = const {
    #id: _f$id,
    #background: _f$background,
    #contentAlignment: _f$contentAlignment,
    #content: _f$content,
  };

  static TwoColumnHeaderSlideConfig _instantiate(DecodingData data) {
    return TwoColumnHeaderSlideConfig(
        id: data.dec(_f$id),
        background: data.dec(_f$background),
        contentAlignment: data.dec(_f$contentAlignment),
        content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static TwoColumnHeaderSlideConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TwoColumnHeaderSlideConfig>(map);
  }

  static TwoColumnHeaderSlideConfig fromJson(String json) {
    return ensureInitialized().decodeJson<TwoColumnHeaderSlideConfig>(json);
  }
}

mixin TwoColumnHeaderSlideConfigMappable {
  String toJson() {
    return TwoColumnHeaderSlideConfigMapper.ensureInitialized()
        .encodeJson<TwoColumnHeaderSlideConfig>(
            this as TwoColumnHeaderSlideConfig);
  }

  Map<String, dynamic> toMap() {
    return TwoColumnHeaderSlideConfigMapper.ensureInitialized()
        .encodeMap<TwoColumnHeaderSlideConfig>(
            this as TwoColumnHeaderSlideConfig);
  }

  TwoColumnHeaderSlideConfigCopyWith<TwoColumnHeaderSlideConfig,
          TwoColumnHeaderSlideConfig, TwoColumnHeaderSlideConfig>
      get copyWith => _TwoColumnHeaderSlideConfigCopyWithImpl(
          this as TwoColumnHeaderSlideConfig, $identity, $identity);
  @override
  String toString() {
    return TwoColumnHeaderSlideConfigMapper.ensureInitialized()
        .stringifyValue(this as TwoColumnHeaderSlideConfig);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TwoColumnHeaderSlideConfigMapper.ensureInitialized()
                .isValueEqual(this as TwoColumnHeaderSlideConfig, other));
  }

  @override
  int get hashCode {
    return TwoColumnHeaderSlideConfigMapper.ensureInitialized()
        .hashValue(this as TwoColumnHeaderSlideConfig);
  }
}

extension TwoColumnHeaderSlideConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TwoColumnHeaderSlideConfig, $Out> {
  TwoColumnHeaderSlideConfigCopyWith<$R, TwoColumnHeaderSlideConfig, $Out>
      get $asTwoColumnHeaderSlideConfig => $base
          .as((v, t, t2) => _TwoColumnHeaderSlideConfigCopyWithImpl(v, t, t2));
}

abstract class TwoColumnHeaderSlideConfigCopyWith<
    $R,
    $In extends TwoColumnHeaderSlideConfig,
    $Out> implements SlideConfigCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? background,
      ContentAlignment? contentAlignment,
      String? content});
  TwoColumnHeaderSlideConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TwoColumnHeaderSlideConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TwoColumnHeaderSlideConfig, $Out>
    implements
        TwoColumnHeaderSlideConfigCopyWith<$R, TwoColumnHeaderSlideConfig,
            $Out> {
  _TwoColumnHeaderSlideConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TwoColumnHeaderSlideConfig> $mapper =
      TwoColumnHeaderSlideConfigMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          Object? background = $none,
          ContentAlignment? contentAlignment,
          String? content}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (background != $none) #background: background,
        if (contentAlignment != null) #contentAlignment: contentAlignment,
        if (content != null) #content: content
      }));
  @override
  TwoColumnHeaderSlideConfig $make(
          CopyWithData data) =>
      TwoColumnHeaderSlideConfig(
          id: data.get(#id, or: $value.id),
          background: data.get(#background, or: $value.background),
          contentAlignment:
              data.get(#contentAlignment, or: $value.contentAlignment),
          content: data.get(#content, or: $value.content));

  @override
  TwoColumnHeaderSlideConfigCopyWith<$R2, TwoColumnHeaderSlideConfig, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _TwoColumnHeaderSlideConfigCopyWithImpl($value, $cast, t);
}
