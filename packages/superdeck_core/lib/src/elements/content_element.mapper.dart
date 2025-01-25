// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'content_element.dart';

class DartPadThemeMapper extends EnumMapper<DartPadTheme> {
  DartPadThemeMapper._();

  static DartPadThemeMapper? _instance;
  static DartPadThemeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DartPadThemeMapper._());
    }
    return _instance!;
  }

  static DartPadTheme fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  DartPadTheme decode(dynamic value) {
    switch (value) {
      case 'dark':
        return DartPadTheme.dark;
      case 'light':
        return DartPadTheme.light;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(DartPadTheme self) {
    switch (self) {
      case DartPadTheme.dark:
        return 'dark';
      case DartPadTheme.light:
        return 'light';
    }
  }
}

extension DartPadThemeMapperExtension on DartPadTheme {
  String toValue() {
    DartPadThemeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<DartPadTheme>(this) as String;
  }
}

class ImageFitMapper extends EnumMapper<ImageFit> {
  ImageFitMapper._();

  static ImageFitMapper? _instance;
  static ImageFitMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageFitMapper._());
    }
    return _instance!;
  }

  static ImageFit fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ImageFit decode(dynamic value) {
    switch (value) {
      case 'fill':
        return ImageFit.fill;
      case 'contain':
        return ImageFit.contain;
      case 'cover':
        return ImageFit.cover;
      case 'fit_width':
        return ImageFit.fitWidth;
      case 'fit_height':
        return ImageFit.fitHeight;
      case 'none':
        return ImageFit.none;
      case 'scale_down':
        return ImageFit.scaleDown;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ImageFit self) {
    switch (self) {
      case ImageFit.fill:
        return 'fill';
      case ImageFit.contain:
        return 'contain';
      case ImageFit.cover:
        return 'cover';
      case ImageFit.fitWidth:
        return 'fit_width';
      case ImageFit.fitHeight:
        return 'fit_height';
      case ImageFit.none:
        return 'none';
      case ImageFit.scaleDown:
        return 'scale_down';
    }
  }
}

extension ImageFitMapperExtension on ImageFit {
  String toValue() {
    ImageFitMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ImageFit>(this) as String;
  }
}

class BlockElementMapper extends SubClassMapperBase<BlockElement> {
  BlockElementMapper._();

  static BlockElementMapper? _instance;
  static BlockElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BlockElementMapper._());
      LayoutElementMapper.ensureInitialized().addSubMapper(_instance!);
      ContentElementMapper.ensureInitialized();
      DartPadElementMapper.ensureInitialized();
      ImageElementMapper.ensureInitialized();
      WidgetElementMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BlockElement';

  static String _$type(BlockElement v) => v.type;
  static const Field<BlockElement, String> _f$type = Field('type', _$type);
  static int? _$flex(BlockElement v) => v.flex;
  static const Field<BlockElement, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(BlockElement v) => v.align;
  static const Field<BlockElement, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static bool _$scrollable(BlockElement v) => v.scrollable;
  static const Field<BlockElement, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);

  @override
  final MappableFields<BlockElement> fields = const {
    #type: _f$type,
    #flex: _f$flex,
    #align: _f$align,
    #scrollable: _f$scrollable,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'BlockElement';
  @override
  late final ClassMapperBase superMapper =
      LayoutElementMapper.ensureInitialized();

  static BlockElement _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'BlockElement', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static BlockElement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BlockElement>(map);
  }

  static BlockElement fromJson(String json) {
    return ensureInitialized().decodeJson<BlockElement>(json);
  }
}

mixin BlockElementMappable {
  String toJson();
  Map<String, dynamic> toMap();
  BlockElementCopyWith<BlockElement, BlockElement, BlockElement> get copyWith;
}

