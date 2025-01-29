import 'package:flutter/material.dart';

class Provider<T> extends InheritedWidget {
  const Provider({
    super.key,
    required super.child,
    required this.value,
  });

  final T value;

  @override
  bool updateShouldNotify(covariant Provider<T> oldWidget) {
    return oldWidget.value != value;
  }

  static T? maybeTypeOf<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<Provider<T>>();
    return provider?.value;
  }

  static T ofType<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<Provider<T>>();
    if (provider == null) {
      throw FlutterError('Provider of type $T not found in the widget tree');
    }
    return provider.value;
  }
}
