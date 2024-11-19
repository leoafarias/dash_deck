import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

T useProvider<T>() {
  final context = useContext();

  return Provider.of<T>(context);
}

T _useController<T extends Controller>() {
  final controller = useProvider<T>();
  return useListenable(controller);
}

abstract class UseController<T extends Controller> {
  UseController();

  T call() => useProvider<T>();
  T watch() => _useController<T>();
  R select<R>(R Function(T) selector) => useControllerSelect(selector);
}

Return useControllerSelect<T extends Controller, Return>(
    Return Function(T) selector) {
  final controller = useProvider<T>();
  return useListenableSelector(controller, () => selector(controller));
}

Return useProviderSelect<Param, Return>(Return Function(Param) selector) {
  final controller = useProvider<Param>();

  if (controller is Listenable) {
    return useListenableSelector(controller, () => selector(controller));
  }
  final selectedValue = selector(controller);

  return useMemoized(() => selectedValue, [selectedValue]);
}

abstract class Controller extends ChangeNotifier {}

class Provider<T> extends InheritedWidget {
  final T data;

  const Provider({
    super.key,
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant Provider<T> oldWidget) {
    return oldWidget.data != data;
  }

  static T of<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<Provider<T>>();

    if (provider == null) {
      throw FlutterError('The provider in Provider<$T> is null');
    }
    return provider.data;
  }

  static T? maybeOf<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<Provider<T>>();

    return provider?.data;
  }
}