abstract class BlockElementCopyWith<$R, $In extends BlockElement, $Out>
    implements LayoutElementCopyWith<$R, $In, $Out> {
  @override
  $R call({int? flex, ContentAlignment? align, bool? scrollable});
  BlockElementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ContentElementMapper extends SubClassMapperBase<ContentElement> {
  ContentElementMapper._();

  static ContentElementMapper? _instance;
  static ContentElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentElementMapper._());
      BlockElementMapper.ensureInitialized().addSubMapper(_instance!);
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContentElement';

  static String _$content(ContentElement v) => v.content;
  static const Field<ContentElement, String> _f$content =
      Field('content', _$content);
  static int? _$flex(ContentElement v) => v.flex;
  static const Field<ContentElement, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(ContentElement v) => v.align;
  static const Field<ContentElement, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static bool _$scrollable(ContentElement v) => v.scrollable;
  static const Field<ContentElement, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static String _$type(ContentElement v) => v.type;
  static const Field<ContentElement, String> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<ContentElement> fields = const {
    #content: _f$content,
    #flex: _f$flex,
    #align: _f$align,
    #scrollable: _f$scrollable,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = ContentElement.key;
  @override
  late final ClassMapperBase superMapper =
      BlockElementMapper.ensureInitialized();

  static ContentElement _instantiate(DecodingData data) {
    return ContentElement(data.dec(_f$content),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align),
        scrollable: data.dec(_f$scrollable));
  }

  @override
  final Function instantiate = _instantiate;

  static ContentElement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContentElement>(map);
  }

  static ContentElement fromJson(String json) {
    return ensureInitialized().decodeJson<ContentElement>(json);
  }
}

mixin ContentElementMappable {
  String toJson() {
    return ContentElementMapper.ensureInitialized()
        .encodeJson<ContentElement>(this as ContentElement);
  }

  Map<String, dynamic> toMap() {
    return ContentElementMapper.ensureInitialized()
        .encodeMap<ContentElement>(this as ContentElement);
  }

  ContentElementCopyWith<ContentElement, ContentElement, ContentElement>
      get copyWith => _ContentElementCopyWithImpl(
          this as ContentElement, $identity, $identity);
  @override
  String toString() {
    return ContentElementMapper.ensureInitialized()
        .stringifyValue(this as ContentElement);
  }

  @override
  bool operator ==(Object other) {
    return ContentElementMapper.ensureInitialized()
        .equalsValue(this as ContentElement, other);
  }

  @override
  int get hashCode {
    return ContentElementMapper.ensureInitialized()
        .hashValue(this as ContentElement);
  }
}

extension ContentElementValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContentElement, $Out> {
  ContentElementCopyWith<$R, ContentElement, $Out> get $asContentElement =>
      $base.as((v, t, t2) => _ContentElementCopyWithImpl(v, t, t2));
}

