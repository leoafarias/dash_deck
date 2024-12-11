// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'block_model.dart';

class BlockTypeMapper extends EnumMapper<BlockType> {
  BlockTypeMapper._();

  static BlockTypeMapper? _instance;
  static BlockTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BlockTypeMapper._());
    }
    return _instance!;
  }

  static BlockType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  BlockType decode(dynamic value) {
    switch (value) {
      case 'section':
        return BlockType.section;
      case 'column':
        return BlockType.column;
      case 'image':
        return BlockType.image;
      case 'widget':
        return BlockType.widget;
      case 'dartpad':
        return BlockType.dartpad;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BlockType self) {
    switch (self) {
      case BlockType.section:
        return 'section';
      case BlockType.column:
        return 'column';
      case BlockType.image:
        return 'image';
      case BlockType.widget:
        return 'widget';
      case BlockType.dartpad:
        return 'dartpad';
    }
  }
}

extension BlockTypeMapperExtension on BlockType {
  String toValue() {
    BlockTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<BlockType>(this) as String;
  }
}

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

class ContentAlignmentMapper extends EnumMapper<ContentAlignment> {
  ContentAlignmentMapper._();

  static ContentAlignmentMapper? _instance;
  static ContentAlignmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentAlignmentMapper._());
    }
    return _instance!;
  }

  static ContentAlignment fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ContentAlignment decode(dynamic value) {
    switch (value) {
      case 'top_left':
        return ContentAlignment.topLeft;
      case 'top_center':
        return ContentAlignment.topCenter;
      case 'top_right':
        return ContentAlignment.topRight;
      case 'center_left':
        return ContentAlignment.centerLeft;
      case 'center':
        return ContentAlignment.center;
      case 'center_right':
        return ContentAlignment.centerRight;
      case 'bottom_left':
        return ContentAlignment.bottomLeft;
      case 'bottom_center':
        return ContentAlignment.bottomCenter;
      case 'bottom_right':
        return ContentAlignment.bottomRight;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ContentAlignment self) {
    switch (self) {
      case ContentAlignment.topLeft:
        return 'top_left';
      case ContentAlignment.topCenter:
        return 'top_center';
      case ContentAlignment.topRight:
        return 'top_right';
      case ContentAlignment.centerLeft:
        return 'center_left';
      case ContentAlignment.center:
        return 'center';
      case ContentAlignment.centerRight:
        return 'center_right';
      case ContentAlignment.bottomLeft:
        return 'bottom_left';
      case ContentAlignment.bottomCenter:
        return 'bottom_center';
      case ContentAlignment.bottomRight:
        return 'bottom_right';
    }
  }
}

extension ContentAlignmentMapperExtension on ContentAlignment {
  String toValue() {
    ContentAlignmentMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ContentAlignment>(this) as String;
  }
}

class BlockMapper extends ClassMapperBase<Block> {
  BlockMapper._();

  static BlockMapper? _instance;
  static BlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BlockMapper._());
      SectionBlockMapper.ensureInitialized();
      ColumnBlockMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
      BlockTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Block';

  static int? _$flex(Block v) => v.flex;
  static const Field<Block, int> _f$flex = Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(Block v) => v.align;
  static const Field<Block, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static BlockType _$type(Block v) => v.type;
  static const Field<Block, BlockType> _f$type = Field('type', _$type);
  static String _$key(Block v) => v.key;
  static const Field<Block, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);

  @override
  final MappableFields<Block> fields = const {
    #flex: _f$flex,
    #align: _f$align,
    #type: _f$type,
    #key: _f$key,
  };
  @override
  final bool ignoreNull = true;

  static Block _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'Block', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static Block fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Block>(map);
  }

  static Block fromJson(String json) {
    return ensureInitialized().decodeJson<Block>(json);
  }
}

mixin BlockMappable {
  String toJson();
  Map<String, dynamic> toMap();
  BlockCopyWith<Block, Block, Block> get copyWith;
}

