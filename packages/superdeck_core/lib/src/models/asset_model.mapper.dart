// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_model.dart';

class AssetMapper extends ClassMapperBase<Asset> {
  AssetMapper._();

  static AssetMapper? _instance;
  static AssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetMapper._());
      RemoteAssetMapper.ensureInitialized();
      LocalAssetMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Asset';

  static String _$src(Asset v) => v.src;
  static const Field<Asset, String> _f$src = Field('src', _$src);
  static String _$type(Asset v) => v.type;
  static const Field<Asset, String> _f$type = Field('type', _$type);

  @override
  final MappableFields<Asset> fields = const {
    #src: _f$src,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  static Asset _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'Asset', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static Asset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Asset>(map);
  }

  static Asset fromJson(String json) {
    return ensureInitialized().decodeJson<Asset>(json);
  }
}

mixin AssetMappable {
  String toJson();
  Map<String, dynamic> toMap();
  AssetCopyWith<Asset, Asset, Asset> get copyWith;
}

abstract class AssetCopyWith<$R, $In extends Asset, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  AssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class RemoteAssetMapper extends SubClassMapperBase<RemoteAsset> {
  RemoteAssetMapper._();

  static RemoteAssetMapper? _instance;
  static RemoteAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RemoteAssetMapper._());
      AssetMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'RemoteAsset';

  static String _$src(RemoteAsset v) => v.src;
  static const Field<RemoteAsset, String> _f$src = Field('src', _$src);
  static String _$type(RemoteAsset v) => v.type;
  static const Field<RemoteAsset, String> _f$type = Field('type', _$type);

  @override
  final MappableFields<RemoteAsset> fields = const {
    #src: _f$src,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'remote';
  @override
  late final ClassMapperBase superMapper = AssetMapper.ensureInitialized();

  static RemoteAsset _instantiate(DecodingData data) {
    return RemoteAsset(src: data.dec(_f$src), type: data.dec(_f$type));
  }

  @override
  final Function instantiate = _instantiate;

  static RemoteAsset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<RemoteAsset>(map);
  }

  static RemoteAsset fromJson(String json) {
    return ensureInitialized().decodeJson<RemoteAsset>(json);
  }
}

mixin RemoteAssetMappable {
  String toJson() {
    return RemoteAssetMapper.ensureInitialized()
        .encodeJson<RemoteAsset>(this as RemoteAsset);
  }

  Map<String, dynamic> toMap() {
    return RemoteAssetMapper.ensureInitialized()
        .encodeMap<RemoteAsset>(this as RemoteAsset);
  }

  RemoteAssetCopyWith<RemoteAsset, RemoteAsset, RemoteAsset> get copyWith =>
      _RemoteAssetCopyWithImpl(this as RemoteAsset, $identity, $identity);
  @override
  String toString() {
    return RemoteAssetMapper.ensureInitialized()
        .stringifyValue(this as RemoteAsset);
  }

  @override
  bool operator ==(Object other) {
    return RemoteAssetMapper.ensureInitialized()
        .equalsValue(this as RemoteAsset, other);
  }

  @override
  int get hashCode {
    return RemoteAssetMapper.ensureInitialized().hashValue(this as RemoteAsset);
  }
}

extension RemoteAssetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, RemoteAsset, $Out> {
  RemoteAssetCopyWith<$R, RemoteAsset, $Out> get $asRemoteAsset =>
      $base.as((v, t, t2) => _RemoteAssetCopyWithImpl(v, t, t2));
}