abstract class ContentElementCopyWith<$R, $In extends ContentElement, $Out>
    implements BlockElementCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? content, int? flex, ContentAlignment? align, bool? scrollable});
  ContentElementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ContentElementCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContentElement, $Out>
    implements ContentElementCopyWith<$R, ContentElement, $Out> {
  _ContentElementCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContentElement> $mapper =
      ContentElementMapper.ensureInitialized();
  @override
  $R call(
          {String? content,
          Object? flex = $none,
          Object? align = $none,
          bool? scrollable}) =>
      $apply(FieldCopyWithData({
        if (content != null) #content: content,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align,
        if (scrollable != null) #scrollable: scrollable
      }));
  @override
  ContentElement $make(CopyWithData data) =>
      ContentElement(data.get(#content, or: $value.content),
          flex: data.get(#flex, or: $value.flex),
          align: data.get(#align, or: $value.align),
          scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  ContentElementCopyWith<$R2, ContentElement, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ContentElementCopyWithImpl($value, $cast, t);
}

class DartPadElementMapper extends SubClassMapperBase<DartPadElement> {
  DartPadElementMapper._();

  static DartPadElementMapper? _instance;
  static DartPadElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DartPadElementMapper._());
      BlockElementMapper.ensureInitialized().addSubMapper(_instance!);
      DartPadThemeMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DartPadElement';

  static String _$id(DartPadElement v) => v.id;
  static const Field<DartPadElement, String> _f$id = Field('id', _$id);
  static DartPadTheme? _$theme(DartPadElement v) => v.theme;
  static const Field<DartPadElement, DartPadTheme> _f$theme =
      Field('theme', _$theme, opt: true);
  static int? _$flex(DartPadElement v) => v.flex;
  static const Field<DartPadElement, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static String _$code(DartPadElement v) => v.code;
  static const Field<DartPadElement, String> _f$code = Field('code', _$code);
  static ContentAlignment? _$align(DartPadElement v) => v.align;
  static const Field<DartPadElement, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static bool _$embed(DartPadElement v) => v.embed;
  static const Field<DartPadElement, bool> _f$embed =
      Field('embed', _$embed, opt: true, def: true);
  static bool _$scrollable(DartPadElement v) => v.scrollable;
  static const Field<DartPadElement, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static String _$type(DartPadElement v) => v.type;
  static const Field<DartPadElement, String> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<DartPadElement> fields = const {
    #id: _f$id,
    #theme: _f$theme,
    #flex: _f$flex,
    #code: _f$code,
    #align: _f$align,
    #embed: _f$embed,
    #scrollable: _f$scrollable,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = DartPadElement.key;
  @override
  late final ClassMapperBase superMapper =
      BlockElementMapper.ensureInitialized();

  static DartPadElement _instantiate(DecodingData data) {
    return DartPadElement(
        id: data.dec(_f$id),
        theme: data.dec(_f$theme),
        flex: data.dec(_f$flex),
        code: data.dec(_f$code),
        align: data.dec(_f$align),
        embed: data.dec(_f$embed),
        scrollable: data.dec(_f$scrollable));
  }

  @override
  final Function instantiate = _instantiate;

  static DartPadElement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DartPadElement>(map);
  }

  static DartPadElement fromJson(String json) {
    return ensureInitialized().decodeJson<DartPadElement>(json);
  }
}

mixin DartPadElementMappable {
  String toJson() {
    return DartPadElementMapper.ensureInitialized()
        .encodeJson<DartPadElement>(this as DartPadElement);
  }

  Map<String, dynamic> toMap() {
    return DartPadElementMapper.ensureInitialized()
        .encodeMap<DartPadElement>(this as DartPadElement);
  }

  DartPadElementCopyWith<DartPadElement, DartPadElement, DartPadElement>
      get copyWith => _DartPadElementCopyWithImpl(
          this as DartPadElement, $identity, $identity);
  @override
  String toString() {
    return DartPadElementMapper.ensureInitialized()
        .stringifyValue(this as DartPadElement);
  }

  @override
  bool operator ==(Object other) {
    return DartPadElementMapper.ensureInitialized()
        .equalsValue(this as DartPadElement, other);
  }

  @override
  int get hashCode {
    return DartPadElementMapper.ensureInitialized()
        .hashValue(this as DartPadElement);
  }
}

extension DartPadElementValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DartPadElement, $Out> {
  DartPadElementCopyWith<$R, DartPadElement, $Out> get $asDartPadElement =>
      $base.as((v, t, t2) => _DartPadElementCopyWithImpl(v, t, t2));
}

abstract class DartPadElementCopyWith<$R, $In extends DartPadElement, $Out>
    implements BlockElementCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      DartPadTheme? theme,
      int? flex,
      String? code,
      ContentAlignment? align,
      bool? embed,
      bool? scrollable});
  DartPadElementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DartPadElementCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DartPadElement, $Out>
    implements DartPadElementCopyWith<$R, DartPadElement, $Out> {
  _DartPadElementCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DartPadElement> $mapper =
      DartPadElementMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          Object? theme = $none,
          Object? flex = $none,
          String? code,
          Object? align = $none,
          bool? embed,
          bool? scrollable}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (theme != $none) #theme: theme,
        if (flex != $none) #flex: flex,
        if (code != null) #code: code,
        if (align != $none) #align: align,
        if (embed != null) #embed: embed,
        if (scrollable != null) #scrollable: scrollable
      }));
  @override
  DartPadElement $make(CopyWithData data) => DartPadElement(
      id: data.get(#id, or: $value.id),
      theme: data.get(#theme, or: $value.theme),
      flex: data.get(#flex, or: $value.flex),
      code: data.get(#code, or: $value.code),
      align: data.get(#align, or: $value.align),
      embed: data.get(#embed, or: $value.embed),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  DartPadElementCopyWith<$R2, DartPadElement, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DartPadElementCopyWithImpl($value, $cast, t);
}

class ImageElementMapper extends SubClassMapperBase<ImageElement> {
  ImageElementMapper._();

  static ImageElementMapper? _instance;
  static ImageElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageElementMapper._());
      BlockElementMapper.ensureInitialized().addSubMapper(_instance!);
      GeneratedAssetMapper.ensureInitialized();
      ImageFitMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageElement';

  static GeneratedAsset _$asset(ImageElement v) => v.asset;
  static const Field<ImageElement, GeneratedAsset> _f$asset =
      Field('asset', _$asset);
  static ImageFit? _$fit(ImageElement v) => v.fit;
  static const Field<ImageElement, ImageFit> _f$fit =
      Field('fit', _$fit, opt: true);
  static double? _$width(ImageElement v) => v.width;
  static const Field<ImageElement, double> _f$width =
      Field('width', _$width, opt: true);
  static double? _$height(ImageElement v) => v.height;
  static const Field<ImageElement, double> _f$height =
      Field('height', _$height, opt: true);
  static int? _$flex(ImageElement v) => v.flex;
  static const Field<ImageElement, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(ImageElement v) => v.align;
  static const Field<ImageElement, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static bool _$scrollable(ImageElement v) => v.scrollable;
  static const Field<ImageElement, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static String _$type(ImageElement v) => v.type;
  static const Field<ImageElement, String> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<ImageElement> fields = const {
    #asset: _f$asset,
    #fit: _f$fit,
    #width: _f$width,
    #height: _f$height,
    #flex: _f$flex,
    #align: _f$align,
    #scrollable: _f$scrollable,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = ImageElement.key;
  @override
  late final ClassMapperBase superMapper =
      BlockElementMapper.ensureInitialized();

  static ImageElement _instantiate(DecodingData data) {
    return ImageElement(
        asset: data.dec(_f$asset),
        fit: data.dec(_f$fit),
        width: data.dec(_f$width),
        height: data.dec(_f$height),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align),
        scrollable: data.dec(_f$scrollable));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageElement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageElement>(map);
  }

  static ImageElement fromJson(String json) {
    return ensureInitialized().decodeJson<ImageElement>(json);
  }
}

mixin ImageElementMappable {
  String toJson() {
    return ImageElementMapper.ensureInitialized()
        .encodeJson<ImageElement>(this as ImageElement);
  }

  Map<String, dynamic> toMap() {
    return ImageElementMapper.ensureInitialized()
        .encodeMap<ImageElement>(this as ImageElement);
  }

  ImageElementCopyWith<ImageElement, ImageElement, ImageElement> get copyWith =>
      _ImageElementCopyWithImpl(this as ImageElement, $identity, $identity);
  @override
  String toString() {
    return ImageElementMapper.ensureInitialized()
        .stringifyValue(this as ImageElement);
  }

  @override
  bool operator ==(Object other) {
    return ImageElementMapper.ensureInitialized()
        .equalsValue(this as ImageElement, other);
  }

  @override
  int get hashCode {
    return ImageElementMapper.ensureInitialized()
        .hashValue(this as ImageElement);
  }
}

extension ImageElementValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageElement, $Out> {
  ImageElementCopyWith<$R, ImageElement, $Out> get $asImageElement =>
      $base.as((v, t, t2) => _ImageElementCopyWithImpl(v, t, t2));
}

abstract class ImageElementCopyWith<$R, $In extends ImageElement, $Out>
    implements BlockElementCopyWith<$R, $In, $Out> {
  GeneratedAssetCopyWith<$R, GeneratedAsset, GeneratedAsset> get asset;
  @override
  $R call(
      {GeneratedAsset? asset,
      ImageFit? fit,
      double? width,
      double? height,
      int? flex,
      ContentAlignment? align,
      bool? scrollable});
  ImageElementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageElementCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageElement, $Out>
    implements ImageElementCopyWith<$R, ImageElement, $Out> {
  _ImageElementCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageElement> $mapper =
      ImageElementMapper.ensureInitialized();
  @override
  GeneratedAssetCopyWith<$R, GeneratedAsset, GeneratedAsset> get asset =>
      $value.asset.copyWith.$chain((v) => call(asset: v));
  @override
  $R call(
          {GeneratedAsset? asset,
          Object? fit = $none,
          Object? width = $none,
          Object? height = $none,
          Object? flex = $none,
          Object? align = $none,
          bool? scrollable}) =>
      $apply(FieldCopyWithData({
        if (asset != null) #asset: asset,
        if (fit != $none) #fit: fit,
        if (width != $none) #width: width,
        if (height != $none) #height: height,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align,
        if (scrollable != null) #scrollable: scrollable
      }));
  @override
  ImageElement $make(CopyWithData data) => ImageElement(
      asset: data.get(#asset, or: $value.asset),
      fit: data.get(#fit, or: $value.fit),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  ImageElementCopyWith<$R2, ImageElement, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageElementCopyWithImpl($value, $cast, t);
}

class WidgetElementMapper extends SubClassMapperBase<WidgetElement> {
  WidgetElementMapper._();

  static WidgetElementMapper? _instance;
  static WidgetElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WidgetElementMapper._());
      BlockElementMapper.ensureInitialized().addSubMapper(_instance!);
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WidgetElement';

  static String _$name(WidgetElement v) => v.name;
  static const Field<WidgetElement, String> _f$name = Field('name', _$name);
  static Map<String, dynamic> _$args(WidgetElement v) => v.args;
  static const Field<WidgetElement, Map<String, dynamic>> _f$args =
      Field('args', _$args, opt: true, def: const {});
  static int? _$flex(WidgetElement v) => v.flex;
  static const Field<WidgetElement, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(WidgetElement v) => v.align;
  static const Field<WidgetElement, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static bool _$scrollable(WidgetElement v) => v.scrollable;
  static const Field<WidgetElement, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static String _$type(WidgetElement v) => v.type;
  static const Field<WidgetElement, String> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<WidgetElement> fields = const {
    #name: _f$name,
    #args: _f$args,
    #flex: _f$flex,
    #align: _f$align,
    #scrollable: _f$scrollable,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = WidgetElement.key;
  @override
  late final ClassMapperBase superMapper =
      BlockElementMapper.ensureInitialized();

  @override
  final MappingHook hook = const UnmappedPropertiesHook('args');
  static WidgetElement _instantiate(DecodingData data) {
    return WidgetElement(
        name: data.dec(_f$name),
        args: data.dec(_f$args),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align),
        scrollable: data.dec(_f$scrollable));
  }

  @override
  final Function instantiate = _instantiate;

  static WidgetElement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WidgetElement>(map);
  }

  static WidgetElement fromJson(String json) {
    return ensureInitialized().decodeJson<WidgetElement>(json);
  }
}

mixin WidgetElementMappable {
  String toJson() {
    return WidgetElementMapper.ensureInitialized()
        .encodeJson<WidgetElement>(this as WidgetElement);
  }

  Map<String, dynamic> toMap() {
    return WidgetElementMapper.ensureInitialized()
        .encodeMap<WidgetElement>(this as WidgetElement);
  }

  WidgetElementCopyWith<WidgetElement, WidgetElement, WidgetElement>
      get copyWith => _WidgetElementCopyWithImpl(
          this as WidgetElement, $identity, $identity);
  @override
  String toString() {
    return WidgetElementMapper.ensureInitialized()
        .stringifyValue(this as WidgetElement);
  }

  @override
  bool operator ==(Object other) {
    return WidgetElementMapper.ensureInitialized()
        .equalsValue(this as WidgetElement, other);
  }

  @override
  int get hashCode {
    return WidgetElementMapper.ensureInitialized()
        .hashValue(this as WidgetElement);
  }
}

extension WidgetElementValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WidgetElement, $Out> {
  WidgetElementCopyWith<$R, WidgetElement, $Out> get $asWidgetElement =>
      $base.as((v, t, t2) => _WidgetElementCopyWithImpl(v, t, t2));
}

abstract class WidgetElementCopyWith<$R, $In extends WidgetElement, $Out>
    implements BlockElementCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get args;
  @override
  $R call(
      {String? name,
      Map<String, dynamic>? args,
      int? flex,
      ContentAlignment? align,
      bool? scrollable});
  WidgetElementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WidgetElementCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WidgetElement, $Out>
    implements WidgetElementCopyWith<$R, WidgetElement, $Out> {
  _WidgetElementCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WidgetElement> $mapper =
      WidgetElementMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get args => MapCopyWith($value.args,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(args: v));
  @override
  $R call(
          {String? name,
          Map<String, dynamic>? args,
          Object? flex = $none,
          Object? align = $none,
          bool? scrollable}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (args != null) #args: args,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align,
        if (scrollable != null) #scrollable: scrollable
      }));
  @override
  WidgetElement $make(CopyWithData data) => WidgetElement(
      name: data.get(#name, or: $value.name),
      args: data.get(#args, or: $value.args),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  WidgetElementCopyWith<$R2, WidgetElement, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WidgetElementCopyWithImpl($value, $cast, t);
}
