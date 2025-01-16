// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'block_model.dart';

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

class LayoutElementMapper extends ClassMapperBase<LayoutElement> {
  LayoutElementMapper._();

  static LayoutElementMapper? _instance;
  static LayoutElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LayoutElementMapper._());
      SectionElementMapper.ensureInitialized();
      BlockElementMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LayoutElement';

  static int? _$flex(LayoutElement v) => v.flex;
  static const Field<LayoutElement, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(LayoutElement v) => v.align;
  static const Field<LayoutElement, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static bool _$scrollable(LayoutElement v) => v.scrollable;
  static const Field<LayoutElement, bool> _f$scrollable =
      Field('scrollable', _$scrollable, opt: true, def: false);

  @override
  final MappableFields<LayoutElement> fields = const {
    #flex: _f$flex,
    #align: _f$align,
    #scrollable: _f$scrollable,
  };
  @override
  final bool ignoreNull = true;

  static LayoutElement _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('LayoutElement');
  }

  @override
  final Function instantiate = _instantiate;

  static LayoutElement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LayoutElement>(map);
  }

  static LayoutElement fromJson(String json) {
    return ensureInitialized().decodeJson<LayoutElement>(json);
  }
}

mixin LayoutElementMappable {
  String toJson();
  Map<String, dynamic> toMap();
  LayoutElementCopyWith<LayoutElement, LayoutElement, LayoutElement>
      get copyWith;
}

abstract class LayoutElementCopyWith<$R, $In extends LayoutElement, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? flex, ContentAlignment? align});
  LayoutElementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SectionElementMapper extends ClassMapperBase<SectionElement> {
  SectionElementMapper._();

  static SectionElementMapper? _instance;
  static SectionElementMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SectionElementMapper._());
      LayoutElementMapper.ensureInitialized();
      MapperContainer.globals.useAll([NullIfEmptyBlock()]);
      BlockElementMapper.ensureInitialized();
      ContentAlignmentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SectionElement';

  static List<BlockElement> _$blocks(SectionElement v) => v.blocks;
  static const Field<SectionElement, List<BlockElement>> _f$blocks =
      Field('blocks', _$blocks, opt: true, def: const []);
  static int? _$flex(SectionElement v) => v.flex;
  static const Field<SectionElement, int> _f$flex =
      Field('flex', _$flex, opt: true);
  static ContentAlignment? _$align(SectionElement v) => v.align;
  static const Field<SectionElement, ContentAlignment> _f$align =
      Field('align', _$align, opt: true);
  static bool _$scrollable(SectionElement v) => v.scrollable;
  static const Field<SectionElement, bool> _f$scrollable =
      Field('scrollable', _$scrollable, mode: FieldMode.member);

  @override
  final MappableFields<SectionElement> fields = const {
    #blocks: _f$blocks,
    #flex: _f$flex,
    #align: _f$align,
    #scrollable: _f$scrollable,
  };
  @override
  final bool ignoreNull = true;

  static SectionElement _instantiate(DecodingData data) {
    return SectionElement(
        blocks: data.dec(_f$blocks),
        flex: data.dec(_f$flex),
        align: data.dec(_f$align));
  }

  @override
  final Function instantiate = _instantiate;

  static SectionElement fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SectionElement>(map);
  }

  static SectionElement fromJson(String json) {
    return ensureInitialized().decodeJson<SectionElement>(json);
  }
}

mixin SectionElementMappable {
  String toJson() {
    return SectionElementMapper.ensureInitialized()
        .encodeJson<SectionElement>(this as SectionElement);
  }

  Map<String, dynamic> toMap() {
    return SectionElementMapper.ensureInitialized()
        .encodeMap<SectionElement>(this as SectionElement);
  }

  SectionElementCopyWith<SectionElement, SectionElement, SectionElement>
      get copyWith => _SectionElementCopyWithImpl(
          this as SectionElement, $identity, $identity);
  @override
  String toString() {
    return SectionElementMapper.ensureInitialized()
        .stringifyValue(this as SectionElement);
  }

  @override
  bool operator ==(Object other) {
    return SectionElementMapper.ensureInitialized()
        .equalsValue(this as SectionElement, other);
  }

  @override
  int get hashCode {
    return SectionElementMapper.ensureInitialized()
        .hashValue(this as SectionElement);
  }
}

extension SectionElementValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SectionElement, $Out> {
  SectionElementCopyWith<$R, SectionElement, $Out> get $asSectionElement =>
      $base.as((v, t, t2) => _SectionElementCopyWithImpl(v, t, t2));
}

abstract class SectionElementCopyWith<$R, $In extends SectionElement, $Out>
    implements LayoutElementCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, BlockElement,
      BlockElementCopyWith<$R, BlockElement, BlockElement>> get blocks;
  @override
  $R call({List<BlockElement>? blocks, int? flex, ContentAlignment? align});
  SectionElementCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SectionElementCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SectionElement, $Out>
    implements SectionElementCopyWith<$R, SectionElement, $Out> {
  _SectionElementCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SectionElement> $mapper =
      SectionElementMapper.ensureInitialized();
  @override
  ListCopyWith<$R, BlockElement,
          BlockElementCopyWith<$R, BlockElement, BlockElement>>
      get blocks => ListCopyWith($value.blocks, (v, t) => v.copyWith.$chain(t),
          (v) => call(blocks: v));
  @override
  $R call(
          {List<BlockElement>? blocks,
          Object? flex = $none,
          Object? align = $none}) =>
      $apply(FieldCopyWithData({
        if (blocks != null) #blocks: blocks,
        if (flex != $none) #flex: flex,
        if (align != $none) #align: align
      }));
  @override
  SectionElement $make(CopyWithData data) => SectionElement(
      blocks: data.get(#blocks, or: $value.blocks),
      flex: data.get(#flex, or: $value.flex),
      align: data.get(#align, or: $value.align));

  @override
  SectionElementCopyWith<$R2, SectionElement, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SectionElementCopyWithImpl($value, $cast, t);
}
