// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'slide_model.dart';

class SlideMapper extends ClassMapperBase<Slide> {
  SlideMapper._();

  static SlideMapper? _instance;
  static SlideMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideMapper._());
      SlideOptionsMapper.ensureInitialized();
      SectionBlockMapper.ensureInitialized();
      NoteModelMapper.ensureInitialized();
      AssetModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Slide';

  static String _$key(Slide v) => v.key;
  static const Field<Slide, String> _f$key = Field('key', _$key);
  static SlideOptions? _$options(Slide v) => v.options;
  static const Field<Slide, SlideOptions> _f$options =
      Field('options', _$options, opt: true);
  static String _$markdown(Slide v) => v.markdown;
  static const Field<Slide, String> _f$markdown = Field('markdown', _$markdown);
  static List<SectionBlock> _$sections(Slide v) => v.sections;
  static const Field<Slide, List<SectionBlock>> _f$sections =
      Field('sections', _$sections, opt: true, def: const []);
  static List<NoteModel> _$notes(Slide v) => v.notes;
  static const Field<Slide, List<NoteModel>> _f$notes =
      Field('notes', _$notes, opt: true, def: const []);
  static List<AssetModel> _$assets(Slide v) => v.assets;
  static const Field<Slide, List<AssetModel>> _f$assets =
      Field('assets', _$assets, opt: true, def: const []);

  @override
  final MappableFields<Slide> fields = const {
    #key: _f$key,
    #options: _f$options,
    #markdown: _f$markdown,
    #sections: _f$sections,
    #notes: _f$notes,
    #assets: _f$assets,
  };
  @override
  final bool ignoreNull = true;

  static Slide _instantiate(DecodingData data) {
    return Slide(
        key: data.dec(_f$key),
        options: data.dec(_f$options),
        markdown: data.dec(_f$markdown),
        sections: data.dec(_f$sections),
        notes: data.dec(_f$notes),
        assets: data.dec(_f$assets));
  }

  @override
  final Function instantiate = _instantiate;

  static Slide fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Slide>(map);
  }

  static Slide fromJson(String json) {
    return ensureInitialized().decodeJson<Slide>(json);
  }
}

mixin SlideMappable {
  String toJson() {
    return SlideMapper.ensureInitialized().encodeJson<Slide>(this as Slide);
  }

  Map<String, dynamic> toMap() {
    return SlideMapper.ensureInitialized().encodeMap<Slide>(this as Slide);
  }

  SlideCopyWith<Slide, Slide, Slide> get copyWith =>
      _SlideCopyWithImpl(this as Slide, $identity, $identity);
  @override
  String toString() {
    return SlideMapper.ensureInitialized().stringifyValue(this as Slide);
  }

  @override
  bool operator ==(Object other) {
    return SlideMapper.ensureInitialized().equalsValue(this as Slide, other);
  }

  @override
  int get hashCode {
    return SlideMapper.ensureInitialized().hashValue(this as Slide);
  }
}

extension SlideValueCopy<$R, $Out> on ObjectCopyWith<$R, Slide, $Out> {
  SlideCopyWith<$R, Slide, $Out> get $asSlide =>
      $base.as((v, t, t2) => _SlideCopyWithImpl(v, t, t2));
}

