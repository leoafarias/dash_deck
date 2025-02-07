import 'package:flutter/services.dart';
import 'package:superdeck_core/superdeck_core.dart';

class AssetBundleDataStore extends LocalDataStore {
  AssetBundleDataStore(super.configuration);

  @override
  Future<String> fileReader(String path) async => rootBundle.loadString(path);
}
