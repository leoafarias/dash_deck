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
      NoteMapper.ensureInitialized();
      AssetMapper.ensureInitialized();
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
  static List<Note> _$notes(Slide v) => v.notes;
  static const Field<Slide, List<Note>> _f$notes =
      Field('notes', _$notes, opt: true, def: const []);
  static List<Asset> _$assets(Slide v) => v.assets;
  static const Field<Slide, List<Asset>> _f$assets =
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
  ListCopyWith<$R, Note, NoteCopyWith<$R, Note, Note>> get notes;
  ListCopyWith<$R, Asset, AssetCopyWith<$R, Asset, Asset>> get assets;
  $R call(
      {String? key,
      SlideOptions? options,
      String? markdown,
      List<SectionBlock>? sections,
      List<Note>? notes,
      List<Asset>? assets});
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
  ListCopyWith<$R, Note, NoteCopyWith<$R, Note, Note>> get notes =>
      ListCopyWith(
          $value.notes, (v, t) => v.copyWith.$chain(t), (v) => call(notes: v));
  @override
  ListCopyWith<$R, Asset, AssetCopyWith<$R, Asset, Asset>> get assets =>
      ListCopyWith($value.assets, (v, t) => v.copyWith.$chain(t),
          (v) => call(assets: v));
  @override
  $R call(
          {String? key,
          Object? options = $none,
          String? markdown,
          List<SectionBlock>? sections,
          List<Note>? notes,
          List<Asset>? assets}) =>
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

class NoteMapper extends ClassMapperBase<Note> {
  NoteMapper._();

  static NoteMapper? _instance;
  static NoteMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = NoteMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Note';

  static String _$content(Note v) => v.content;
  static const Field<Note, String> _f$content = Field('content', _$content);

  @override
  final MappableFields<Note> fields = const {
    #content: _f$content,
  };
  @override
  final bool ignoreNull = true;

  static Note _instantiate(DecodingData data) {
    return Note(content: data.dec(_f$content));
  }

  @override
  final Function instantiate = _instantiate;

  static Note fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Note>(map);
  }

  static Note fromJson(String json) {
    return ensureInitialized().decodeJson<Note>(json);
  }
}

mixin NoteMappable {
  String toJson() {
    return NoteMapper.ensureInitialized().encodeJson<Note>(this as Note);
  }

  Map<String, dynamic> toMap() {
    return NoteMapper.ensureInitialized().encodeMap<Note>(this as Note);
  }

  NoteCopyWith<Note, Note, Note> get copyWith =>
      _NoteCopyWithImpl(this as Note, $identity, $identity);
  @override
  String toString() {
    return NoteMapper.ensureInitialized().stringifyValue(this as Note);
  }

  @override
  bool operator ==(Object other) {
    return NoteMapper.ensureInitialized().equalsValue(this as Note, other);
  }

  @override
  int get hashCode {
    return NoteMapper.ensureInitialized().hashValue(this as Note);
  }
}

extension NoteValueCopy<$R, $Out> on ObjectCopyWith<$R, Note, $Out> {
  NoteCopyWith<$R, Note, $Out> get $asNote =>
      $base.as((v, t, t2) => _NoteCopyWithImpl(v, t, t2));
}

abstract class NoteCopyWith<$R, $In extends Note, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? content});
  NoteCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _NoteCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Note, $Out>
    implements NoteCopyWith<$R, Note, $Out> {
  _NoteCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Note> $mapper = NoteMapper.ensureInitialized();
  @override
  $R call({String? content}) =>
      $apply(FieldCopyWithData({if (content != null) #content: content}));
  @override
  Note $make(CopyWithData data) =>
      Note(content: data.get(#content, or: $value.content));

  @override
  NoteCopyWith<$R2, Note, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _NoteCopyWithImpl($value, $cast, t);
}