abstract class BlockCopyWith<$R, $In extends Block, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? flex, ContentAlignment? align});
  BlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SectionBlockMapper extends SubClassMapperBase<SectionBlock> {
  SectionBlockMapper._();

  static SectionBlockMapper? _instance;
  static SectionBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SectionBlockMapper._());
      BlockMapper.ensureInitialized().addSubMapper(_instance!);
      MapperContainer.globals.useAll([NullIfEmptyBlock()]);
      ColumnBlockMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SectionBlock';

  static List<ColumnBlock> _$blocks(SectionBlock v) => v.blocks;
  static const Field<SectionBlock, List<ColumnBlock>> _f$blocks =
      Field('blocks', _$blocks, opt: true, def: const []);
  static int? _$flex(SectionBlock v) => v.flex;
  static const Field<SectionBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(SectionBlock v) => v.align;
  static const Field<SectionBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static BlockType _$type(SectionBlock v) => v.type;
  static const Field<SectionBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);
  static String _$key(SectionBlock v) => v.key;
  static const Field<SectionBlock, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);

  @override
  final MappableFields<SectionBlock> fields = const {
    #blocks: _f$blocks,
    #flex: _f$flex,
    #align: _f$align,
    #type: _f$type,
    #key: _f$key,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'section';
  @override
  late final ClassMapperBase superMapper = BlockMapper.ensureInitialized();

  static SectionBlock _instantiate(DecodingData data) {
    return SectionBlock(
        blocks: data.dec(_f$blocks),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align));
  }

  @override
  final Function instantiate = _instantiate;

  static SectionBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SectionBlock>(map);
  }

  static SectionBlock fromJson(String json) {
    return ensureInitialized().decodeJson<SectionBlock>(json);
  }
}

mixin SectionBlockMappable {
  String toJson() {
    return SectionBlockMapper.ensureInitialized()
        .encodeJson<SectionBlock>(this as SectionBlock);
  }

  Map<String, dynamic> toMap() {
    return SectionBlockMapper.ensureInitialized()
        .encodeMap<SectionBlock>(this as SectionBlock);
  }

  SectionBlockCopyWith<SectionBlock, SectionBlock, SectionBlock> get copyWith =>
      _SectionBlockCopyWithImpl(this as SectionBlock, $identity, $identity);
  @override
  String toString() {
    return SectionBlockMapper.ensureInitialized()
        .stringifyValue(this as SectionBlock);
  }

  @override
  bool operator ==(Object other) {
    return SectionBlockMapper.ensureInitialized()
        .equalsValue(this as SectionBlock, other);
  }

  @override
  int get hashCode {
    return SectionBlockMapper.ensureInitialized()
        .hashValue(this as SectionBlock);
  }
}

extension SectionBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SectionBlock, $Out> {
  SectionBlockCopyWith<$R, SectionBlock, $Out> get $asSectionBlock =>
      $base.as((v, t, t2) => _SectionBlockCopyWithImpl(v, t, t2));
}

