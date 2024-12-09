import 'dart:io';

import 'package:path/path.dart';

final kMarkdownFile = File('slides.md');

final kAssetsDir = Directory(join('.superdeck'));
final kAssetsJsonPath = join(kAssetsDir.path, 'assets.json');

final kGeneratedAssetsDir = Directory(join(kAssetsDir.path, 'generated'));
final kProjectConfigFile = File('superdeck.yaml');
final kPubpsecFile = File('pubspec.yaml');

// final kReferenceFile = File(join(kAssetsDir.path, 'slides.json'));
// final kReferenceFileYaml = File(join(kAssetsDir.path, 'slides.yaml'));
// final kReferenceMarkdownCopy = File(join(kAssetsDir.path, 'slides_copy.md'));
