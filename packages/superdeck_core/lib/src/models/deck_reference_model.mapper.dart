// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'deck_reference_model.dart';

class DeckReferenceModelMapper extends ClassMapperBase<DeckReferenceModel> {
  DeckReferenceModelMapper._();

  static DeckReferenceModelMapper? _instance;
  static DeckReferenceModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckReferenceModelMapper._());
      SlideMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DeckReferenceModel';

  static List<Slide> _$slides(DeckReferenceModel v) => v.slides;
  static const Field<DeckReferenceModel, List<Slide>> _f$slides =
      Field('slides', _$slides);

  @override
  final MappableFields<DeckReferenceModel> fields = const {
    #slides: _f$slides,
  };
  @override
  final bool ignoreNull = true;

  static DeckReferenceModel _instantiate(DecodingData data) {
    return DeckReferenceModel(slides: data.dec(_f$slides));
  }

  @override
  final Function instantiate = _instantiate;

  static DeckReferenceModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeckReferenceModel>(map);
  }

  static DeckReferenceModel fromJson(String json) {
    return ensureInitialized().decodeJson<DeckReferenceModel>(json);
  }
}

mixin DeckReferenceModelMappable {
  String toJson() {
    return DeckReferenceModelMapper.ensureInitialized()
        .encodeJson<DeckReferenceModel>(this as DeckReferenceModel);
  }

  Map<String, dynamic> toMap() {
    return DeckReferenceModelMapper.ensureInitialized()
        .encodeMap<DeckReferenceModel>(this as DeckReferenceModel);
  }

  DeckReferenceModelCopyWith<DeckReferenceModel, DeckReferenceModel,
          DeckReferenceModel>
      get copyWith => _DeckReferenceModelCopyWithImpl(
          this as DeckReferenceModel, $identity, $identity);
  @override
  String toString() {
    return DeckReferenceModelMapper.ensureInitialized()
        .stringifyValue(this as DeckReferenceModel);
  }

  @override
  bool operator ==(Object other) {
    return DeckReferenceModelMapper.ensureInitialized()
        .equalsValue(this as DeckReferenceModel, other);
  }

  @override
  int get hashCode {
    return DeckReferenceModelMapper.ensureInitialized()
        .hashValue(this as DeckReferenceModel);
  }
}

extension DeckReferenceModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DeckReferenceModel, $Out> {
  DeckReferenceModelCopyWith<$R, DeckReferenceModel, $Out>
      get $asDeckReferenceModel =>
          $base.as((v, t, t2) => _DeckReferenceModelCopyWithImpl(v, t, t2));
}

abstract class DeckReferenceModelCopyWith<$R, $In extends DeckReferenceModel,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Slide, SlideCopyWith<$R, Slide, Slide>> get slides;
  $R call({List<Slide>? slides});
  DeckReferenceModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DeckReferenceModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeckReferenceModel, $Out>
    implements DeckReferenceModelCopyWith<$R, DeckReferenceModel, $Out> {
  _DeckReferenceModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeckReferenceModel> $mapper =
      DeckReferenceModelMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Slide, SlideCopyWith<$R, Slide, Slide>> get slides =>
      ListCopyWith($value.slides, (v, t) => v.copyWith.$chain(t),
          (v) => call(slides: v));
  @override
  $R call({List<Slide>? slides}) =>
      $apply(FieldCopyWithData({if (slides != null) #slides: slides}));
  @override
  DeckReferenceModel $make(CopyWithData data) =>
      DeckReferenceModel(slides: data.get(#slides, or: $value.slides));

  @override
  DeckReferenceModelCopyWith<$R2, DeckReferenceModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeckReferenceModelCopyWithImpl($value, $cast, t);
}
