import 'dart:convert';

import 'package:yaml/yaml.dart';

Map<String, dynamic> convertYamlToMap(String yamlString) {
  if (yamlString.trim().isEmpty) return {};
  final yamlMap = loadYaml(yamlString, recover: true);

  if (yamlMap is YamlMap) {
    return jsonDecode(jsonEncode(yamlMap));
  } else {
    throw FormatException(
      'Invalid YAML format. $yamlString',
    );
  }
}