abstract class SectionBlockCopyWith<$R, $In extends SectionBlock, $Out>
    implements BlockCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, ColumnBlock,
      ColumnBlockCopyWith<$R, ColumnBlock, ColumnBlock>> get blocks;
  @override
  $R call({List<ColumnBlock>? blocks, int? flex, ContentAlignment? align});
  SectionBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SectionBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SectionBlock, $Out>
    implements SectionBlockCopyWith<$R, SectionBlock, $Out> {
  _SectionBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SectionBlock> $mapper =
      SectionBlockMapper.ensureInitialized();
  @override
  ListCopyWith<$R, ColumnBlock,
          ColumnBlockCopyWith<$R, ColumnBlock, ColumnBlock>>
      get blocks => ListCopyWith($value.blocks, (v, t) => v.copyWith.$chain(t),
          (v) => call(blocks: v));
  @override
  $R call(
          {List<ColumnBlock>? blocks,
          Object? flex = $none,
          Object? align = $none}) =>
      $apply(FieldCopyWithData({
        if (blocks != null) #blocks: blocks,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align
      }));
  @override
  SectionBlock $make(CopyWithData data) => SectionBlock(
      blocks: data.get(#blocks, or: $value.blocks),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align));

  @override
  SectionBlockCopyWith<$R2, SectionBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SectionBlockCopyWithImpl($value, $cast, t);
}

class ColumnBlockMapper extends SubClassMapperBase<ColumnBlock> {
  ColumnBlockMapper._();

  static ColumnBlockMapper? _instance;
  static ColumnBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ColumnBlockMapper._());
      BlockMapper.ensureInitialized().addSubMapper(_instance!);
      ImageBlockMapper.ensureInitialized();
      WidgetBlockMapper.ensureInitialized();
      DartPadBlockMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
      BlockTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ColumnBlock';

  static String? _$_content(ColumnBlock v) => v._content;
  static const Field<ColumnBlock, String> _f$_content =
      Field('_content', _$_content, key: 'content', opt: true);
  static int? _$flex(ColumnBlock v) => v.flex;
  static const Field<ColumnBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(ColumnBlock v) => v.align;
  static const Field<ColumnBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static BlockType _$type(ColumnBlock v) => v.type;
  static const Field<ColumnBlock, BlockType> _f$type =
      Field('type', _$type, opt: true, def: BlockType.column);
  static bool _$scrollable(ColumnBlock v) => v.scrollable;
  static const Field<ColumnBlock, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static String _$key(ColumnBlock v) => v.key;
  static const Field<ColumnBlock, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);

  @override
  final MappableFields<ColumnBlock> fields = const {
    #_content: _f$_content,
    #flex: _f$flex,
    #align: _f$align,
    #type: _f$type,
    #scrollable: _f$scrollable,
    #key: _f$key,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'column';
  @override
  late final ClassMapperBase superMapper = BlockMapper.ensureInitialized();

  static ColumnBlock _instantiate(DecodingData data) {
    return ColumnBlock(
        content: data.dec(_f$_content),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align),
        type: data.dec(_f$type),
        scrollable: data.dec(_f$scrollable));
  }

  @override
  final Function instantiate = _instantiate;

  static ColumnBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ColumnBlock>(map);
  }

  static ColumnBlock fromJson(String json) {
    return ensureInitialized().decodeJson<ColumnBlock>(json);
  }
}

mixin ColumnBlockMappable {
  String toJson() {
    return ColumnBlockMapper.ensureInitialized()
        .encodeJson<ColumnBlock>(this as ColumnBlock);
  }

  Map<String, dynamic> toMap() {
    return ColumnBlockMapper.ensureInitialized()
        .encodeMap<ColumnBlock>(this as ColumnBlock);
  }

  ColumnBlockCopyWith<ColumnBlock, ColumnBlock, ColumnBlock> get copyWith =>
      _ColumnBlockCopyWithImpl(this as ColumnBlock, $identity, $identity);
  @override
  String toString() {
    return ColumnBlockMapper.ensureInitialized()
        .stringifyValue(this as ColumnBlock);
  }

  @override
  bool operator ==(Object other) {
    return ColumnBlockMapper.ensureInitialized()
        .equalsValue(this as ColumnBlock, other);
  }

  @override
  int get hashCode {
    return ColumnBlockMapper.ensureInitialized().hashValue(this as ColumnBlock);
  }
}

extension ColumnBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ColumnBlock, $Out> {
  ColumnBlockCopyWith<$R, ColumnBlock, $Out> get $asColumnBlock =>
      $base.as((v, t, t2) => _ColumnBlockCopyWithImpl(v, t, t2));
}

