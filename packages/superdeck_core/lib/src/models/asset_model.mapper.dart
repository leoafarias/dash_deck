// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_model.dart';

class LocalAssetExtensionMapper extends EnumMapper<LocalAssetExtension> {
  LocalAssetExtensionMapper._();

  static LocalAssetExtensionMapper? _instance;
  static LocalAssetExtensionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalAssetExtensionMapper._());
    }
    return _instance!;
  }

  static LocalAssetExtension fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  LocalAssetExtension decode(dynamic value) {
    switch (value) {
      case 'png':
        return LocalAssetExtension.png;
      case 'jpeg':
        return LocalAssetExtension.jpeg;
      case 'gif':
        return LocalAssetExtension.gif;
      case 'webp':
        return LocalAssetExtension.webp;
      case 'svg':
        return LocalAssetExtension.svg;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(LocalAssetExtension self) {
    switch (self) {
      case LocalAssetExtension.png:
        return 'png';
      case LocalAssetExtension.jpeg:
        return 'jpeg';
      case LocalAssetExtension.gif:
        return 'gif';
      case LocalAssetExtension.webp:
        return 'webp';
      case LocalAssetExtension.svg:
        return 'svg';
    }
  }
}

extension LocalAssetExtensionMapperExtension on LocalAssetExtension {
  String toValue() {
    LocalAssetExtensionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<LocalAssetExtension>(this) as String;
  }
}

class LocalAssetMapper extends ClassMapperBase<LocalAsset> {
  LocalAssetMapper._();

  static LocalAssetMapper? _instance;
  static LocalAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalAssetMapper._());
      SlideThumbnailAssetMapper.ensureInitialized();
      MermaidAssetMapper.ensureInitialized();
      CacheRemoteAssetMapper.ensureInitialized();
      LocalAssetExtensionMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LocalAsset';

  static String _$fileName(LocalAsset v) => v.fileName;
  static const Field<LocalAsset, String> _f$fileName =
      Field('fileName', _$fileName, key: 'file_name');
  static LocalAssetExtension _$extension(LocalAsset v) => v.extension;
  static const Field<LocalAsset, LocalAssetExtension> _f$extension =
      Field('extension', _$extension);
  static String _$key(LocalAsset v) => v.key;
  static const Field<LocalAsset, String> _f$key = Field('key', _$key);
  static String _$type(LocalAsset v) => v.type;
  static const Field<LocalAsset, String> _f$type = Field('type', _$type);

  @override
  final MappableFields<LocalAsset> fields = const {
    #fileName: _f$fileName,
    #extension: _f$extension,
    #key: _f$key,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

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
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? fileName, LocalAssetExtension? extension, String? key});
  LocalAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SlideThumbnailAssetMapper
    extends SubClassMapperBase<SlideThumbnailAsset> {
  SlideThumbnailAssetMapper._();

  static SlideThumbnailAssetMapper? _instance;
  static SlideThumbnailAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SlideThumbnailAssetMapper._());
      LocalAssetMapper.ensureInitialized().addSubMapper(_instance!);
      LocalAssetExtensionMapper.ensureInitialized();
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
  static LocalAssetExtension _$extension(SlideThumbnailAsset v) => v.extension;
  static const Field<SlideThumbnailAsset, LocalAssetExtension> _f$extension =
      Field('extension', _$extension);
  static String _$type(SlideThumbnailAsset v) => v.type;
  static const Field<SlideThumbnailAsset, String> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<SlideThumbnailAsset> fields = const {
    #key: _f$key,
    #fileName: _f$fileName,
    #extension: _f$extension,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'thumbnail';
  @override
  late final ClassMapperBase superMapper = LocalAssetMapper.ensureInitialized();

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
    $Out> implements LocalAssetCopyWith<$R, $In, $Out> {
  @override
  $R call({String? key, String? fileName, LocalAssetExtension? extension});
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
  $R call({String? key, String? fileName, LocalAssetExtension? extension}) =>
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
      LocalAssetMapper.ensureInitialized().addSubMapper(_instance!);
      LocalAssetExtensionMapper.ensureInitialized();
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
  static LocalAssetExtension _$extension(MermaidAsset v) => v.extension;
  static const Field<MermaidAsset, LocalAssetExtension> _f$extension =
      Field('extension', _$extension);
  static String _$type(MermaidAsset v) => v.type;
  static const Field<MermaidAsset, String> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<MermaidAsset> fields = const {
    #key: _f$key,
    #fileName: _f$fileName,
    #extension: _f$extension,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'mermaid';
  @override
  late final ClassMapperBase superMapper = LocalAssetMapper.ensureInitialized();

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
    implements LocalAssetCopyWith<$R, $In, $Out> {
  @override
  $R call({String? key, String? fileName, LocalAssetExtension? extension});
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
  $R call({String? key, String? fileName, LocalAssetExtension? extension}) =>
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
      LocalAssetMapper.ensureInitialized().addSubMapper(_instance!);
      LocalAssetExtensionMapper.ensureInitialized();
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
  static LocalAssetExtension _$extension(CacheRemoteAsset v) => v.extension;
  static const Field<CacheRemoteAsset, LocalAssetExtension> _f$extension =
      Field('extension', _$extension);
  static String _$type(CacheRemoteAsset v) => v.type;
  static const Field<CacheRemoteAsset, String> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<CacheRemoteAsset> fields = const {
    #key: _f$key,
    #fileName: _f$fileName,
    #extension: _f$extension,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'remote';
  @override
  late final ClassMapperBase superMapper = LocalAssetMapper.ensureInitialized();

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
    implements LocalAssetCopyWith<$R, $In, $Out> {
  @override
  $R call({String? key, String? fileName, LocalAssetExtension? extension});
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
  $R call({String? key, String? fileName, LocalAssetExtension? extension}) =>
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
