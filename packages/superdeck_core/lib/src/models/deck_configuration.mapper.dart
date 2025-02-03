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
      MapperContainer.globals.useAll([DirectoryMapper(), FileMapper()]);
    }
    return _instance!;
  }

  @override
  final String id = 'DeckConfiguration';

  static Directory _$assetDir(DeckConfiguration v) => v.assetDir;
  static const Field<DeckConfiguration, Directory> _f$assetDir =
      Field('assetDir', _$assetDir, key: 'asset_dir', opt: true);
  static File _$deckFile(DeckConfiguration v) => v.deckFile;
  static const Field<DeckConfiguration, File> _f$deckFile =
      Field('deckFile', _$deckFile, key: 'deck_file', opt: true);
  static Directory _$generatedDir(DeckConfiguration v) => v.generatedDir;
  static const Field<DeckConfiguration, Directory> _f$generatedDir =
      Field('generatedDir', _$generatedDir, key: 'generated_dir', opt: true);
  static File _$markdownFile(DeckConfiguration v) => v.markdownFile;
  static const Field<DeckConfiguration, File> _f$markdownFile =
      Field('markdownFile', _$markdownFile, key: 'markdown_file', opt: true);

  @override
  final MappableFields<DeckConfiguration> fields = const {
    #assetDir: _f$assetDir,
    #deckFile: _f$deckFile,
    #generatedDir: _f$generatedDir,
    #markdownFile: _f$markdownFile,
  };
  @override
  final bool ignoreNull = true;

  static DeckConfiguration _instantiate(DecodingData data) {
    return DeckConfiguration(
        assetDir: data.dec(_f$assetDir),
        deckFile: data.dec(_f$deckFile),
        generatedDir: data.dec(_f$generatedDir),
        markdownFile: data.dec(_f$markdownFile));
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
  $R call(
      {Directory? assetDir,
      File? deckFile,
      Directory? generatedDir,
      File? markdownFile});
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
  $R call(
          {Object? assetDir = $none,
          Object? deckFile = $none,
          Object? generatedDir = $none,
          Object? markdownFile = $none}) =>
      $apply(FieldCopyWithData({
        if (assetDir != $none) #assetDir: assetDir,
        if (deckFile != $none) #deckFile: deckFile,
        if (generatedDir != $none) #generatedDir: generatedDir,
        if (markdownFile != $none) #markdownFile: markdownFile
      }));
  @override
  DeckConfiguration $make(CopyWithData data) => DeckConfiguration(
      assetDir: data.get(#assetDir, or: $value.assetDir),
      deckFile: data.get(#deckFile, or: $value.deckFile),
      generatedDir: data.get(#generatedDir, or: $value.generatedDir),
      markdownFile: data.get(#markdownFile, or: $value.markdownFile));

  @override
  DeckConfigurationCopyWith<$R2, DeckConfiguration, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DeckConfigurationCopyWithImpl($value, $cast, t);
}