abstract class ColumnBlockCopyWith<$R, $In extends ColumnBlock, $Out>
    implements BlockCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? content, int? flex, ContentAlignment? align, bool? scrollable});
  ColumnBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ColumnBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ColumnBlock, $Out>
    implements ColumnBlockCopyWith<$R, ColumnBlock, $Out> {
  _ColumnBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ColumnBlock> $mapper =
      ColumnBlockMapper.ensureInitialized();
  @override
  $R call(
          {Object? content = $none,
          Object? flex = $none,
          Object? align = $none,
          bool? scrollable}) =>
      $apply(FieldCopyWithData({
        if (content != $none) #content: content,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align,
        if (scrollable != null) #scrollable: scrollable
      }));
  @override
  ColumnBlock $make(CopyWithData data) => ColumnBlock(
      content: data.get(#content, or: $value._content),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      type: data.get(#type, or: $value.type),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  ColumnBlockCopyWith<$R2, ColumnBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ColumnBlockCopyWithImpl($value, $cast, t);
}

class ImageBlockMapper extends SubClassMapperBase<ImageBlock> {
  ImageBlockMapper._();

  static ImageBlockMapper? _instance;
  static ImageBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageBlockMapper._());
      ColumnBlockMapper.ensureInitialized().addSubMapper(_instance!);
      ImageFitMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ImageBlock';

  static String _$src(ImageBlock v) => v.src;
  static const Field<ImageBlock, String> _f$src = Field('src', _$src);
  static ImageFit? _$fit(ImageBlock v) => v.fit;
  static const Field<ImageBlock, ImageFit> _f$fit =
      Field('fit', _$fit, opt: true);
  static double? _$width(ImageBlock v) => v.width;
  static const Field<ImageBlock, double> _f$width =
      Field('width', _$width, opt: true);
  static double? _$height(ImageBlock v) => v.height;
  static const Field<ImageBlock, double> _f$height =
      Field('height', _$height, opt: true);
  static int? _$flex(ImageBlock v) => v.flex;
  static const Field<ImageBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(ImageBlock v) => v.align;
  static const Field<ImageBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static String? _$_content(ImageBlock v) => v._content;
  static const Field<ImageBlock, String> _f$_content =
      Field('_content', _$_content, key: 'content', opt: true);
  static bool _$scrollable(ImageBlock v) => v.scrollable;
  static const Field<ImageBlock, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static BlockType _$type(ImageBlock v) => v.type;
  static const Field<ImageBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);
  static String _$key(ImageBlock v) => v.key;
  static const Field<ImageBlock, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);

  @override
  final MappableFields<ImageBlock> fields = const {
    #src: _f$src,
    #fit: _f$fit,
    #width: _f$width,
    #height: _f$height,
    #flex: _f$flex,
    #align: _f$align,
    #_content: _f$_content,
    #scrollable: _f$scrollable,
    #type: _f$type,
    #key: _f$key,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'image';
  @override
  late final ClassMapperBase superMapper =
      ColumnBlockMapper.ensureInitialized();

  static ImageBlock _instantiate(DecodingData data) {
    return ImageBlock(
        src: data.dec(_f$src),
        fit: data.dec(_f$fit),
        width: data.dec(_f$width),
        height: data.dec(_f$height),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align),
        content: data.dec(_f$_content),
        scrollable: data.dec(_f$scrollable));
  }

  @override
  final Function instantiate = _instantiate;

  static ImageBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ImageBlock>(map);
  }

  static ImageBlock fromJson(String json) {
    return ensureInitialized().decodeJson<ImageBlock>(json);
  }
}

mixin ImageBlockMappable {
  String toJson() {
    return ImageBlockMapper.ensureInitialized()
        .encodeJson<ImageBlock>(this as ImageBlock);
  }

  Map<String, dynamic> toMap() {
    return ImageBlockMapper.ensureInitialized()
        .encodeMap<ImageBlock>(this as ImageBlock);
  }

  ImageBlockCopyWith<ImageBlock, ImageBlock, ImageBlock> get copyWith =>
      _ImageBlockCopyWithImpl(this as ImageBlock, $identity, $identity);
  @override
  String toString() {
    return ImageBlockMapper.ensureInitialized()
        .stringifyValue(this as ImageBlock);
  }

  @override
  bool operator ==(Object other) {
    return ImageBlockMapper.ensureInitialized()
        .equalsValue(this as ImageBlock, other);
  }

  @override
  int get hashCode {
    return ImageBlockMapper.ensureInitialized().hashValue(this as ImageBlock);
  }
}

