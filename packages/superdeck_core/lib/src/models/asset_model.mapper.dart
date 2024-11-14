// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_model.dart';

class AssetModelMapper extends ClassMapperBase<AssetModel> {
  AssetModelMapper._();

  static AssetModelMapper? _instance;
  static AssetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AssetModel';

  static String _$path(AssetModel v) => v.path;
  static const Field<AssetModel, String> _f$path = Field('path', _$path);
  static int _$width(AssetModel v) => v.width;
  static const Field<AssetModel, int> _f$width = Field('width', _$width);
  static int _$height(AssetModel v) => v.height;
  static const Field<AssetModel, int> _f$height = Field('height', _$height);
  static String? _$reference(AssetModel v) => v.reference;
  static const Field<AssetModel, String> _f$reference =
      Field('reference', _$reference);

  @override
  final MappableFields<AssetModel> fields = const {
    #path: _f$path,
    #width: _f$width,
    #height: _f$height,
    #reference: _f$reference,
  };
  @override
  final bool ignoreNull = true;

  static AssetModel _instantiate(DecodingData data) {
    return AssetModel(
        path: data.dec(_f$path),
        width: data.dec(_f$width),
        height: data.dec(_f$height),
        reference: data.dec(_f$reference));
  }

  @override
  final Function instantiate = _instantiate;

  static AssetModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssetModel>(map);
  }

  static AssetModel fromJson(String json) {
    return ensureInitialized().decodeJson<AssetModel>(json);
  }
}

mixin AssetModelMappable {
  String toJson() {
    return AssetModelMapper.ensureInitialized()
        .encodeJson<AssetModel>(this as AssetModel);
  }

  Map<String, dynamic> toMap() {
    return AssetModelMapper.ensureInitialized()
        .encodeMap<AssetModel>(this as AssetModel);
  }

  AssetModelCopyWith<AssetModel, AssetModel, AssetModel> get copyWith =>
      _AssetModelCopyWithImpl(this as AssetModel, $identity, $identity);
  @override
  String toString() {
    return AssetModelMapper.ensureInitialized()
        .stringifyValue(this as AssetModel);
  }

  @override
  bool operator ==(Object other) {
    return AssetModelMapper.ensureInitialized()
        .equalsValue(this as AssetModel, other);
  }

  @override
  int get hashCode {
    return AssetModelMapper.ensureInitialized().hashValue(this as AssetModel);
  }
}

extension AssetModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssetModel, $Out> {
  AssetModelCopyWith<$R, AssetModel, $Out> get $asAssetModel =>
      $base.as((v, t, t2) => _AssetModelCopyWithImpl(v, t, t2));
}

abstract class AssetModelCopyWith<$R, $In extends AssetModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? path, int? width, int? height, String? reference});
  AssetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AssetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssetModel, $Out>
    implements AssetModelCopyWith<$R, AssetModel, $Out> {
  _AssetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssetModel> $mapper =
      AssetModelMapper.ensureInitialized();
  @override
  $R call({String? path, int? width, int? height, Object? reference = $none}) =>
      $apply(FieldCopyWithData({
        if (path != null) #path: path,
        if (width != null) #width: width,
        if (height != null) #height: height,
        if (reference != $none) #reference: reference
      }));
  @override
  AssetModel $make(CopyWithData data) => AssetModel(
      path: data.get(#path, or: $value.path),
      width: data.get(#width, or: $value.width),
      height: data.get(#height, or: $value.height),
      reference: data.get(#reference, or: $value.reference));

  @override
  AssetModelCopyWith<$R2, AssetModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AssetModelCopyWithImpl($value, $cast, t);
}
