// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'deck_configuration.dart';

class DeckConfigurationMapper extends ClassMapperBase<DeckConfiguration> {
  DeckConfigurationMapper._();

  static DeckConfigurationMapper? _instance;
  static DeckConfigurationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckConfigurationMapper._());
      DeckOptionsMapper.ensureInitialized();
      SlideConfigurationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DeckConfiguration';

  static DeckOptions _$options(DeckConfiguration v) => v.options;
  static const Field<DeckConfiguration, DeckOptions> _f$options =
      Field('options', _$options);
  static List<SlideConfiguration> _$slides(DeckConfiguration v) => v.slides;
  static const Field<DeckConfiguration, List<SlideConfiguration>> _f$slides =
      Field('slides', _$slides);

  @override
  final MappableFields<DeckConfiguration> fields = const {
    #options: _f$options,
    #slides: _f$slides,
  };

  static DeckConfiguration _instantiate(DecodingData data) {
    return DeckConfiguration(
        options: data.dec(_f$options), slides: data.dec(_f$slides));
  }

  @override
  final Function instantiate = _instantiate;

  static DeckConfiguration fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeckConfiguration>(map);
  }

  static DeckConfiguration fromJson(String json) {
    return ensureInitialized().decodeJson<DeckConfiguration>(json);
  }
}

mixin DeckConfigurationMappable {
  String toJson() {
    return DeckConfigurationMapper.ensureInitialized()
        .encodeJson<DeckConfiguration>(this as DeckConfiguration);
  }

  Map<String, dynamic> toMap() {
    return DeckConfigurationMapper.ensureInitialized()
        .encodeMap<DeckConfiguration>(this as DeckConfiguration);
  }

  DeckConfigurationCopyWith<DeckConfiguration, DeckConfiguration,
          DeckConfiguration>
      get copyWith => _DeckConfigurationCopyWithImpl(
          this as DeckConfiguration, $identity, $identity);
  @override
  String toString() {
    return DeckConfigurationMapper.ensureInitialized()
        .stringifyValue(this as DeckConfiguration);
  }

  @override
  bool operator ==(Object other) {
    return DeckConfigurationMapper.ensureInitialized()
        .equalsValue(this as DeckConfiguration, other);
  }

  @override
  int get hashCode {
    return DeckConfigurationMapper.ensureInitialized()
        .hashValue(this as DeckConfiguration);
  }
}

extension DeckConfigurationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DeckConfiguration, $Out> {
  DeckConfigurationCopyWith<$R, DeckConfiguration, $Out>
      get $asDeckConfiguration =>
          $base.as((v, t, t2) => _DeckConfigurationCopyWithImpl(v, t, t2));
}

abstract class DeckConfigurationCopyWith<$R, $In extends DeckConfiguration,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  DeckOptionsCopyWith<$R, DeckOptions, DeckOptions> get options;
  ListCopyWith<
      $R,
      SlideConfiguration,
      SlideConfigurationCopyWith<$R, SlideConfiguration,
          SlideConfiguration>> get slides;
  $R call({DeckOptions? options, List<SlideConfiguration>? slides});
  DeckConfigurationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DeckConfigurationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeckConfiguration, $Out>
    implements DeckConfigurationCopyWith<$R, DeckConfiguration, $Out> {
  _DeckConfigurationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeckConfiguration> $mapper =
      DeckConfigurationMapper.ensureInitialized();
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
  DeckConfiguration $make(CopyWithData data) => DeckConfiguration(
      options: data.get(#options, or: $value.options),
      slides: data.get(#slides, or: $value.slides));

  @override
  DeckConfigurationCopyWith<$R2, DeckConfiguration, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeckConfigurationCopyWithImpl($value, $cast, t);
}