extension ImageBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ImageBlock, $Out> {
  ImageBlockCopyWith<$R, ImageBlock, $Out> get $asImageBlock =>
      $base.as((v, t, t2) => _ImageBlockCopyWithImpl(v, t, t2));
}

abstract class ImageBlockCopyWith<$R, $In extends ImageBlock, $Out>
    implements ColumnBlockCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? src,
      ImageFit? fit,
      double? width,
      double? height,
      int? flex,
      ContentAlignment? align,
      String? content,
      bool? scrollable});
  ImageBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImageBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ImageBlock, $Out>
    implements ImageBlockCopyWith<$R, ImageBlock, $Out> {
  _ImageBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ImageBlock> $mapper =
      ImageBlockMapper.ensureInitialized();
  @override
  $R call(
          {String? src,
          Object? fit = $none,
          Object? width = $none,
          Object? height = $none,
          Object? flex = $none,
          Object? align = $none,
          Object? content = $none,
          bool? scrollable}) =>
      $apply(FieldCopyWithData({
        if (src != null) #src: src,
        if (fit != $none) #fit: fit,
        if (width != $none) #width: width,
        if (height != $none) #height: height,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align,
        if (content != $none) #content: content,
        if (scrollable != null) #scrollable: scrollable
      }));
  @override
  ImageBlock $make(CopyWithData data) => ImageBlock(
      src: data.get(#src, or: $value.src),
      fit: data.get(#fit, or: $value.fit),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      content: data.get(#content, or: $value._content),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  ImageBlockCopyWith<$R2, ImageBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ImageBlockCopyWithImpl($value, $cast, t);
}

class WidgetBlockMapper extends SubClassMapperBase<WidgetBlock> {
  WidgetBlockMapper._();

  static WidgetBlockMapper? _instance;
  static WidgetBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WidgetBlockMapper._());
      ColumnBlockMapper.ensureInitialized().addSubMapper(_instance!);
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'WidgetBlock';

  static String _$name(WidgetBlock v) => v.name;
  static const Field<WidgetBlock, String> _f$name = Field('name', _$name);
  static Map<String, dynamic> _$args(WidgetBlock v) => v.args;
  static const Field<WidgetBlock, Map<String, dynamic>> _f$args =
      Field('args', _$args, opt: true, def: const {});
  static int? _$flex(WidgetBlock v) => v.flex;
  static const Field<WidgetBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(WidgetBlock v) => v.align;
  static const Field<WidgetBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static String? _$_content(WidgetBlock v) => v._content;
  static const Field<WidgetBlock, String> _f$_content =
      Field('_content', _$_content, key: 'content', opt: true);
  static bool _$scrollable(WidgetBlock v) => v.scrollable;
  static const Field<WidgetBlock, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static BlockType _$type(WidgetBlock v) => v.type;
  static const Field<WidgetBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);
  static String _$key(WidgetBlock v) => v.key;
  static const Field<WidgetBlock, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);

  @override
  final MappableFields<WidgetBlock> fields = const {
    #name: _f$name,
    #args: _f$args,
    #flex: _f$flex,
    #align: _f$align,
    #_content: _f$_content,
    #scrollable: _f$scrollable,
    #type: _f$type,
    #key: _f$key,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'widget';
  @override
  late final ClassMapperBase superMapper =
      ColumnBlockMapper.ensureInitialized();

  @override
  final MappingHook hook = const UnmappedPropertiesHook('args');
  static WidgetBlock _instantiate(DecodingData data) {
    return WidgetBlock(
        name: data.dec(_f$name),
        args: data.dec(_f$args),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align),
        content: data.dec(_f$_content),
        scrollable: data.dec(_f$scrollable));
  }

  @override
  final Function instantiate = _instantiate;

  static WidgetBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WidgetBlock>(map);
  }

  static WidgetBlock fromJson(String json) {
    return ensureInitialized().decodeJson<WidgetBlock>(json);
  }
}

