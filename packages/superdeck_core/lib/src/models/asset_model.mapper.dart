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
      case 'image':
        return AssetType.image;
      case 'thumnail':
        return AssetType.thumnail;
      case 'mermaid':
        return AssetType.mermaid;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AssetType self) {
    switch (self) {
      case AssetType.image:
        return 'image';
      case AssetType.thumnail:
        return 'thumnail';
      case AssetType.mermaid:
        return 'mermaid';
    }
  }
}

extension AssetTypeMapperExtension on AssetType {
  String toValue() {
    AssetTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AssetType>(this) as String;
  }
}

class GeneratedAssetMapper extends ClassMapperBase<GeneratedAsset> {
  GeneratedAssetMapper._();

  static GeneratedAssetMapper? _instance;
  static GeneratedAssetMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GeneratedAssetMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'GeneratedAsset';

  static const Field<GeneratedAsset, String> _f$slideKey =
      Field('slideKey', null, key: 'slide_key', mode: FieldMode.param);
  static String _$fileName(GeneratedAsset v) => v.fileName;
  static const Field<GeneratedAsset, String> _f$fileName =
      Field('fileName', _$fileName, key: 'file_name', mode: FieldMode.member);
  static AssetExtension _$extension(GeneratedAsset v) => v.extension;
  static const Field<GeneratedAsset, AssetExtension> _f$extension =
      Field('extension', _$extension, mode: FieldMode.member);
  static AssetType _$type(GeneratedAsset v) => v.type;
  static const Field<GeneratedAsset, AssetType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<GeneratedAsset> fields = const {
    #slideKey: _f$slideKey,
    #fileName: _f$fileName,
    #extension: _f$extension,
    #type: _f$type,
  };
  @override
  final bool ignoreNull = true;

  static GeneratedAsset _instantiate(DecodingData data) {
    return GeneratedAsset.thumbnail(data.dec(_f$slideKey));
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
  String toJson() {
    return GeneratedAssetMapper.ensureInitialized()
        .encodeJson<GeneratedAsset>(this as GeneratedAsset);
  }

  Map<String, dynamic> toMap() {
    return GeneratedAssetMapper.ensureInitialized()
        .encodeMap<GeneratedAsset>(this as GeneratedAsset);
  }

  GeneratedAssetCopyWith<GeneratedAsset, GeneratedAsset, GeneratedAsset>
      get copyWith => _GeneratedAssetCopyWithImpl(
          this as GeneratedAsset, $identity, $identity);
  @override
  String toString() {
    return GeneratedAssetMapper.ensureInitialized()
        .stringifyValue(this as GeneratedAsset);
  }

  @override
  bool operator ==(Object other) {
    return GeneratedAssetMapper.ensureInitialized()
        .equalsValue(this as GeneratedAsset, other);
  }

  @override
  int get hashCode {
    return GeneratedAssetMapper.ensureInitialized()
        .hashValue(this as GeneratedAsset);
  }
}

extension GeneratedAssetValueCopy<$R, $Out>
    on ObjectCopyWith<$R, GeneratedAsset, $Out> {
  GeneratedAssetCopyWith<$R, GeneratedAsset, $Out> get $asGeneratedAsset =>
      $base.as((v, t, t2) => _GeneratedAssetCopyWithImpl(v, t, t2));
}

abstract class GeneratedAssetCopyWith<$R, $In extends GeneratedAsset, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({required String slideKey});
  GeneratedAssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _GeneratedAssetCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, GeneratedAsset, $Out>
    implements GeneratedAssetCopyWith<$R, GeneratedAsset, $Out> {
  _GeneratedAssetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<GeneratedAsset> $mapper =
      GeneratedAssetMapper.ensureInitialized();
  @override
  $R call({required String slideKey}) =>
      $apply(FieldCopyWithData({#slideKey: slideKey}));
  @override
  GeneratedAsset $make(CopyWithData data) =>
      GeneratedAsset.thumbnail(data.get(#slideKey));

  @override
  GeneratedAssetCopyWith<$R2, GeneratedAsset, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _GeneratedAssetCopyWithImpl($value, $cast, t);
}
