import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:superdeck_cli/src/commands/build_command.dart';
import 'package:superdeck_cli/src/helpers/exceptions.dart';

class SuperDeckRunner extends CommandRunner<int> {
  SuperDeckRunner() : super('superdeck', 'Superdeck CLI');

  @override
  Future<int> run(Iterable<String> args) async {
    addCommand(BuildCommand());

    try {
      final exitCode = await super.run(args);

      return exitCode ?? ExitCode.software.code;
    } on Exception catch (e) {
      printException(e);

      return ExitCode.software.code;
    }
  }
}