abstract class RemoteAssetCopyWith<$R, $In extends RemoteAsset, $Out>
    implements AssetCopyWith<$R, $In, $Out> {
  @override
  $R call({String? src, String? type});
  RemoteAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _RemoteAssetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, RemoteAsset, $Out>
    implements RemoteAssetCopyWith<$R, RemoteAsset, $Out> {
  _RemoteAssetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<RemoteAsset> $mapper =
      RemoteAssetMapper.ensureInitialized();
  @override
  $R call({String? src, String? type}) => $apply(FieldCopyWithData(
      {if (src != null) #src: src, if (type != null) #type: type}));
  @override
  RemoteAsset $make(CopyWithData data) => RemoteAsset(
      src: data.get(#src, or: $value.src),
      type: data.get(#type, or: $value.type));

  @override
  RemoteAssetCopyWith<$R2, RemoteAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _RemoteAssetCopyWithImpl($value, $cast, t);
}

class LocalAssetMapper extends SubClassMapperBase<LocalAsset> {
  LocalAssetMapper._();

  static LocalAssetMapper? _instance;
  static LocalAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalAssetMapper._());
      AssetMapper.ensureInitialized().addSubMapper(_instance!);
      GeneratedAssetMapper.ensureInitialized();
      AssetExtensionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalAsset';

  static String _$fileName(LocalAsset v) => v.fileName;
  static const Field<LocalAsset, String> _f$fileName =
      Field('fileName', _$fileName, key: 'file_name');
  static AssetExtension _$extension(LocalAsset v) => v.extension;
  static const Field<LocalAsset, AssetExtension> _f$extension =
      Field('extension', _$extension);
  static String _$type(LocalAsset v) => v.type;
  static const Field<LocalAsset, String> _f$type = Field('type', _$type);
  static String _$src(LocalAsset v) => v.src;
  static const Field<LocalAsset, String> _f$src =
      Field('src', _$src, mode: FieldMode.member);

  @override
  final MappableFields<LocalAsset> fields = const {
    #fileName: _f$fileName,
    #extension: _f$extension,
    #type: _f$type,
    #src: _f$src,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'LocalAsset';
  @override
  late final ClassMapperBase superMapper = AssetMapper.ensureInitialized();

  static LocalAsset _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'LocalAsset', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static LocalAsset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalAsset>(map);
  }

  static LocalAsset fromJson(String json) {
    return ensureInitialized().decodeJson<LocalAsset>(json);
  }
}

mixin LocalAssetMappable {
  String toJson();
  Map<String, dynamic> toMap();
  LocalAssetCopyWith<LocalAsset, LocalAsset, LocalAsset> get copyWith;
}

abstract class LocalAssetCopyWith<$R, $In extends LocalAsset, $Out>
    implements AssetCopyWith<$R, $In, $Out> {
  @override
  $R call({String? fileName, AssetExtension? extension});
  LocalAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class GeneratedAssetMapper extends SubClassMapperBase<GeneratedAsset> {
  GeneratedAssetMapper._();

  static GeneratedAssetMapper? _instance;
  static GeneratedAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GeneratedAssetMapper._());
      LocalAssetMapper.ensureInitialized().addSubMapper(_instance!);
      SlideThumbnailAssetMapper.ensureInitialized();
      MermaidAssetMapper.ensureInitialized();
      CacheRemoteAssetMapper.ensureInitialized();
      AssetExtensionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'GeneratedAsset';

  static String _$key(GeneratedAsset v) => v.key;
  static const Field<GeneratedAsset, String> _f$key = Field('key', _$key);
  static String _$fileName(GeneratedAsset v) => v.fileName;
  static const Field<GeneratedAsset, String> _f$fileName =
      Field('fileName', _$fileName, key: 'file_name');
  static AssetExtension _$extension(GeneratedAsset v) => v.extension;
  static const Field<GeneratedAsset, AssetExtension> _f$extension =
      Field('extension', _$extension);
  static String _$type(GeneratedAsset v) => v.type;
  static const Field<GeneratedAsset, String> _f$type = Field('type', _$type);
  static String _$src(GeneratedAsset v) => v.src;
  static const Field<GeneratedAsset, String> _f$src =
      Field('src', _$src, mode: FieldMode.member);

  @override
  final MappableFields<GeneratedAsset> fields = const {
    #key: _f$key,
    #fileName: _f$fileName,
    #extension: _f$extension,
    #type: _f$type,
    #src: _f$src,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'GeneratedAsset';
  @override
  late final ClassMapperBase superMapper = LocalAssetMapper.ensureInitialized();

  static GeneratedAsset _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
        'GeneratedAsset', 'type', '${data.value['type']}');
  }

  @override
  final Function instantiate = _instantiate;

  static GeneratedAsset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<GeneratedAsset>(map);
  }

  static GeneratedAsset fromJson(String json) {
    return ensureInitialized().decodeJson<GeneratedAsset>(json);
  }
}

mixin GeneratedAssetMappable {
  String toJson();
  Map<String, dynamic> toMap();
  GeneratedAssetCopyWith<GeneratedAsset, GeneratedAsset, GeneratedAsset>
      get copyWith;
}

abstract class GeneratedAssetCopyWith<$R, $In extends GeneratedAsset, $Out>
    implements LocalAssetCopyWith<$R, $In, $Out> {
  @override
  $R call({String? key, String? fileName, AssetExtension? extension});
  GeneratedAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class SlideThumbnailAssetMapper
    extends SubClassMapperBase<SlideThumbnailAsset> {
  SlideThumbnailAssetMapper._();

  static SlideThumbnailAssetMapper? _instance;
  static SlideThumbnailAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideThumbnailAssetMapper._());
      GeneratedAssetMapper.ensureInitialized().addSubMapper(_instance!);
      AssetExtensionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SlideThumbnailAsset';

  static String _$key(SlideThumbnailAsset v) => v.key;
  static const Field<SlideThumbnailAsset, String> _f$key = Field('key', _$key);
  static String _$fileName(SlideThumbnailAsset v) => v.fileName;
  static const Field<SlideThumbnailAsset, String> _f$fileName =
      Field('fileName', _$fileName, key: 'file_name');
  static AssetExtension _$extension(SlideThumbnailAsset v) => v.extension;
  static const Field<SlideThumbnailAsset, AssetExtension> _f$extension =
      Field('extension', _$extension);
  static String _$src(SlideThumbnailAsset v) => v.src;
  static const Field<SlideThumbnailAsset, String> _f$src =
      Field('src', _$src, mode: FieldMode.member);
  static String _$type(SlideThumbnailAsset v) => v.type;
  static const Field<SlideThumbnailAsset, String> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<SlideThumbnailAsset> fields = const {
    #key: _f$key,
    #fileName: _f$fileName,
    #extension: _f$extension,
    #src: _f$src,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'thumbnail';
  @override
  late final ClassMapperBase superMapper =
      GeneratedAssetMapper.ensureInitialized();

  static SlideThumbnailAsset _instantiate(DecodingData data) {
    return SlideThumbnailAsset(
        key: data.dec(_f$key),
        fileName: data.dec(_f$fileName),
        extension: data.dec(_f$extension));
  }

  @override
  final Function instantiate = _instantiate;

  static SlideThumbnailAsset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SlideThumbnailAsset>(map);
  }

  static SlideThumbnailAsset fromJson(String json) {
    return ensureInitialized().decodeJson<SlideThumbnailAsset>(json);
  }
}

mixin SlideThumbnailAssetMappable {
  String toJson() {
    return SlideThumbnailAssetMapper.ensureInitialized()
        .encodeJson<SlideThumbnailAsset>(this as SlideThumbnailAsset);
  }

  Map<String, dynamic> toMap() {
    return SlideThumbnailAssetMapper.ensureInitialized()
        .encodeMap<SlideThumbnailAsset>(this as SlideThumbnailAsset);
  }

  SlideThumbnailAssetCopyWith<SlideThumbnailAsset, SlideThumbnailAsset,
          SlideThumbnailAsset>
      get copyWith => _SlideThumbnailAssetCopyWithImpl(
          this as SlideThumbnailAsset, $identity, $identity);
  @override
  String toString() {
    return SlideThumbnailAssetMapper.ensureInitialized()
        .stringifyValue(this as SlideThumbnailAsset);
  }

  @override
  bool operator ==(Object other) {
    return SlideThumbnailAssetMapper.ensureInitialized()
        .equalsValue(this as SlideThumbnailAsset, other);
  }

  @override
  int get hashCode {
    return SlideThumbnailAssetMapper.ensureInitialized()
        .hashValue(this as SlideThumbnailAsset);
  }
}

extension SlideThumbnailAssetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SlideThumbnailAsset, $Out> {
  SlideThumbnailAssetCopyWith<$R, SlideThumbnailAsset, $Out>
      get $asSlideThumbnailAsset =>
          $base.as((v, t, t2) => _SlideThumbnailAssetCopyWithImpl(v, t, t2));
}

abstract class SlideThumbnailAssetCopyWith<$R, $In extends SlideThumbnailAsset,
    $Out> implements GeneratedAssetCopyWith<$R, $In, $Out> {
  @override
  $R call({String? key, String? fileName, AssetExtension? extension});
  SlideThumbnailAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SlideThumbnailAssetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SlideThumbnailAsset, $Out>
    implements SlideThumbnailAssetCopyWith<$R, SlideThumbnailAsset, $Out> {
  _SlideThumbnailAssetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SlideThumbnailAsset> $mapper =
      SlideThumbnailAssetMapper.ensureInitialized();
  @override
  $R call({String? key, String? fileName, AssetExtension? extension}) =>
      $apply(FieldCopyWithData({
        if (key != null) #key: key,
        if (fileName != null) #fileName: fileName,
        if (extension != null) #extension: extension
      }));
  @override
  SlideThumbnailAsset $make(CopyWithData data) => SlideThumbnailAsset(
      key: data.get(#key, or: $value.key),
      fileName: data.get(#fileName, or: $value.fileName),
      extension: data.get(#extension, or: $value.extension));

  @override
  SlideThumbnailAssetCopyWith<$R2, SlideThumbnailAsset, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _SlideThumbnailAssetCopyWithImpl($value, $cast, t);
}

class MermaidAssetMapper extends SubClassMapperBase<MermaidAsset> {
  MermaidAssetMapper._();

  static MermaidAssetMapper? _instance;
  static MermaidAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MermaidAssetMapper._());
      GeneratedAssetMapper.ensureInitialized().addSubMapper(_instance!);
      AssetExtensionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MermaidAsset';

  static String _$key(MermaidAsset v) => v.key;
  static const Field<MermaidAsset, String> _f$key = Field('key', _$key);
  static String _$fileName(MermaidAsset v) => v.fileName;
  static const Field<MermaidAsset, String> _f$fileName =
      Field('fileName', _$fileName, key: 'file_name');
  static AssetExtension _$extension(MermaidAsset v) => v.extension;
  static const Field<MermaidAsset, AssetExtension> _f$extension =
      Field('extension', _$extension);
  static String _$src(MermaidAsset v) => v.src;
  static const Field<MermaidAsset, String> _f$src =
      Field('src', _$src, mode: FieldMode.member);
  static String _$type(MermaidAsset v) => v.type;
  static const Field<MermaidAsset, String> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<MermaidAsset> fields = const {
    #key: _f$key,
    #fileName: _f$fileName,
    #extension: _f$extension,
    #src: _f$src,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'mermaid';
  @override
  late final ClassMapperBase superMapper =
      GeneratedAssetMapper.ensureInitialized();

  static MermaidAsset _instantiate(DecodingData data) {
    return MermaidAsset(
        key: data.dec(_f$key),
        fileName: data.dec(_f$fileName),
        extension: data.dec(_f$extension));
  }

  @override
  final Function instantiate = _instantiate;

  static MermaidAsset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MermaidAsset>(map);
  }

  static MermaidAsset fromJson(String json) {
    return ensureInitialized().decodeJson<MermaidAsset>(json);
  }
}

mixin MermaidAssetMappable {
  String toJson() {
    return MermaidAssetMapper.ensureInitialized()
        .encodeJson<MermaidAsset>(this as MermaidAsset);
  }

  Map<String, dynamic> toMap() {
    return MermaidAssetMapper.ensureInitialized()
        .encodeMap<MermaidAsset>(this as MermaidAsset);
  }

  MermaidAssetCopyWith<MermaidAsset, MermaidAsset, MermaidAsset> get copyWith =>
      _MermaidAssetCopyWithImpl(this as MermaidAsset, $identity, $identity);
  @override
  String toString() {
    return MermaidAssetMapper.ensureInitialized()
        .stringifyValue(this as MermaidAsset);
  }

  @override
  bool operator ==(Object other) {
    return MermaidAssetMapper.ensureInitialized()
        .equalsValue(this as MermaidAsset, other);
  }

  @override
  int get hashCode {
    return MermaidAssetMapper.ensureInitialized()
        .hashValue(this as MermaidAsset);
  }
}

extension MermaidAssetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MermaidAsset, $Out> {
  MermaidAssetCopyWith<$R, MermaidAsset, $Out> get $asMermaidAsset =>
      $base.as((v, t, t2) => _MermaidAssetCopyWithImpl(v, t, t2));
}

abstract class MermaidAssetCopyWith<$R, $In extends MermaidAsset, $Out>
    implements GeneratedAssetCopyWith<$R, $In, $Out> {
  @override
  $R call({String? key, String? fileName, AssetExtension? extension});
  MermaidAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MermaidAssetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MermaidAsset, $Out>
    implements MermaidAssetCopyWith<$R, MermaidAsset, $Out> {
  _MermaidAssetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MermaidAsset> $mapper =
      MermaidAssetMapper.ensureInitialized();
  @override
  $R call({String? key, String? fileName, AssetExtension? extension}) =>
      $apply(FieldCopyWithData({
        if (key != null) #key: key,
        if (fileName != null) #fileName: fileName,
        if (extension != null) #extension: extension
      }));
  @override
  MermaidAsset $make(CopyWithData data) => MermaidAsset(
      key: data.get(#key, or: $value.key),
      fileName: data.get(#fileName, or: $value.fileName),
      extension: data.get(#extension, or: $value.extension));

  @override
  MermaidAssetCopyWith<$R2, MermaidAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MermaidAssetCopyWithImpl($value, $cast, t);
}

class CacheRemoteAssetMapper extends SubClassMapperBase<CacheRemoteAsset> {
  CacheRemoteAssetMapper._();

  static CacheRemoteAssetMapper? _instance;
  static CacheRemoteAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CacheRemoteAssetMapper._());
      GeneratedAssetMapper.ensureInitialized().addSubMapper(_instance!);
      AssetExtensionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CacheRemoteAsset';

  static String _$key(CacheRemoteAsset v) => v.key;
  static const Field<CacheRemoteAsset, String> _f$key = Field('key', _$key);
  static String _$fileName(CacheRemoteAsset v) => v.fileName;
  static const Field<CacheRemoteAsset, String> _f$fileName =
      Field('fileName', _$fileName, key: 'file_name');
  static AssetExtension _$extension(CacheRemoteAsset v) => v.extension;
  static const Field<CacheRemoteAsset, AssetExtension> _f$extension =
      Field('extension', _$extension);
  static String _$src(CacheRemoteAsset v) => v.src;
  static const Field<CacheRemoteAsset, String> _f$src =
      Field('src', _$src, mode: FieldMode.member);
  static String _$type(CacheRemoteAsset v) => v.type;
  static const Field<CacheRemoteAsset, String> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<CacheRemoteAsset> fields = const {
    #key: _f$key,
    #fileName: _f$fileName,
    #extension: _f$extension,
    #src: _f$src,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'cache_remote';
  @override
  late final ClassMapperBase superMapper =
      GeneratedAssetMapper.ensureInitialized();

  static CacheRemoteAsset _instantiate(DecodingData data) {
    return CacheRemoteAsset(
        key: data.dec(_f$key),
        fileName: data.dec(_f$fileName),
        extension: data.dec(_f$extension));
  }

  @override
  final Function instantiate = _instantiate;

  static CacheRemoteAsset fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CacheRemoteAsset>(map);
  }

  static CacheRemoteAsset fromJson(String json) {
    return ensureInitialized().decodeJson<CacheRemoteAsset>(json);
  }
}

mixin CacheRemoteAssetMappable {
  String toJson() {
    return CacheRemoteAssetMapper.ensureInitialized()
        .encodeJson<CacheRemoteAsset>(this as CacheRemoteAsset);
  }

  Map<String, dynamic> toMap() {
    return CacheRemoteAssetMapper.ensureInitialized()
        .encodeMap<CacheRemoteAsset>(this as CacheRemoteAsset);
  }

  CacheRemoteAssetCopyWith<CacheRemoteAsset, CacheRemoteAsset, CacheRemoteAsset>
      get copyWith => _CacheRemoteAssetCopyWithImpl(
          this as CacheRemoteAsset, $identity, $identity);
  @override
  String toString() {
    return CacheRemoteAssetMapper.ensureInitialized()
        .stringifyValue(this as CacheRemoteAsset);
  }

  @override
  bool operator ==(Object other) {
    return CacheRemoteAssetMapper.ensureInitialized()
        .equalsValue(this as CacheRemoteAsset, other);
  }

  @override
  int get hashCode {
    return CacheRemoteAssetMapper.ensureInitialized()
        .hashValue(this as CacheRemoteAsset);
  }
}

extension CacheRemoteAssetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CacheRemoteAsset, $Out> {
  CacheRemoteAssetCopyWith<$R, CacheRemoteAsset, $Out>
      get $asCacheRemoteAsset =>
          $base.as((v, t, t2) => _CacheRemoteAssetCopyWithImpl(v, t, t2));
}

abstract class CacheRemoteAssetCopyWith<$R, $In extends CacheRemoteAsset, $Out>
    implements GeneratedAssetCopyWith<$R, $In, $Out> {
  @override
  $R call({String? key, String? fileName, AssetExtension? extension});
  CacheRemoteAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CacheRemoteAssetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CacheRemoteAsset, $Out>
    implements CacheRemoteAssetCopyWith<$R, CacheRemoteAsset, $Out> {
  _CacheRemoteAssetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CacheRemoteAsset> $mapper =
      CacheRemoteAssetMapper.ensureInitialized();
  @override
  $R call({String? key, String? fileName, AssetExtension? extension}) =>
      $apply(FieldCopyWithData({
        if (key != null) #key: key,
        if (fileName != null) #fileName: fileName,
        if (extension != null) #extension: extension
      }));
  @override
  CacheRemoteAsset $make(CopyWithData data) => CacheRemoteAsset(
      key: data.get(#key, or: $value.key),
      fileName: data.get(#fileName, or: $value.fileName),
      extension: data.get(#extension, or: $value.extension));

  @override
  CacheRemoteAssetCopyWith<$R2, CacheRemoteAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CacheRemoteAssetCopyWithImpl($value, $cast, t);
}
