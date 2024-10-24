import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:superdeck_cli/src/runner.dart';

void main(List<String> arguments) async {
  try {
    await SuperdeckRunner().watch();
  } on UsageException catch (e) {
    print(e);
    exit(64);
  }
}
