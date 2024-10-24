import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:superdeck_cli/superdeck_cli.dart';

void main(List<String> arguments) async {
  try {
    await SuperdeckRunner().build();
  } on UsageException catch (e) {
    print(e);
    exit(64);
  }
}
