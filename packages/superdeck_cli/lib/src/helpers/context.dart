import 'package:scope/scope.dart';

final contextKey = ScopeKey<SDCliContext>();

SDCliContext get ctx => use(contextKey, withDefault: () => SDCliContext());

class SDCliContext {
  const SDCliContext();
}
