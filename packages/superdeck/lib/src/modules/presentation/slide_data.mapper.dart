// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_data.dart';

class SlideDataMapper extends ClassMapperBase<SlideData> {
  SlideDataMapper._();

  static SlideDataMapper? _instance;
  static SlideDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideDataMapper._());
      SlideMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SlideData';

  static int _$slideIndex(SlideData v) => v.slideIndex;
  static const Field<SlideData, int> _f$slideIndex =
      Field('slideIndex', _$slideIndex);
  static Style _$style(SlideData v) => v.style;
  static const Field<SlideData, Style> _f$style = Field('style', _$style);
  static Slide _$_slide(SlideData v) => v._slide;
  static const Field<SlideData, Slide> _f$_slide =
      Field('_slide', _$_slide, key: 'slide');
  static FixedSlidePartWidget? _$_header(SlideData v) => v._header;
  static const Field<SlideData, FixedSlidePartWidget> _f$_header =
      Field('_header', _$_header, key: 'header', opt: true);
  static FixedSlidePartWidget? _$_footer(SlideData v) => v._footer;
  static const Field<SlideData, FixedSlidePartWidget> _f$_footer =
      Field('_footer', _$_footer, key: 'footer', opt: true);
  static SlidePartWidget? _$_background(SlideData v) => v._background;
  static const Field<SlideData, SlidePartWidget> _f$_background =
      Field('_background', _$_background, key: 'background', opt: true);
  static Map<String, Widget Function(BuildContext, WidgetElement)> _$_widgets(
          SlideData v) =>
      v._widgets;
  static const Field<SlideData,
          Map<String, Widget Function(BuildContext, WidgetElement)>>
      _f$_widgets =
      Field('_widgets', _$_widgets, key: 'widgets', opt: true, def: const {});
  static int _$totalSlideCount(SlideData v) => v.totalSlideCount;
  static const Field<SlideData, int> _f$totalSlideCount =
      Field('totalSlideCount', _$totalSlideCount);

  @override
  final MappableFields<SlideData> fields = const {
    #slideIndex: _f$slideIndex,
    #style: _f$style,
    #_slide: _f$_slide,
    #_header: _f$_header,
    #_footer: _f$_footer,
    #_background: _f$_background,
    #_widgets: _f$_widgets,
    #totalSlideCount: _f$totalSlideCount,
  };

  static SlideData _instantiate(DecodingData data) {
    return SlideData(
        slideIndex: data.dec(_f$slideIndex),
        style: data.dec(_f$style),
        slide: data.dec(_f$_slide),
        header: data.dec(_f$_header),
        footer: data.dec(_f$_footer),
        background: data.dec(_f$_background),
        widgets: data.dec(_f$_widgets),
        totalSlideCount: data.dec(_f$totalSlideCount));
  }

  @override
  final Function instantiate = _instantiate;

  static SlideData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideData>(map);
  }

  static SlideData fromJson(String json) {
    return ensureInitialized().decodeJson<SlideData>(json);
  }
}

mixin SlideDataMappable {
  String toJson() {
    return SlideDataMapper.ensureInitialized()
        .encodeJson<SlideData>(this as SlideData);
  }

  Map<String, dynamic> toMap() {
    return SlideDataMapper.ensureInitialized()
        .encodeMap<SlideData>(this as SlideData);
  }

  SlideDataCopyWith<SlideData, SlideData, SlideData> get copyWith =>
      _SlideDataCopyWithImpl(this as SlideData, $identity, $identity);
  @override
  String toString() {
    return SlideDataMapper.ensureInitialized()
        .stringifyValue(this as SlideData);
  }

  @override
  bool operator ==(Object other) {
    return SlideDataMapper.ensureInitialized()
        .equalsValue(this as SlideData, other);
  }

  @override
  int get hashCode {
    return SlideDataMapper.ensureInitialized().hashValue(this as SlideData);
  }
}

extension SlideDataValueCopy<$R, $Out> on ObjectCopyWith<$R, SlideData, $Out> {
  SlideDataCopyWith<$R, SlideData, $Out> get $asSlideData =>
      $base.as((v, t, t2) => _SlideDataCopyWithImpl(v, t, t2));
}

abstract class SlideDataCopyWith<$R, $In extends SlideData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  SlideCopyWith<$R, Slide, Slide> get _slide;
  MapCopyWith<
      $R,
      String,
      Widget Function(BuildContext, WidgetElement),
      ObjectCopyWith<$R, Widget Function(BuildContext, WidgetElement),
          Widget Function(BuildContext, WidgetElement)>> get _widgets;
  $R call(
      {int? slideIndex,
      Style? style,
      Slide? slide,
      FixedSlidePartWidget? header,
      FixedSlidePartWidget? footer,
      SlidePartWidget? background,
      Map<String, Widget Function(BuildContext, WidgetElement)>? widgets,
      int? totalSlideCount});
  SlideDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SlideData, $Out>
    implements SlideDataCopyWith<$R, SlideData, $Out> {
  _SlideDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SlideData> $mapper =
      SlideDataMapper.ensureInitialized();
  @override
  SlideCopyWith<$R, Slide, Slide> get _slide =>
      $value._slide.copyWith.$chain((v) => call(slide: v));
  @override
  MapCopyWith<
      $R,
      String,
      Widget Function(BuildContext, WidgetElement),
      ObjectCopyWith<$R, Widget Function(BuildContext, WidgetElement),
          Widget Function(BuildContext, WidgetElement)>> get _widgets =>
      MapCopyWith($value._widgets, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(widgets: v));
  @override
  $R call(
          {int? slideIndex,
          Style? style,
          Slide? slide,
          Object? header = $none,
          Object? footer = $none,
          Object? background = $none,
          Map<String, Widget Function(BuildContext, WidgetElement)>? widgets,
          int? totalSlideCount}) =>
      $apply(FieldCopyWithData({
        if (slideIndex != null) #slideIndex: slideIndex,
        if (style != null) #style: style,
        if (slide != null) #slide: slide,
        if (header != $none) #header: header,
        if (footer != $none) #footer: footer,
        if (background != $none) #background: background,
        if (widgets != null) #widgets: widgets,
        if (totalSlideCount != null) #totalSlideCount: totalSlideCount
      }));
  @override
  SlideData $make(CopyWithData data) => SlideData(
      slideIndex: data.get(#slideIndex, or: $value.slideIndex),
      style: data.get(#style, or: $value.style),
      slide: data.get(#slide, or: $value._slide),
      header: data.get(#header, or: $value._header),
      footer: data.get(#footer, or: $value._footer),
      background: data.get(#background, or: $value._background),
      widgets: data.get(#widgets, or: $value._widgets),
      totalSlideCount: data.get(#totalSlideCount, or: $value.totalSlideCount));

  @override
  SlideDataCopyWith<$R2, SlideData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SlideDataCopyWithImpl($value, $cast, t);
}
