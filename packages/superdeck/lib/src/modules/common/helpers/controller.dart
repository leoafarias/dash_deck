import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Abstract Controller class extending ChangeNotifier
abstract class Controller extends ChangeNotifier {
  static Widget watch<T extends Controller>({
    required T controller,
    required Widget Function(BuildContext context) builder,
  }) {
    return Builder(builder: (context) {
      return ControllerListenableBuilder(
        controller: controller,
        builder: (context) => builder(context),
      );
    });
  }

  static Widget select<T extends Controller, Return>({
    required T controller,
    required Return Function(T) selector,
    required Widget Function(BuildContext context, Return value) builder,
  }) {
    return _ListeableBuilderSelector<T, Return>(
      listeable: controller,
      selector: selector,
      builder: builder,
    );
  }
}

class ControllerListenableBuilder<T extends Controller> extends StatefulWidget {
  const ControllerListenableBuilder({
    super.key,
    required this.controller,
    required this.builder,
  });

  final T controller;

  final Widget Function(BuildContext context) builder;

  @override
  State<ControllerListenableBuilder<T>> createState() =>
      _ControllerListenableBuilderState<T>();
}

class _ControllerListenableBuilderState<T extends Controller>
    extends State<ControllerListenableBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) => widget.builder(context),
    );
  }
}

class _ListeableBuilderSelector<T extends Listenable, Return>
    extends StatefulWidget {
  const _ListeableBuilderSelector({
    super.key,
    required this.listeable,
    required this.selector,
    required this.builder,
  });

  final T listeable;

  final Return Function(T) selector;

  final Widget Function(BuildContext context, Return value) builder;

  @override
  State<_ListeableBuilderSelector<T, Return>> createState() =>
      _ListeableBuilderSelectorState<T, Return>();
}

class _ListeableBuilderSelectorState<T extends Listenable, Return>
    extends State<_ListeableBuilderSelector<T, Return>> {
  late Return selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selector(widget.listeable);

    widget.listeable.addListener(_updateListeableValue);
  }

  @override
  void didUpdateWidget(_ListeableBuilderSelector<T, Return> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listeable != widget.listeable) {
      oldWidget.listeable.removeListener(_updateListeableValue);
      widget.listeable.addListener(_updateListeableValue);
      final newSelectedValue = widget.selector(widget.listeable);
      if (newSelectedValue != selectedValue) {
        setState(() {
          selectedValue = newSelectedValue;
        });
      }
    }
  }

  void _updateListeableValue() {
    final newValue = widget.selector(widget.listeable);
    if (newValue != selectedValue) {
      setState(() {
        selectedValue = newValue;
      });
    }
  }

  @override
  void dispose() {
    widget.listeable.removeListener(_updateListeableValue);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, selectedValue);
  }
}

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

  static T get<T>(BuildContext context) {
    final provider = maybeGet<T>(context);
    if (provider == null) {
      throw FlutterError('Provider of type $T not found in the widget tree');
    }
    return provider;
  }

  static T? maybeGet<T>(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<Provider<T>>()
        ?.widget as T?;
  }
}

T useController<T extends Controller>() {
  final context = useContext();

  return Provider.ofType<T>(context);
}

Return useControllerWatch<T extends Controller, Return>(
  Return Function(T) selector,
) {
  final controller = useController<T>();
  return useListenableSelector(controller, () => selector(controller));
}
