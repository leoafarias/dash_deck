// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'presentation_controller.dart';

class DeckConfigurationMapper extends ClassMapperBase<DeckConfiguration> {
  DeckConfigurationMapper._();

  static DeckConfigurationMapper? _instance;
  static DeckConfigurationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeckConfigurationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DeckConfiguration';

  static Map<String, DeckStyle> _$styles(DeckConfiguration v) => v.styles;
  static const Field<DeckConfiguration, Map<String, DeckStyle>> _f$styles =
      Field('styles', _$styles, opt: true, def: const {});
  static DeckStyle _$baseStyle(DeckConfiguration v) => v.baseStyle;
  static const Field<DeckConfiguration, DeckStyle> _f$baseStyle =
      Field('baseStyle', _$baseStyle, opt: true, def: const DeckStyle());
  static Map<String, Widget Function(BuildContext, WidgetBlock)> _$widgets(
          DeckConfiguration v) =>
      v.widgets;
  static const Field<DeckConfiguration,
          Map<String, Widget Function(BuildContext, WidgetBlock)>> _f$widgets =
      Field('widgets', _$widgets, opt: true, def: const {});
  static FixedSlidePartWidget? _$header(DeckConfiguration v) => v.header;
  static const Field<DeckConfiguration, FixedSlidePartWidget> _f$header =
      Field('header', _$header, opt: true);
  static FixedSlidePartWidget? _$footer(DeckConfiguration v) => v.footer;
  static const Field<DeckConfiguration, FixedSlidePartWidget> _f$footer =
      Field('footer', _$footer, opt: true);
  static SlidePartWidget? _$background(DeckConfiguration v) => v.background;
  static const Field<DeckConfiguration, SlidePartWidget> _f$background =
      Field('background', _$background, opt: true);
  static bool _$debug(DeckConfiguration v) => v.debug;
  static const Field<DeckConfiguration, bool> _f$debug =
      Field('debug', _$debug, opt: true, def: false);

  @override
  final MappableFields<DeckConfiguration> fields = const {
    #styles: _f$styles,
    #baseStyle: _f$baseStyle,
    #widgets: _f$widgets,
    #header: _f$header,
    #footer: _f$footer,
    #background: _f$background,
    #debug: _f$debug,
  };

  static DeckConfiguration _instantiate(DecodingData data) {
    return DeckConfiguration(
        styles: data.dec(_f$styles),
        baseStyle: data.dec(_f$baseStyle),
        widgets: data.dec(_f$widgets),
        header: data.dec(_f$header),
        footer: data.dec(_f$footer),
        background: data.dec(_f$background),
        debug: data.dec(_f$debug));
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
  MapCopyWith<$R, String, DeckStyle, ObjectCopyWith<$R, DeckStyle, DeckStyle>>
      get styles;
  MapCopyWith<
      $R,
      String,
      Widget Function(BuildContext, WidgetBlock),
      ObjectCopyWith<$R, Widget Function(BuildContext, WidgetBlock),
          Widget Function(BuildContext, WidgetBlock)>> get widgets;
  $R call(
      {Map<String, DeckStyle>? styles,
      DeckStyle? baseStyle,
      Map<String, Widget Function(BuildContext, WidgetBlock)>? widgets,
      FixedSlidePartWidget? header,
      FixedSlidePartWidget? footer,
      SlidePartWidget? background,
      bool? debug});
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
  MapCopyWith<$R, String, DeckStyle, ObjectCopyWith<$R, DeckStyle, DeckStyle>>
      get styles => MapCopyWith($value.styles,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(styles: v));
  @override
  MapCopyWith<
      $R,
      String,
      Widget Function(BuildContext, WidgetBlock),
      ObjectCopyWith<$R, Widget Function(BuildContext, WidgetBlock),
          Widget Function(BuildContext, WidgetBlock)>> get widgets =>
      MapCopyWith($value.widgets, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(widgets: v));
  @override
  $R call(
          {Map<String, DeckStyle>? styles,
          DeckStyle? baseStyle,
          Map<String, Widget Function(BuildContext, WidgetBlock)>? widgets,
          Object? header = $none,
          Object? footer = $none,
          Object? background = $none,
          bool? debug}) =>
      $apply(FieldCopyWithData({
        if (styles != null) #styles: styles,
        if (baseStyle != null) #baseStyle: baseStyle,
        if (widgets != null) #widgets: widgets,
        if (header != $none) #header: header,
        if (footer != $none) #footer: footer,
        if (background != $none) #background: background,
        if (debug != null) #debug: debug
      }));
  @override
  DeckConfiguration $make(CopyWithData data) => DeckConfiguration(
      styles: data.get(#styles, or: $value.styles),
      baseStyle: data.get(#baseStyle, or: $value.baseStyle),
      widgets: data.get(#widgets, or: $value.widgets),
      header: data.get(#header, or: $value.header),
      footer: data.get(#footer, or: $value.footer),
      background: data.get(#background, or: $value.background),
      debug: data.get(#debug, or: $value.debug));

  @override
  DeckConfigurationCopyWith<$R2, DeckConfiguration, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeckConfigurationCopyWithImpl($value, $cast, t);
}
