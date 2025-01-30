// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'deck_configuration.dart';

class DeckControllerMapper extends ClassMapperBase<DeckController> {
  DeckControllerMapper._();

  static DeckControllerMapper? _instance;
  static DeckControllerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckControllerMapper._());
      DeckOptionsMapper.ensureInitialized();
      SlideConfigurationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DeckController';

  static DeckOptions _$options(DeckController v) => v.options;
  static const Field<DeckController, DeckOptions> _f$options =
      Field('options', _$options);
  static List<SlideConfiguration> _$slides(DeckController v) => v.slides;
  static const Field<DeckController, List<SlideConfiguration>> _f$slides =
      Field('slides', _$slides);

  @override
  final MappableFields<DeckController> fields = const {
    #options: _f$options,
    #slides: _f$slides,
  };

  static DeckController _instantiate(DecodingData data) {
    return DeckController(
        options: data.dec(_f$options), slides: data.dec(_f$slides));
  }

  @override
  final Function instantiate = _instantiate;

  static DeckController fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeckController>(map);
  }

  static DeckController fromJson(String json) {
    return ensureInitialized().decodeJson<DeckController>(json);
  }
}

mixin DeckControllerMappable {
  String toJson() {
    return DeckControllerMapper.ensureInitialized()
        .encodeJson<DeckController>(this as DeckController);
  }

  Map<String, dynamic> toMap() {
    return DeckControllerMapper.ensureInitialized()
        .encodeMap<DeckController>(this as DeckController);
  }

  DeckControllerCopyWith<DeckController, DeckController, DeckController>
      get copyWith => _DeckControllerCopyWithImpl(
          this as DeckController, $identity, $identity);
  @override
  String toString() {
    return DeckControllerMapper.ensureInitialized()
        .stringifyValue(this as DeckController);
  }

  @override
  bool operator ==(Object other) {
    return DeckControllerMapper.ensureInitialized()
        .equalsValue(this as DeckController, other);
  }

  @override
  int get hashCode {
    return DeckControllerMapper.ensureInitialized()
        .hashValue(this as DeckController);
  }
}

extension DeckControllerValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DeckController, $Out> {
  DeckControllerCopyWith<$R, DeckController, $Out> get $asDeckController =>
      $base.as((v, t, t2) => _DeckControllerCopyWithImpl(v, t, t2));
}

abstract class DeckControllerCopyWith<$R, $In extends DeckController, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  DeckOptionsCopyWith<$R, DeckOptions, DeckOptions> get options;
  ListCopyWith<
      $R,
      SlideConfiguration,
      SlideConfigurationCopyWith<$R, SlideConfiguration,
          SlideConfiguration>> get slides;
  $R call({DeckOptions? options, List<SlideConfiguration>? slides});
  DeckControllerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DeckControllerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeckController, $Out>
    implements DeckControllerCopyWith<$R, DeckController, $Out> {
  _DeckControllerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeckController> $mapper =
      DeckControllerMapper.ensureInitialized();
  @override
  DeckOptionsCopyWith<$R, DeckOptions, DeckOptions> get options =>
      $value.options.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<
      $R,
      SlideConfiguration,
      SlideConfigurationCopyWith<$R, SlideConfiguration,
          SlideConfiguration>> get slides => ListCopyWith(
      $value.slides, (v, t) => v.copyWith.$chain(t), (v) => call(slides: v));
  @override
  $R call({DeckOptions? options, List<SlideConfiguration>? slides}) =>
      $apply(FieldCopyWithData({
        if (options != null) #options: options,
        if (slides != null) #slides: slides
      }));
  @override
  DeckController $make(CopyWithData data) => DeckController(
      options: data.get(#options, or: $value.options),
      slides: data.get(#slides, or: $value.slides));

  @override
  DeckControllerCopyWith<$R2, DeckController, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeckControllerCopyWithImpl($value, $cast, t);
}
