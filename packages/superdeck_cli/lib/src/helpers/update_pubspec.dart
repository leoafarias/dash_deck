import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

/// Updates the 'assets' section of a pubspec.yaml file with superdeck paths.
///
/// This function takes a [yamlContent] string representing the contents of a
/// pubspec.yaml file. It parses the YAML, adds the '.superdeck/' and
/// '.superdeck/generated/' paths to the 'assets' section under the 'flutter'
/// key if they don't already exist, and returns the updated YAML as a string.
///
/// Returns the updated pubspec YAML content as a string.
String updatePubspecAssets(String yamlContent) {
  // Parse the YAML content into a map
  final parsedYaml = loadYaml(yamlContent);

  // Get the 'flutter' section from the parsed YAML, or an empty map if it doesn't exist
  final flutterSection =
      // ignore: avoid-dynamic
      {...(parsedYaml['flutter'] ?? {}) as Map}.cast<String, dynamic>();

  // Get the 'assets' list from the 'flutter' section, or an empty list if it doesn't exist
  final assets = flutterSection['assets']?.toList() ?? [];

  // Add the '.superdeck/' path to the assets list if it's not already present
  if (!assets.contains('.superdeck/')) {
    assets.add('.superdeck/');
  }

  // Add the '.superdeck/generated/' path to the assets list if it's not already present
  if (!assets.contains('.superdeck/generated/')) {
    assets.add('.superdeck/generated/');
  }

  // Update the 'assets' key in the 'flutter' section with the modified assets list
  flutterSection['assets'] = assets;

  // Create a new map from the parsed YAML and update the 'flutter' key with the modified section
  final updatedYaml = Map<String, dynamic>.from(parsedYaml)
    ..['flutter'] = flutterSection;

  // Convert the updated YAML map back to a string and return it
  return YamlWriter(allowUnquotedStrings: true).write(updatedYaml);
}
