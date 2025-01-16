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

class BlockElementMapper extends ClassMapperBase<BlockElement> {
  BlockElementMapper._();

  static BlockElementMapper? _instance;
  static BlockElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BlockElementMapper._());
      LayoutElementMapper.ensureInitialized();
      ContentElementMapper.ensureInitialized();
      DartPadElementMapper.ensureInitialized();
      AssetElementMapper.ensureInitialized();
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

  static BlockElement _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('BlockElement');
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

class ContentElementMapper extends ClassMapperBase<ContentElement> {
  ContentElementMapper._();

  static ContentElementMapper? _instance;
  static ContentElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentElementMapper._());
      BlockElementMapper.ensureInitialized();
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

class DartPadElementMapper extends ClassMapperBase<DartPadElement> {
  DartPadElementMapper._();

  static DartPadElementMapper? _instance;
  static DartPadElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DartPadElementMapper._());
      BlockElementMapper.ensureInitialized();
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

class AssetElementMapper extends ClassMapperBase<AssetElement> {
  AssetElementMapper._();

  static AssetElementMapper? _instance;
  static AssetElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetElementMapper._());
      BlockElementMapper.ensureInitialized();
      AssetMapper.ensureInitialized();
      ImageFitMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AssetElement';

  static Asset _$asset(AssetElement v) => v.asset;
  static const Field<AssetElement, Asset> _f$asset = Field('asset', _$asset);
  static ImageFit? _$fit(AssetElement v) => v.fit;
  static const Field<AssetElement, ImageFit> _f$fit =
      Field('fit', _$fit, opt: true);
  static double? _$width(AssetElement v) => v.width;
  static const Field<AssetElement, double> _f$width =
      Field('width', _$width, opt: true);
  static double? _$height(AssetElement v) => v.height;
  static const Field<AssetElement, double> _f$height =
      Field('height', _$height, opt: true);
  static int? _$flex(AssetElement v) => v.flex;
  static const Field<AssetElement, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(AssetElement v) => v.align;
  static const Field<AssetElement, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static bool _$scrollable(AssetElement v) => v.scrollable;
  static const Field<AssetElement, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static String _$type(AssetElement v) => v.type;
  static const Field<AssetElement, String> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<AssetElement> fields = const {
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

  static AssetElement _instantiate(DecodingData data) {
    return AssetElement(
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

  static AssetElement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssetElement>(map);
  }

  static AssetElement fromJson(String json) {
    return ensureInitialized().decodeJson<AssetElement>(json);
  }
}

mixin AssetElementMappable {
  String toJson() {
    return AssetElementMapper.ensureInitialized()
        .encodeJson<AssetElement>(this as AssetElement);
  }

  Map<String, dynamic> toMap() {
    return AssetElementMapper.ensureInitialized()
        .encodeMap<AssetElement>(this as AssetElement);
  }

  AssetElementCopyWith<AssetElement, AssetElement, AssetElement> get copyWith =>
      _AssetElementCopyWithImpl(this as AssetElement, $identity, $identity);
  @override
  String toString() {
    return AssetElementMapper.ensureInitialized()
        .stringifyValue(this as AssetElement);
  }

  @override
  bool operator ==(Object other) {
    return AssetElementMapper.ensureInitialized()
        .equalsValue(this as AssetElement, other);
  }

  @override
  int get hashCode {
    return AssetElementMapper.ensureInitialized()
        .hashValue(this as AssetElement);
  }
}

extension AssetElementValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssetElement, $Out> {
  AssetElementCopyWith<$R, AssetElement, $Out> get $asAssetElement =>
      $base.as((v, t, t2) => _AssetElementCopyWithImpl(v, t, t2));
}

abstract class AssetElementCopyWith<$R, $In extends AssetElement, $Out>
    implements BlockElementCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {Asset? asset,
      ImageFit? fit,
      double? width,
      double? height,
      int? flex,
      ContentAlignment? align,
      bool? scrollable});
  AssetElementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AssetElementCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssetElement, $Out>
    implements AssetElementCopyWith<$R, AssetElement, $Out> {
  _AssetElementCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssetElement> $mapper =
      AssetElementMapper.ensureInitialized();
  @override
  $R call(
          {Asset? asset,
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
  AssetElement $make(CopyWithData data) => AssetElement(
      asset: data.get(#asset, or: $value.asset),
      fit: data.get(#fit, or: $value.fit),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  AssetElementCopyWith<$R2, AssetElement, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AssetElementCopyWithImpl($value, $cast, t);
}

class WidgetElementMapper extends ClassMapperBase<WidgetElement> {
  WidgetElementMapper._();

  static WidgetElementMapper? _instance;
  static WidgetElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WidgetElementMapper._());
      BlockElementMapper.ensureInitialized();
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
