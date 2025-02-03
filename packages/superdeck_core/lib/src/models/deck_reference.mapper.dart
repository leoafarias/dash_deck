// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'deck_reference.dart';

class DeckReferenceMapper extends RecordMapperBase<DeckReference> {
  static DeckReferenceMapper? _instance;
  DeckReferenceMapper._();

  static DeckReferenceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckReferenceMapper._());
      MapperBase.addType(<A, B>(f) => f<({A configuration, B slides})>());
    }
    return _instance!;
  }

  static List<Slide> _$slides(DeckReference v) => v.slides;
  static const Field<DeckReference, List<Slide>> _f$slides =
      Field('slides', _$slides);
  static DeckConfiguration _$configuration(DeckReference v) => v.configuration;
  static const Field<DeckReference, DeckConfiguration> _f$configuration =
      Field('configuration', _$configuration);

  @override
  final MappableFields<DeckReference> fields = const {
    #slides: _f$slides,
    #configuration: _f$configuration,
  };

  @override
  Function get typeFactory => (f) => f<DeckReference>();

  @override
  List<Type> apply(MappingContext context) {
    return [];
  }

  static DeckReference _instantiate(DecodingData<DeckReference> data) {
    return (
      slides: data.dec(_f$slides),
      configuration: data.dec(_f$configuration)
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DeckReference fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeckReference>(map);
  }

  static DeckReference fromJson(String json) {
    return ensureInitialized().decodeJson<DeckReference>(json);
  }
}

extension DeckReferenceMappable on DeckReference {
  Map<String, dynamic> toMap() {
    return DeckReferenceMapper.ensureInitialized().encodeMap(this);
  }

  String toJson() {
    return DeckReferenceMapper.ensureInitialized().encodeJson(this);
  }

  DeckReferenceCopyWith<DeckReference> get copyWith =>
      _DeckReferenceCopyWithImpl(this, $identity, $identity);
}

extension DeckReferenceValueCopy<$R>
    on ObjectCopyWith<$R, DeckReference, DeckReference> {
  DeckReferenceCopyWith<$R> get $asDeckReference =>
      $base.as((v, t, t2) => _DeckReferenceCopyWithImpl(v, t, t2));
}

abstract class DeckReferenceCopyWith<$R>
    implements RecordCopyWith<$R, DeckReference> {
  $R call({List<Slide>? slides, DeckConfiguration? configuration});
  DeckReferenceCopyWith<$R2> $chain<$R2>(Then<DeckReference, $R2> t);
}

class _DeckReferenceCopyWithImpl<$R>
    extends RecordCopyWithBase<$R, DeckReference>
    implements DeckReferenceCopyWith<$R> {
  _DeckReferenceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final RecordMapperBase<DeckReference> $mapper =
      DeckReferenceMapper.ensureInitialized();
  @override
  $R call({List<Slide>? slides, DeckConfiguration? configuration}) =>
      $apply(FieldCopyWithData({
        if (slides != null) #slides: slides,
        if (configuration != null) #configuration: configuration
      }));
  @override
  DeckReference $make(CopyWithData data) => (
        slides: data.get(#slides, or: $value.slides),
        configuration: data.get(#configuration, or: $value.configuration)
      );

  @override
  DeckReferenceCopyWith<$R2> $chain<$R2>(Then<DeckReference, $R2> t) =>
      _DeckReferenceCopyWithImpl($value, $cast, t);
}
