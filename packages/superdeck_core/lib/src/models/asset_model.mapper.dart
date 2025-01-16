// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_model.dart';

class AssetExtensionMapper extends EnumMapper<AssetExtension> {
  AssetExtensionMapper._();

  static AssetExtensionMapper? _instance;
  static AssetExtensionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetExtensionMapper._());
    }
    return _instance!;
  }

  static AssetExtension fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AssetExtension decode(dynamic value) {
    switch (value) {
      case 'png':
        return AssetExtension.png;
      case 'jpeg':
        return AssetExtension.jpeg;
      case 'gif':
        return AssetExtension.gif;
      case 'webp':
        return AssetExtension.webp;
      case 'svg':
        return AssetExtension.svg;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AssetExtension self) {
    switch (self) {
      case AssetExtension.png:
        return 'png';
      case AssetExtension.jpeg:
        return 'jpeg';
      case AssetExtension.gif:
        return 'gif';
      case AssetExtension.webp:
        return 'webp';
      case AssetExtension.svg:
        return 'svg';
    }
  }
}

extension AssetExtensionMapperExtension on AssetExtension {
  String toValue() {
    AssetExtensionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AssetExtension>(this) as String;
  }
}

class AssetTypeMapper extends EnumMapper<AssetType> {
  AssetTypeMapper._();

  static AssetTypeMapper? _instance;
  static AssetTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetTypeMapper._());
    }
    return _instance!;
  }

  static AssetType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AssetType decode(dynamic value) {
    switch (value) {
      case 'remote':
        return AssetType.remote;
      case 'local':
        return AssetType.local;
      case 'slide_thumbnail':
        return AssetType.slideThumbnail;
      case 'mermaid_image':
        return AssetType.mermaidImage;
      case 'cache_remote_image':
        return AssetType.cacheRemoteImage;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AssetType self) {
    switch (self) {
      case AssetType.remote:
        return 'remote';
      case AssetType.local:
        return 'local';
      case AssetType.slideThumbnail:
        return 'slide_thumbnail';
      case AssetType.mermaidImage:
        return 'mermaid_image';
      case AssetType.cacheRemoteImage:
        return 'cache_remote_image';
    }
  }
}

extension AssetTypeMapperExtension on AssetType {
  String toValue() {
    AssetTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AssetType>(this) as String;
  }
}

class AssetMapper extends ClassMapperBase<Asset> {
  AssetMapper._();

  static AssetMapper? _instance;
  static AssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetMapper._());
      LocalAssetMapper.ensureInitialized();
      AssetTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Asset';

  static String _$src(Asset v) => v.src;
  static const Field<Asset, String> _f$src = Field('src', _$src);
  static AssetType _$type(Asset v) => v.type;
  static const Field<Asset, AssetType> _f$type = Field('type', _$type);

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

class LocalAssetMapper extends SubClassMapperBase<LocalAsset> {
  LocalAssetMapper._();

  static LocalAssetMapper? _instance;
  static LocalAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalAssetMapper._());
      AssetMapper.ensureInitialized().addSubMapper(_instance!);
    }
    return _instance!;
  }

  @override
  final String id = 'LocalAsset';

  static const Field<LocalAsset, String> _f$slideKey =
      Field('slideKey', null, key: 'slide_key', mode: FieldMode.param);
  static String _$src(LocalAsset v) => v.src;
  static const Field<LocalAsset, String> _f$src =
      Field('src', _$src, mode: FieldMode.member);
  static AssetType _$type(LocalAsset v) => v.type;
  static const Field<LocalAsset, AssetType> _f$type =
      Field('type', _$type, mode: FieldMode.member);
  static String _$fileName(LocalAsset v) => v.fileName;
  static const Field<LocalAsset, String> _f$fileName =
      Field('fileName', _$fileName, key: 'file_name', mode: FieldMode.member);
  static AssetExtension _$extension(LocalAsset v) => v.extension;
  static const Field<LocalAsset, AssetExtension> _f$extension =
      Field('extension', _$extension, mode: FieldMode.member);

  @override
  final MappableFields<LocalAsset> fields = const {
    #slideKey: _f$slideKey,
    #src: _f$src,
    #type: _f$type,
    #fileName: _f$fileName,
    #extension: _f$extension,
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
    return LocalAsset.thumbnail(data.dec(_f$slideKey));
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
  String toJson() {
    return LocalAssetMapper.ensureInitialized()
        .encodeJson<LocalAsset>(this as LocalAsset);
  }

  Map<String, dynamic> toMap() {
    return LocalAssetMapper.ensureInitialized()
        .encodeMap<LocalAsset>(this as LocalAsset);
  }

  LocalAssetCopyWith<LocalAsset, LocalAsset, LocalAsset> get copyWith =>
      _LocalAssetCopyWithImpl(this as LocalAsset, $identity, $identity);
  @override
  String toString() {
    return LocalAssetMapper.ensureInitialized()
        .stringifyValue(this as LocalAsset);
  }

  @override
  bool operator ==(Object other) {
    return LocalAssetMapper.ensureInitialized()
        .equalsValue(this as LocalAsset, other);
  }

  @override
  int get hashCode {
    return LocalAssetMapper.ensureInitialized().hashValue(this as LocalAsset);
  }
}

extension LocalAssetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalAsset, $Out> {
  LocalAssetCopyWith<$R, LocalAsset, $Out> get $asLocalAsset =>
      $base.as((v, t, t2) => _LocalAssetCopyWithImpl(v, t, t2));
}

abstract class LocalAssetCopyWith<$R, $In extends LocalAsset, $Out>
    implements AssetCopyWith<$R, $In, $Out> {
  @override
  $R call({required String slideKey});
  LocalAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocalAssetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalAsset, $Out>
    implements LocalAssetCopyWith<$R, LocalAsset, $Out> {
  _LocalAssetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalAsset> $mapper =
      LocalAssetMapper.ensureInitialized();
  @override
  $R call({required String slideKey}) =>
      $apply(FieldCopyWithData({#slideKey: slideKey}));
  @override
  LocalAsset $make(CopyWithData data) =>
      LocalAsset.thumbnail(data.get(#slideKey));

  @override
  LocalAssetCopyWith<$R2, LocalAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _LocalAssetCopyWithImpl($value, $cast, t);
}
