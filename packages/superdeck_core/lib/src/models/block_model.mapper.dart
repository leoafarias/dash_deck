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
      case 'content':
        return BlockType.content;
      case 'local_image':
        return BlockType.local_image;
      case 'remote_image':
        return BlockType.remote_image;
      case 'widget':
        return BlockType.widget;
      case 'dart_code':
        return BlockType.dartCode;
      case 'mermaid':
        return BlockType.mermaid;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(BlockType self) {
    switch (self) {
      case BlockType.section:
        return 'section';
      case BlockType.content:
        return 'content';
      case BlockType.local_image:
        return 'local_image';
      case BlockType.remote_image:
        return 'remote_image';
      case BlockType.widget:
        return 'widget';
      case BlockType.dartCode:
        return 'dart_code';
      case BlockType.mermaid:
        return 'mermaid';
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
      ContentBlockMapper.ensureInitialized();
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
      ContentBlockMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SectionBlock';

  static List<ContentBlock> _$blocks(SectionBlock v) => v.blocks;
  static const Field<SectionBlock, List<ContentBlock>> _f$blocks =
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
  ListCopyWith<$R, ContentBlock,
      ContentBlockCopyWith<$R, ContentBlock, ContentBlock>> get blocks;
  @override
  $R call({List<ContentBlock>? blocks, int? flex, ContentAlignment? align});
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
  ListCopyWith<$R, ContentBlock,
          ContentBlockCopyWith<$R, ContentBlock, ContentBlock>>
      get blocks => ListCopyWith($value.blocks, (v, t) => v.copyWith.$chain(t),
          (v) => call(blocks: v));
  @override
  $R call(
          {List<ContentBlock>? blocks,
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

class ContentBlockMapper extends SubClassMapperBase<ContentBlock> {
  ContentBlockMapper._();

  static ContentBlockMapper? _instance;
  static ContentBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContentBlockMapper._());
      BlockMapper.ensureInitialized().addSubMapper(_instance!);
      ImageBlockMapper.ensureInitialized();
      WidgetBlockMapper.ensureInitialized();
      DartCodeBlockMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
      BlockTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ContentBlock';

  static String? _$_content(ContentBlock v) => v._content;
  static const Field<ContentBlock, String> _f$_content =
      Field('_content', _$_content, key: 'content', opt: true);
  static int? _$flex(ContentBlock v) => v.flex;
  static const Field<ContentBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(ContentBlock v) => v.align;
  static const Field<ContentBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static BlockType _$type(ContentBlock v) => v.type;
  static const Field<ContentBlock, BlockType> _f$type =
      Field('type', _$type, opt: true, def: BlockType.content);
  static bool _$scrollable(ContentBlock v) => v.scrollable;
  static const Field<ContentBlock, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static String _$key(ContentBlock v) => v.key;
  static const Field<ContentBlock, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);

  @override
  final MappableFields<ContentBlock> fields = const {
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
  final dynamic discriminatorValue = 'content';
  @override
  late final ClassMapperBase superMapper = BlockMapper.ensureInitialized();

  static ContentBlock _instantiate(DecodingData data) {
    return ContentBlock(
        content: data.dec(_f$_content),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align),
        type: data.dec(_f$type),
        scrollable: data.dec(_f$scrollable));
  }

  @override
  final Function instantiate = _instantiate;

  static ContentBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContentBlock>(map);
  }

  static ContentBlock fromJson(String json) {
    return ensureInitialized().decodeJson<ContentBlock>(json);
  }
}

mixin ContentBlockMappable {
  String toJson() {
    return ContentBlockMapper.ensureInitialized()
        .encodeJson<ContentBlock>(this as ContentBlock);
  }

  Map<String, dynamic> toMap() {
    return ContentBlockMapper.ensureInitialized()
        .encodeMap<ContentBlock>(this as ContentBlock);
  }

  ContentBlockCopyWith<ContentBlock, ContentBlock, ContentBlock> get copyWith =>
      _ContentBlockCopyWithImpl(this as ContentBlock, $identity, $identity);
  @override
  String toString() {
    return ContentBlockMapper.ensureInitialized()
        .stringifyValue(this as ContentBlock);
  }

  @override
  bool operator ==(Object other) {
    return ContentBlockMapper.ensureInitialized()
        .equalsValue(this as ContentBlock, other);
  }

  @override
  int get hashCode {
    return ContentBlockMapper.ensureInitialized()
        .hashValue(this as ContentBlock);
  }
}

extension ContentBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContentBlock, $Out> {
  ContentBlockCopyWith<$R, ContentBlock, $Out> get $asContentBlock =>
      $base.as((v, t, t2) => _ContentBlockCopyWithImpl(v, t, t2));
}

abstract class ContentBlockCopyWith<$R, $In extends ContentBlock, $Out>
    implements BlockCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? content, int? flex, ContentAlignment? align, bool? scrollable});
  ContentBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ContentBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContentBlock, $Out>
    implements ContentBlockCopyWith<$R, ContentBlock, $Out> {
  _ContentBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContentBlock> $mapper =
      ContentBlockMapper.ensureInitialized();
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
  ContentBlock $make(CopyWithData data) => ContentBlock(
      content: data.get(#content, or: $value._content),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      type: data.get(#type, or: $value.type),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  ContentBlockCopyWith<$R2, ContentBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ContentBlockCopyWithImpl($value, $cast, t);
}

class ImageBlockMapper extends SubClassMapperBase<ImageBlock> {
  ImageBlockMapper._();

  static ImageBlockMapper? _instance;
  static ImageBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImageBlockMapper._());
      ContentBlockMapper.ensureInitialized().addSubMapper(_instance!);
      LocalImageBlockMapper.ensureInitialized();
      RemoteImageBlockMapper.ensureInitialized();
      MermaidBlockMapper.ensureInitialized();
      ImageFitMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
      BlockTypeMapper.ensureInitialized();
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
      Field('type', _$type, def: BlockType.content);
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
  final dynamic discriminatorValue = 'ImageBlock';
  @override
  late final ClassMapperBase superMapper =
      ContentBlockMapper.ensureInitialized();

  static ImageBlock _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'ImageBlock', 'type', '${data.value['type']}');
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
  String toJson();
  Map<String, dynamic> toMap();
  ImageBlockCopyWith<ImageBlock, ImageBlock, ImageBlock> get copyWith;
}