abstract class SlideCopyWith<$R, $In extends Slide, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  SlideOptionsCopyWith<$R, SlideOptions, SlideOptions>? get options;
  ListCopyWith<$R, SectionBlock,
      SectionBlockCopyWith<$R, SectionBlock, SectionBlock>> get sections;
  ListCopyWith<$R, NoteModel, NoteModelCopyWith<$R, NoteModel, NoteModel>>
      get notes;
  ListCopyWith<$R, AssetModel, AssetModelCopyWith<$R, AssetModel, AssetModel>>
      get assets;
  $R call(
      {String? key,
      SlideOptions? options,
      String? markdown,
      List<SectionBlock>? sections,
      List<NoteModel>? notes,
      List<AssetModel>? assets});
  SlideCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SlideCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Slide, $Out>
    implements SlideCopyWith<$R, Slide, $Out> {
  _SlideCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Slide> $mapper = SlideMapper.ensureInitialized();
  @override
  SlideOptionsCopyWith<$R, SlideOptions, SlideOptions>? get options =>
      $value.options?.copyWith.$chain((v) => call(options: v));
  @override
  ListCopyWith<$R, SectionBlock,
          SectionBlockCopyWith<$R, SectionBlock, SectionBlock>>
      get sections => ListCopyWith($value.sections,
          (v, t) => v.copyWith.$chain(t), (v) => call(sections: v));
  @override
  ListCopyWith<$R, NoteModel, NoteModelCopyWith<$R, NoteModel, NoteModel>>
      get notes => ListCopyWith(
          $value.notes, (v, t) => v.copyWith.$chain(t), (v) => call(notes: v));
  @override
  ListCopyWith<$R, AssetModel, AssetModelCopyWith<$R, AssetModel, AssetModel>>
      get assets => ListCopyWith($value.assets, (v, t) => v.copyWith.$chain(t),
          (v) => call(assets: v));
  @override
  $R call(
          {String? key,
          Object? options = $none,
          String? markdown,
          List<SectionBlock>? sections,
          List<NoteModel>? notes,
          List<AssetModel>? assets}) =>
      $apply(FieldCopyWithData({
        if (key != null) #key: key,
        if (options != $none) #options: options,
        if (markdown != null) #markdown: markdown,
        if (sections != null) #sections: sections,
        if (notes != null) #notes: notes,
        if (assets != null) #assets: assets
      }));
  @override
  Slide $make(CopyWithData data) => Slide(
      key: data.get(#key, or: $value.key),
      options: data.get(#options, or: $value.options),
      markdown: data.get(#markdown, or: $value.markdown),
      sections: data.get(#sections, or: $value.sections),
      notes: data.get(#notes, or: $value.notes),
      assets: data.get(#assets, or: $value.assets));

  @override
  SlideCopyWith<$R2, Slide, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SlideCopyWithImpl($value, $cast, t);
}

class NoteModelMapper extends ClassMapperBase<NoteModel> {
  NoteModelMapper._();

  static NoteModelMapper? _instance;
  static NoteModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoteModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'NoteModel';

  static String _$content(NoteModel v) => v.content;
  static const Field<NoteModel, String> _f$content =
      Field('content', _$content);

  @override
  final MappableFields<NoteModel> fields = const {
    #content: _f$content,
  };
  @override
  final bool ignoreNull = true;

  static NoteModel _instantiate(DecodingData data) {
    return NoteModel(content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static NoteModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<NoteModel>(map);
  }

  static NoteModel fromJson(String json) {
    return ensureInitialized().decodeJson<NoteModel>(json);
  }
}

mixin NoteModelMappable {
  String toJson() {
    return NoteModelMapper.ensureInitialized()
        .encodeJson<NoteModel>(this as NoteModel);
  }

  Map<String, dynamic> toMap() {
    return NoteModelMapper.ensureInitialized()
        .encodeMap<NoteModel>(this as NoteModel);
  }

  NoteModelCopyWith<NoteModel, NoteModel, NoteModel> get copyWith =>
      _NoteModelCopyWithImpl(this as NoteModel, $identity, $identity);
  @override
  String toString() {
    return NoteModelMapper.ensureInitialized()
        .stringifyValue(this as NoteModel);
  }

  @override
  bool operator ==(Object other) {
    return NoteModelMapper.ensureInitialized()
        .equalsValue(this as NoteModel, other);
  }

  @override
  int get hashCode {
    return NoteModelMapper.ensureInitialized().hashValue(this as NoteModel);
  }
}

extension NoteModelValueCopy<$R, $Out> on ObjectCopyWith<$R, NoteModel, $Out> {
  NoteModelCopyWith<$R, NoteModel, $Out> get $asNoteModel =>
      $base.as((v, t, t2) => _NoteModelCopyWithImpl(v, t, t2));
}

abstract class NoteModelCopyWith<$R, $In extends NoteModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? content});
  NoteModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NoteModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, NoteModel, $Out>
    implements NoteModelCopyWith<$R, NoteModel, $Out> {
  _NoteModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<NoteModel> $mapper =
      NoteModelMapper.ensureInitialized();
  @override
  $R call({String? content}) =>
      $apply(FieldCopyWithData({if (content != null) #content: content}));
  @override
  NoteModel $make(CopyWithData data) =>
      NoteModel(content: data.get(#content, or: $value.content));

  @override
  NoteModelCopyWith<$R2, NoteModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _NoteModelCopyWithImpl($value, $cast, t);
}