mixin WidgetBlockMappable {
  String toJson() {
    return WidgetBlockMapper.ensureInitialized()
        .encodeJson<WidgetBlock>(this as WidgetBlock);
  }

  Map<String, dynamic> toMap() {
    return WidgetBlockMapper.ensureInitialized()
        .encodeMap<WidgetBlock>(this as WidgetBlock);
  }

  WidgetBlockCopyWith<WidgetBlock, WidgetBlock, WidgetBlock> get copyWith =>
      _WidgetBlockCopyWithImpl(this as WidgetBlock, $identity, $identity);
  @override
  String toString() {
    return WidgetBlockMapper.ensureInitialized()
        .stringifyValue(this as WidgetBlock);
  }

  @override
  bool operator ==(Object other) {
    return WidgetBlockMapper.ensureInitialized()
        .equalsValue(this as WidgetBlock, other);
  }

  @override
  int get hashCode {
    return WidgetBlockMapper.ensureInitialized().hashValue(this as WidgetBlock);
  }
}

extension WidgetBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WidgetBlock, $Out> {
  WidgetBlockCopyWith<$R, WidgetBlock, $Out> get $asWidgetBlock =>
      $base.as((v, t, t2) => _WidgetBlockCopyWithImpl(v, t, t2));
}

abstract class WidgetBlockCopyWith<$R, $In extends WidgetBlock, $Out>
    implements ColumnBlockCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get args;
  @override
  $R call(
      {String? name,
      Map<String, dynamic>? args,
      int? flex,
      ContentAlignment? align,
      String? content,
      bool? scrollable});
  WidgetBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _WidgetBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WidgetBlock, $Out>
    implements WidgetBlockCopyWith<$R, WidgetBlock, $Out> {
  _WidgetBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WidgetBlock> $mapper =
      WidgetBlockMapper.ensureInitialized();
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
          Object? content = $none,
          bool? scrollable}) =>
      $apply(FieldCopyWithData({
        if (name != null) #name: name,
        if (args != null) #args: args,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align,
        if (content != $none) #content: content,
        if (scrollable != null) #scrollable: scrollable
      }));
  @override
  WidgetBlock $make(CopyWithData data) => WidgetBlock(
      name: data.get(#name, or: $value.name),
      args: data.get(#args, or: $value.args),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      content: data.get(#content, or: $value._content),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  WidgetBlockCopyWith<$R2, WidgetBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _WidgetBlockCopyWithImpl($value, $cast, t);
}

class DartPadBlockMapper extends SubClassMapperBase<DartPadBlock> {
  DartPadBlockMapper._();

  static DartPadBlockMapper? _instance;
  static DartPadBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DartPadBlockMapper._());
      ColumnBlockMapper.ensureInitialized().addSubMapper(_instance!);
      DartPadThemeMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DartPadBlock';

  static String _$id(DartPadBlock v) => v.id;
  static const Field<DartPadBlock, String> _f$id = Field('id', _$id);
  static DartPadTheme? _$theme(DartPadBlock v) => v.theme;
  static const Field<DartPadBlock, DartPadTheme> _f$theme =
      Field('theme', _$theme, opt: true);
  static int? _$flex(DartPadBlock v) => v.flex;
  static const Field<DartPadBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static String? _$_content(DartPadBlock v) => v._content;
  static const Field<DartPadBlock, String> _f$_content =
      Field('_content', _$_content, key: 'content', opt: true);
  static ContentAlignment? _$align(DartPadBlock v) => v.align;
  static const Field<DartPadBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static bool _$embed(DartPadBlock v) => v.embed;
  static const Field<DartPadBlock, bool> _f$embed =
      Field('embed', _$embed, opt: true, def: true);
  static bool _$scrollable(DartPadBlock v) => v.scrollable;
  static const Field<DartPadBlock, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static BlockType _$type(DartPadBlock v) => v.type;
  static const Field<DartPadBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);
  static String _$key(DartPadBlock v) => v.key;
  static const Field<DartPadBlock, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);

  @override
  final MappableFields<DartPadBlock> fields = const {
    #id: _f$id,
    #theme: _f$theme,
    #flex: _f$flex,
    #_content: _f$_content,
    #align: _f$align,
    #embed: _f$embed,
    #scrollable: _f$scrollable,
    #type: _f$type,
    #key: _f$key,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'DartPadBlock';
  @override
  late final ClassMapperBase superMapper =
      ColumnBlockMapper.ensureInitialized();

  static DartPadBlock _instantiate(DecodingData data) {
    return DartPadBlock(
        id: data.dec(_f$id),
        theme: data.dec(_f$theme),
        flex: data.dec(_f$flex),
        content: data.dec(_f$_content),
        align: data.dec(_f$align),
        embed: data.dec(_f$embed),
        scrollable: data.dec(_f$scrollable));
  }

  @override
  final Function instantiate = _instantiate;

  static DartPadBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DartPadBlock>(map);
  }

  static DartPadBlock fromJson(String json) {
    return ensureInitialized().decodeJson<DartPadBlock>(json);
  }
}