abstract class ImageBlockCopyWith<$R, $In extends ImageBlock, $Out>
    implements ContentBlockCopyWith<$R, $In, $Out> {
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

class LocalImageBlockMapper extends SubClassMapperBase<LocalImageBlock> {
  LocalImageBlockMapper._();

  static LocalImageBlockMapper? _instance;
  static LocalImageBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalImageBlockMapper._());
      ImageBlockMapper.ensureInitialized().addSubMapper(_instance!);
      ImageFitMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalImageBlock';

  static String _$src(LocalImageBlock v) => v.src;
  static const Field<LocalImageBlock, String> _f$src = Field('src', _$src);
  static ImageFit? _$fit(LocalImageBlock v) => v.fit;
  static const Field<LocalImageBlock, ImageFit> _f$fit =
      Field('fit', _$fit, opt: true);
  static double? _$width(LocalImageBlock v) => v.width;
  static const Field<LocalImageBlock, double> _f$width =
      Field('width', _$width, opt: true);
  static double? _$height(LocalImageBlock v) => v.height;
  static const Field<LocalImageBlock, double> _f$height =
      Field('height', _$height, opt: true);
  static int? _$flex(LocalImageBlock v) => v.flex;
  static const Field<LocalImageBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(LocalImageBlock v) => v.align;
  static const Field<LocalImageBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static String? _$_content(LocalImageBlock v) => v._content;
  static const Field<LocalImageBlock, String> _f$_content =
      Field('_content', _$_content, key: 'content', opt: true);
  static bool _$scrollable(LocalImageBlock v) => v.scrollable;
  static const Field<LocalImageBlock, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static BlockType _$type(LocalImageBlock v) => v.type;
  static const Field<LocalImageBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);
  static String _$key(LocalImageBlock v) => v.key;
  static const Field<LocalImageBlock, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);

  @override
  final MappableFields<LocalImageBlock> fields = const {
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
  final dynamic discriminatorValue = 'local_image';
  @override
  late final ClassMapperBase superMapper = ImageBlockMapper.ensureInitialized();

  static LocalImageBlock _instantiate(DecodingData data) {
    return LocalImageBlock(
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

  static LocalImageBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalImageBlock>(map);
  }

  static LocalImageBlock fromJson(String json) {
    return ensureInitialized().decodeJson<LocalImageBlock>(json);
  }
}

mixin LocalImageBlockMappable {
  String toJson() {
    return LocalImageBlockMapper.ensureInitialized()
        .encodeJson<LocalImageBlock>(this as LocalImageBlock);
  }

  Map<String, dynamic> toMap() {
    return LocalImageBlockMapper.ensureInitialized()
        .encodeMap<LocalImageBlock>(this as LocalImageBlock);
  }

  LocalImageBlockCopyWith<LocalImageBlock, LocalImageBlock, LocalImageBlock>
      get copyWith => _LocalImageBlockCopyWithImpl(
          this as LocalImageBlock, $identity, $identity);
  @override
  String toString() {
    return LocalImageBlockMapper.ensureInitialized()
        .stringifyValue(this as LocalImageBlock);
  }

  @override
  bool operator ==(Object other) {
    return LocalImageBlockMapper.ensureInitialized()
        .equalsValue(this as LocalImageBlock, other);
  }

  @override
  int get hashCode {
    return LocalImageBlockMapper.ensureInitialized()
        .hashValue(this as LocalImageBlock);
  }
}

extension LocalImageBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalImageBlock, $Out> {
  LocalImageBlockCopyWith<$R, LocalImageBlock, $Out> get $asLocalImageBlock =>
      $base.as((v, t, t2) => _LocalImageBlockCopyWithImpl(v, t, t2));
}

abstract class LocalImageBlockCopyWith<$R, $In extends LocalImageBlock, $Out>
    implements ImageBlockCopyWith<$R, $In, $Out> {
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
  LocalImageBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _LocalImageBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalImageBlock, $Out>
    implements LocalImageBlockCopyWith<$R, LocalImageBlock, $Out> {
  _LocalImageBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalImageBlock> $mapper =
      LocalImageBlockMapper.ensureInitialized();
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
  LocalImageBlock $make(CopyWithData data) => LocalImageBlock(
      src: data.get(#src, or: $value.src),
      fit: data.get(#fit, or: $value.fit),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      content: data.get(#content, or: $value._content),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  LocalImageBlockCopyWith<$R2, LocalImageBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LocalImageBlockCopyWithImpl($value, $cast, t);
}

class RemoteImageBlockMapper extends SubClassMapperBase<RemoteImageBlock> {
  RemoteImageBlockMapper._();

  static RemoteImageBlockMapper? _instance;
  static RemoteImageBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteImageBlockMapper._());
      ImageBlockMapper.ensureInitialized().addSubMapper(_instance!);
      ImageFitMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteImageBlock';

  static String _$src(RemoteImageBlock v) => v.src;
  static const Field<RemoteImageBlock, String> _f$src = Field('src', _$src);
  static ImageFit? _$fit(RemoteImageBlock v) => v.fit;
  static const Field<RemoteImageBlock, ImageFit> _f$fit =
      Field('fit', _$fit, opt: true);
  static double? _$width(RemoteImageBlock v) => v.width;
  static const Field<RemoteImageBlock, double> _f$width =
      Field('width', _$width, opt: true);
  static double? _$height(RemoteImageBlock v) => v.height;
  static const Field<RemoteImageBlock, double> _f$height =
      Field('height', _$height, opt: true);
  static int? _$flex(RemoteImageBlock v) => v.flex;
  static const Field<RemoteImageBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(RemoteImageBlock v) => v.align;
  static const Field<RemoteImageBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static String? _$_content(RemoteImageBlock v) => v._content;
  static const Field<RemoteImageBlock, String> _f$_content =
      Field('_content', _$_content, key: 'content', opt: true);
  static bool _$scrollable(RemoteImageBlock v) => v.scrollable;
  static const Field<RemoteImageBlock, bool> _f$scrollable =
      Field('scrollable', _$scrollable, def: false);
  static BlockType _$type(RemoteImageBlock v) => v.type;
  static const Field<RemoteImageBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);
  static String _$key(RemoteImageBlock v) => v.key;
  static const Field<RemoteImageBlock, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);

  @override
  final MappableFields<RemoteImageBlock> fields = const {
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
  final dynamic discriminatorValue = 'remote_image';
  @override
  late final ClassMapperBase superMapper = ImageBlockMapper.ensureInitialized();

  static RemoteImageBlock _instantiate(DecodingData data) {
    return RemoteImageBlock(
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

  static RemoteImageBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteImageBlock>(map);
  }

  static RemoteImageBlock fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteImageBlock>(json);
  }
}

mixin RemoteImageBlockMappable {
  String toJson() {
    return RemoteImageBlockMapper.ensureInitialized()
        .encodeJson<RemoteImageBlock>(this as RemoteImageBlock);
  }

  Map<String, dynamic> toMap() {
    return RemoteImageBlockMapper.ensureInitialized()
        .encodeMap<RemoteImageBlock>(this as RemoteImageBlock);
  }

  RemoteImageBlockCopyWith<RemoteImageBlock, RemoteImageBlock, RemoteImageBlock>
      get copyWith => _RemoteImageBlockCopyWithImpl(
          this as RemoteImageBlock, $identity, $identity);
  @override
  String toString() {
    return RemoteImageBlockMapper.ensureInitialized()
        .stringifyValue(this as RemoteImageBlock);
  }

  @override
  bool operator ==(Object other) {
    return RemoteImageBlockMapper.ensureInitialized()
        .equalsValue(this as RemoteImageBlock, other);
  }

  @override
  int get hashCode {
    return RemoteImageBlockMapper.ensureInitialized()
        .hashValue(this as RemoteImageBlock);
  }
}

extension RemoteImageBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteImageBlock, $Out> {
  RemoteImageBlockCopyWith<$R, RemoteImageBlock, $Out>
      get $asRemoteImageBlock =>
          $base.as((v, t, t2) => _RemoteImageBlockCopyWithImpl(v, t, t2));
}

abstract class RemoteImageBlockCopyWith<$R, $In extends RemoteImageBlock, $Out>
    implements ImageBlockCopyWith<$R, $In, $Out> {
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
  RemoteImageBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _RemoteImageBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteImageBlock, $Out>
    implements RemoteImageBlockCopyWith<$R, RemoteImageBlock, $Out> {
  _RemoteImageBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteImageBlock> $mapper =
      RemoteImageBlockMapper.ensureInitialized();
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
  RemoteImageBlock $make(CopyWithData data) => RemoteImageBlock(
      src: data.get(#src, or: $value.src),
      fit: data.get(#fit, or: $value.fit),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      content: data.get(#content, or: $value._content),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  RemoteImageBlockCopyWith<$R2, RemoteImageBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RemoteImageBlockCopyWithImpl($value, $cast, t);
}

class MermaidBlockMapper extends SubClassMapperBase<MermaidBlock> {
  MermaidBlockMapper._();

  static MermaidBlockMapper? _instance;
  static MermaidBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MermaidBlockMapper._());
      ImageBlockMapper.ensureInitialized().addSubMapper(_instance!);
      ImageFitMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MermaidBlock';

  static String _$syntax(MermaidBlock v) => v.syntax;
  static const Field<MermaidBlock, String> _f$syntax =
      Field('syntax', _$syntax);
  static String _$src(MermaidBlock v) => v.src;
  static const Field<MermaidBlock, String> _f$src = Field('src', _$src);
  static ImageFit? _$fit(MermaidBlock v) => v.fit;
  static const Field<MermaidBlock, ImageFit> _f$fit = Field('fit', _$fit);
  static double? _$width(MermaidBlock v) => v.width;
  static const Field<MermaidBlock, double> _f$width = Field('width', _$width);
  static double? _$height(MermaidBlock v) => v.height;
  static const Field<MermaidBlock, double> _f$height =
      Field('height', _$height);
  static int? _$flex(MermaidBlock v) => v.flex;
  static const Field<MermaidBlock, int> _f$flex = Field('flex', _$flex);
  static ContentAlignment? _$align(MermaidBlock v) => v.align;
  static const Field<MermaidBlock, ContentAlignment> _f$align =
      Field('align', _$align);
  static String? _$_content(MermaidBlock v) => v._content;
  static const Field<MermaidBlock, String> _f$_content =
      Field('_content', _$_content, key: 'content');
  static bool _$scrollable(MermaidBlock v) => v.scrollable;
  static const Field<MermaidBlock, bool> _f$scrollable =
      Field('scrollable', _$scrollable, def: false);
  static BlockType _$type(MermaidBlock v) => v.type;
  static const Field<MermaidBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);
  static String _$key(MermaidBlock v) => v.key;
  static const Field<MermaidBlock, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);

  @override
  final MappableFields<MermaidBlock> fields = const {
    #syntax: _f$syntax,
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
  final dynamic discriminatorValue = 'mermaid';
  @override
  late final ClassMapperBase superMapper = ImageBlockMapper.ensureInitialized();

  static MermaidBlock _instantiate(DecodingData data) {
    return MermaidBlock(
        syntax: data.dec(_f$syntax),
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

  static MermaidBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MermaidBlock>(map);
  }

  static MermaidBlock fromJson(String json) {
    return ensureInitialized().decodeJson<MermaidBlock>(json);
  }
}

mixin MermaidBlockMappable {
  String toJson() {
    return MermaidBlockMapper.ensureInitialized()
        .encodeJson<MermaidBlock>(this as MermaidBlock);
  }

  Map<String, dynamic> toMap() {
    return MermaidBlockMapper.ensureInitialized()
        .encodeMap<MermaidBlock>(this as MermaidBlock);
  }

  MermaidBlockCopyWith<MermaidBlock, MermaidBlock, MermaidBlock> get copyWith =>
      _MermaidBlockCopyWithImpl(this as MermaidBlock, $identity, $identity);
  @override
  String toString() {
    return MermaidBlockMapper.ensureInitialized()
        .stringifyValue(this as MermaidBlock);
  }

  @override
  bool operator ==(Object other) {
    return MermaidBlockMapper.ensureInitialized()
        .equalsValue(this as MermaidBlock, other);
  }

  @override
  int get hashCode {
    return MermaidBlockMapper.ensureInitialized()
        .hashValue(this as MermaidBlock);
  }
}

extension MermaidBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MermaidBlock, $Out> {
  MermaidBlockCopyWith<$R, MermaidBlock, $Out> get $asMermaidBlock =>
      $base.as((v, t, t2) => _MermaidBlockCopyWithImpl(v, t, t2));
}

abstract class MermaidBlockCopyWith<$R, $In extends MermaidBlock, $Out>
    implements ImageBlockCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? syntax,
      String? src,
      ImageFit? fit,
      double? width,
      double? height,
      int? flex,
      ContentAlignment? align,
      String? content,
      bool? scrollable});
  MermaidBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MermaidBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MermaidBlock, $Out>
    implements MermaidBlockCopyWith<$R, MermaidBlock, $Out> {
  _MermaidBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MermaidBlock> $mapper =
      MermaidBlockMapper.ensureInitialized();
  @override
  $R call(
          {String? syntax,
          String? src,
          Object? fit = $none,
          Object? width = $none,
          Object? height = $none,
          Object? flex = $none,
          Object? align = $none,
          Object? content = $none,
          bool? scrollable}) =>
      $apply(FieldCopyWithData({
        if (syntax != null) #syntax: syntax,
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
  MermaidBlock $make(CopyWithData data) => MermaidBlock(
      syntax: data.get(#syntax, or: $value.syntax),
      src: data.get(#src, or: $value.src),
      fit: data.get(#fit, or: $value.fit),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align),
      content: data.get(#content, or: $value._content),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  MermaidBlockCopyWith<$R2, MermaidBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MermaidBlockCopyWithImpl($value, $cast, t);
}

class WidgetBlockMapper extends SubClassMapperBase<WidgetBlock> {
  WidgetBlockMapper._();

  static WidgetBlockMapper? _instance;
  static WidgetBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WidgetBlockMapper._());
      ContentBlockMapper.ensureInitialized().addSubMapper(_instance!);
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
      ContentBlockMapper.ensureInitialized();

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
    implements ContentBlockCopyWith<$R, $In, $Out> {
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

class DartCodeBlockMapper extends SubClassMapperBase<DartCodeBlock> {
  DartCodeBlockMapper._();

  static DartCodeBlockMapper? _instance;
  static DartCodeBlockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DartCodeBlockMapper._());
      ContentBlockMapper.ensureInitialized().addSubMapper(_instance!);
      DartPadThemeMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DartCodeBlock';

  static String _$id(DartCodeBlock v) => v.id;
  static const Field<DartCodeBlock, String> _f$id = Field('id', _$id);
  static DartPadTheme? _$theme(DartCodeBlock v) => v.theme;
  static const Field<DartCodeBlock, DartPadTheme> _f$theme =
      Field('theme', _$theme, opt: true);
  static int? _$flex(DartCodeBlock v) => v.flex;
  static const Field<DartCodeBlock, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static String? _$_content(DartCodeBlock v) => v._content;
  static const Field<DartCodeBlock, String> _f$_content =
      Field('_content', _$_content, key: 'content', opt: true);
  static ContentAlignment? _$align(DartCodeBlock v) => v.align;
  static const Field<DartCodeBlock, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static bool _$embed(DartCodeBlock v) => v.embed;
  static const Field<DartCodeBlock, bool> _f$embed =
      Field('embed', _$embed, opt: true, def: true);
  static bool _$scrollable(DartCodeBlock v) => v.scrollable;
  static const Field<DartCodeBlock, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);
  static BlockType _$type(DartCodeBlock v) => v.type;
  static const Field<DartCodeBlock, BlockType> _f$type =
      Field('type', _$type, mode: FieldMode.member);
  static String _$key(DartCodeBlock v) => v.key;
  static const Field<DartCodeBlock, String> _f$key =
      Field('key', _$key, mode: FieldMode.member);

  @override
  final MappableFields<DartCodeBlock> fields = const {
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
  final dynamic discriminatorValue = 'dart_code';
  @override
  late final ClassMapperBase superMapper =
      ContentBlockMapper.ensureInitialized();

  static DartCodeBlock _instantiate(DecodingData data) {
    return DartCodeBlock(
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

  static DartCodeBlock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DartCodeBlock>(map);
  }

  static DartCodeBlock fromJson(String json) {
    return ensureInitialized().decodeJson<DartCodeBlock>(json);
  }
}

mixin DartCodeBlockMappable {
  String toJson() {
    return DartCodeBlockMapper.ensureInitialized()
        .encodeJson<DartCodeBlock>(this as DartCodeBlock);
  }

  Map<String, dynamic> toMap() {
    return DartCodeBlockMapper.ensureInitialized()
        .encodeMap<DartCodeBlock>(this as DartCodeBlock);
  }

  DartCodeBlockCopyWith<DartCodeBlock, DartCodeBlock, DartCodeBlock>
      get copyWith => _DartCodeBlockCopyWithImpl(
          this as DartCodeBlock, $identity, $identity);
  @override
  String toString() {
    return DartCodeBlockMapper.ensureInitialized()
        .stringifyValue(this as DartCodeBlock);
  }

  @override
  bool operator ==(Object other) {
    return DartCodeBlockMapper.ensureInitialized()
        .equalsValue(this as DartCodeBlock, other);
  }

  @override
  int get hashCode {
    return DartCodeBlockMapper.ensureInitialized()
        .hashValue(this as DartCodeBlock);
  }
}

extension DartCodeBlockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DartCodeBlock, $Out> {
  DartCodeBlockCopyWith<$R, DartCodeBlock, $Out> get $asDartCodeBlock =>
      $base.as((v, t, t2) => _DartCodeBlockCopyWithImpl(v, t, t2));
}

abstract class DartCodeBlockCopyWith<$R, $In extends DartCodeBlock, $Out>
    implements ContentBlockCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      DartPadTheme? theme,
      int? flex,
      String? content,
      ContentAlignment? align,
      bool? embed,
      bool? scrollable});
  DartCodeBlockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DartCodeBlockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DartCodeBlock, $Out>
    implements DartCodeBlockCopyWith<$R, DartCodeBlock, $Out> {
  _DartCodeBlockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DartCodeBlock> $mapper =
      DartCodeBlockMapper.ensureInitialized();
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
  DartCodeBlock $make(CopyWithData data) => DartCodeBlock(
      id: data.get(#id, or: $value.id),
      theme: data.get(#theme, or: $value.theme),
      flex: data.get(#flex, or: $value.flex),
      content: data.get(#content, or: $value._content),
      align: data.get(#align, or: $value.align),
      embed: data.get(#embed, or: $value.embed),
      scrollable: data.get(#scrollable, or: $value.scrollable));

  @override
  DartCodeBlockCopyWith<$R2, DartCodeBlock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DartCodeBlockCopyWithImpl($value, $cast, t);
}
