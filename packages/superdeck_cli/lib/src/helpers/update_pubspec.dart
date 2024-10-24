import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

/// Updates the provided YAML content to include .superdeck/ and .superdeck/generated/ assets.
/// Returns the updated YAML content as a string.
String updatePubspecAssets(String yamlContent) {
  final parsedYaml = loadYaml(yamlContent);

  // Ensure the flutter: key exists
  final flutterSection =
      {...(parsedYaml['flutter'] ?? {}) as Map}.cast<String, dynamic>();
  // Get the existing assets or create a new list if it doesn't exist
  final assets = flutterSection['assets']?.toList() ?? [];

  // Add the new asset paths if they don't exist
  if (!assets.contains('.superdeck/')) {
    assets.add('.superdeck/');
  }
  if (!assets.contains('.superdeck/generated/')) {
    assets.add('.superdeck/generated/');
  }

  // Update the flutter section with the new assets list
  flutterSection['assets'] = assets;

  // Convert the updated map back to YAML
  final updatedYaml = Map<String, dynamic>.from(parsedYaml)
    ..['flutter'] = flutterSection;

  return YamlWriter(allowUnquotedStrings: true).write(updatedYaml);
}
