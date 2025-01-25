import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mesh/mesh.dart';
import 'package:superdeck/superdeck.dart';

Color _colorFromHex(String hexString) {
  hexString = hexString.trim();
  if (hexString.isEmpty) {
    return Colors.black; // Default color if null or empty
  }
  hexString = hexString.replaceAll(RegExp(r'[^a-fA-F0-9]'), '');
  hexString = hexString.replaceAll('#', '');
  if (hexString.length == 6) {
    hexString = 'FF$hexString'; // Add opacity if not provided
  }
  return Color(int.parse(hexString, radix: 16));
}

OMeshRect _meshBuilder(List<Color> colors) {
  return OMeshRect(
    width: 3,
    height: 3,
    fallbackColor: const Color(0xff0e0e0e),
    backgroundColor: const Color(0x00d6d6d6),
    vertices: [
      (0.0, 0.0).v, (0.5, 0.0).v, (1.0, 0.0).v, // Row 1

      (0.0, 0.5).v, (0.5, 0.5).v, (1.0, 0.5).v, // Row 2

      (0.0, 1.0).v, (0.5, 1.0).v, (1.0, 1.0).v, // Row 3
    ],
    colors: colors,
  );
}

class BackgroundPart extends SlidePartWidget {
  const BackgroundPart({
    super.key,
  });

  int _getPreviousIndex(int currentSlideIndex, int slideCount) {
    if (currentSlideIndex > 0 && currentSlideIndex < slideCount - 1) {
      return currentSlideIndex - 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final controller = DeckController.of(context);

    return controller.watch(
        selector: (c) => (
              currentSlideIndex: c.currentSlideIndex,
              slideCount: c.slides.length
            ),
        builder: (context, value) {
          return _AnimatedSwitcherOMesh(
            colors: _determiniscOrderBasedOnIndex(value.currentSlideIndex),
            previousColors: _determiniscOrderBasedOnIndex(
              _getPreviousIndex(value.currentSlideIndex, value.slideCount),
            ),
            duration: const Duration(milliseconds: 1000),
          );
        });
  }
}

// animate bwett colors and previous colors in duration
class _AnimatedSwitcherOMesh extends StatefulWidget {
  final List<Color> colors;
  final List<Color> previousColors;
  final Duration duration;

  const _AnimatedSwitcherOMesh({
    required this.colors,
    required this.previousColors,
    required this.duration,
  });

  @override
  _AnimatedSwitcherOMeshState createState() => _AnimatedSwitcherOMeshState();
}

class _AnimatedSwitcherOMeshState extends State<_AnimatedSwitcherOMesh>
    with SingleTickerProviderStateMixin {
  late List<Color> _colors;

  @override
  void initState() {
    super.initState();
    _colors = widget.previousColors;

    Future.delayed(const Duration(milliseconds: 300), () {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _colors = widget.colors;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOMeshGradient(
      mesh: _meshBuilder(_colors),
      duration: widget.duration,
    );
  }
}

final _buildColors = [
  const Color.fromARGB(255, 5, 5, 28),
  const Color.fromARGB(255, 5, 5, 5),
  const Color.fromARGB(255, 3, 19, 48),
  const Color.fromARGB(255, 41, 12, 56),
  const Color.fromARGB(255, 5, 5, 5),
  const Color.fromARGB(255, 5, 5, 5),
  const Color.fromARGB(255, 17, 0, 63),
  const Color.fromARGB(255, 0, 0, 0),
  const Color.fromARGB(255, 5, 5, 5),
];
List<Color> _determiniscOrderBasedOnIndex(int index) {
  return _buildColors.sublist(index % _buildColors.length)
    ..addAll(_buildColors.sublist(0, index % _buildColors.length));
}