mixin DartPadBlockMappable {
  String toJson() {
    return DartPadBlockMapper.ensureInitialized()
        .encodeJson<DartPadBlock>(this as DartPadBlock);
  }

  Map<String, dynamic> toMap() {
    return DartPadBlockMapper.ensureInitialized()
        .encodeMap<DartPadBlock>(this as DartPadBlock);
  }

  DartPadBlockCopyWith<DartPadBlock, DartPadBlock, DartPadBlock> get copyWith =>
      _DartPadBlockCopyWithImpl(this as DartPadBlock, $identity, $identity);
  @override
  String toString() {
    return DartPadBlockMapper.ensureInitialized()
        .stringifyValue(this as DartPadBlock);
  }

  @override
  bool operator ==(Object other) {
    return DartPadBlockMapper.ensureInitialized()
        .equalsValue(this as DartPadBlock, other);
  }

  @override
  int get hashCode {
    return DartPadBlockMapper.ensureInitialized()
        .hashValue(this as DartPadBlock);
  }
}

extension DartPadBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DartPadBlock, $Out> {
  DartPadBlockCopyWith<$R, DartPadBlock, $Out> get $asDartPadBlock =>
      $base.as((v, t, t2) => _DartPadBlockCopyWithImpl(v, t, t2));
}

abstract class DartPadBlockCopyWith<$R, $In extends DartPadBlock, $Out>
    implements ColumnBlockCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      DartPadTheme? theme,
      int? flex,
      String? content,
      ContentAlignment? align,
      bool? embed,
      bool? scrollable});
  DartPadBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DartPadBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DartPadBlock, $Out>
    implements DartPadBlockCopyWith<$R, DartPadBlock, $Out> {
  _DartPadBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DartPadBlock> $mapper =
      DartPadBlockMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          Object? theme = $none,
          Object? flex = $none,
          Object? content = $none,
          Object? align = $none,
          bool? embed,
          bool? scrollable}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (theme != $none) #theme: theme,
        if (flex != $none) #flex: flex,
        if (content != $none) #content: content,
        if (align != $none) #align: align,
        if (embed != null) #embed: embed,
        if (scrollable != null) #scrollable: scrollable
      }));
  @override
  DartPadBlock $make(CopyWithData data) => DartPadBlock(
      id: data.get(#id, or: $value.id),
      theme: data.get(#theme, or: $value.theme),
      flex: data.get(#flex, or: $value.flex),
      content: data.get(#content, or: $value._content),
      align: data.get(#align, or: $value.align),
      embed: data.get(#embed, or: $value.embed),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  DartPadBlockCopyWith<$R2, DartPadBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DartPadBlockCopyWithImpl($value, $cast, t);
}
