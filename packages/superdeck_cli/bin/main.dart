#!/usr/bin/env dart

import 'dart:io';

import 'package:scope/scope.dart';
import 'package:superdeck_cli/src/helpers/context.dart';
import 'package:superdeck_cli/src/runner.dart';

Future<void> main(List<String> args) async {
  final scope = Scope()..value(contextKey, SDCliContext());

  await _flushThenExit(
    await scope.run(() async => SuperDeckRunner().run((args))),
  );
}

/// Flushes the stdout and stderr streams, then exits the program with the given
/// status code.
///
/// This returns a Future that will never complete, since the program will have
/// exited already. This is useful to prevent Future chains from proceeding
/// after you've decided to exit.
Future<void> _flushThenExit(int status) {
  return Future.wait<void>([stdout.close(), stderr.close()]).then(
    (_) => exit(status),
  );
}
