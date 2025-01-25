import 'package:flutter/material.dart';

abstract class SlidePartWidget extends StatefulWidget {
  const SlidePartWidget({
    super.key,
  });

  Widget build(BuildContext context);

  @override
  _SlidePartState<SlidePartWidget> createState() =>
      _SlidePartWidgetState<SlidePartWidget>();
}

class _SlidePartWidgetState<T extends SlidePartWidget>
    extends _SlidePartState<T> {
  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}

class _FixedSlidePartState extends _SlidePartState<FixedSlidePartWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Builder(builder: widget.build),
    );
  }
}

abstract class _SlidePartState<T extends SlidePartWidget> extends State<T> {
  @override
  Widget build(BuildContext context);
}

abstract class FixedSlidePartWidget extends SlidePartWidget {
  const FixedSlidePartWidget({super.key});

  double get height;

  @override
  _FixedSlidePartState createState() => _FixedSlidePartState();
}
