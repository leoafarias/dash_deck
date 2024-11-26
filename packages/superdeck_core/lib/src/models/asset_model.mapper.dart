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
    }
    return _instance!;
  }

  @override
  final String id = 'Asset';

  static String _$path(Asset v) => v.path;
  static const Field<Asset, String> _f$path = Field('path', _$path);
  static int _$width(Asset v) => v.width;
  static const Field<Asset, int> _f$width = Field('width', _$width);
  static int _$height(Asset v) => v.height;
  static const Field<Asset, int> _f$height = Field('height', _$height);
  static String? _$reference(Asset v) => v.reference;
  static const Field<Asset, String> _f$reference =
      Field('reference', _$reference);

  @override
  final MappableFields<Asset> fields = const {
    #path: _f$path,
    #width: _f$width,
    #height: _f$height,
    #reference: _f$reference,
  };
  @override
  final bool ignoreNull = true;

  static Asset _instantiate(DecodingData data) {
    return Asset(
        path: data.dec(_f$path),
        width: data.dec(_f$width),
        height: data.dec(_f$height),
        reference: data.dec(_f$reference));
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
  String toJson() {
    return AssetMapper.ensureInitialized().encodeJson<Asset>(this as Asset);
  }

  Map<String, dynamic> toMap() {
    return AssetMapper.ensureInitialized().encodeMap<Asset>(this as Asset);
  }

  AssetCopyWith<Asset, Asset, Asset> get copyWith =>
      _AssetCopyWithImpl(this as Asset, $identity, $identity);
  @override
  String toString() {
    return AssetMapper.ensureInitialized().stringifyValue(this as Asset);
  }

  @override
  bool operator ==(Object other) {
    return AssetMapper.ensureInitialized().equalsValue(this as Asset, other);
  }

  @override
  int get hashCode {
    return AssetMapper.ensureInitialized().hashValue(this as Asset);
  }
}

extension AssetValueCopy<$R, $Out> on ObjectCopyWith<$R, Asset, $Out> {
  AssetCopyWith<$R, Asset, $Out> get $asAsset =>
      $base.as((v, t, t2) => _AssetCopyWithImpl(v, t, t2));
}

abstract class AssetCopyWith<$R, $In extends Asset, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? path, int? width, int? height, String? reference});
  AssetCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AssetCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Asset, $Out>
    implements AssetCopyWith<$R, Asset, $Out> {
  _AssetCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Asset> $mapper = AssetMapper.ensureInitialized();
  @override
  $R call({String? path, int? width, int? height, Object? reference = $none}) =>
      $apply(FieldCopyWithData({
        if (path != null) #path: path,
        if (width != null) #width: width,
        if (height != null) #height: height,
        if (reference != $none) #reference: reference
      }));
  @override
  Asset $make(CopyWithData data) => Asset(
      path: data.get(#path, or: $value.path),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      reference: data.get(#reference, or: $value.reference));

  @override
  AssetCopyWith<$R2, Asset, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AssetCopyWithImpl($value, $cast, t);
}
